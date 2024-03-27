import Foundation

public class WIdentify {
    
    private let wIdnetifyEndPoint = "https://www.woopra.com/track/identify"
    private let tracker: WTracker
    
    init(
        tracker: WTracker
    ) {
        self.tracker = tracker
    }
    
    func run() {
        let url = URL(string: wIdnetifyEndPoint)!
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        
        var requestBody: [String: Any] = [
            "host": tracker.domain ?? "",
            "cookie": tracker.visitor.cookie,
            "app": "ios",
            "response": "xml",
            "os": "ios",
            "timeout": Int(
                tracker.idleTimeout * 1000
            ),
        ]
        
        let visitorProperties = tracker.visitor.properties
        for ( key, value ) in visitorProperties {
            requestBody["cv_\(key)"] = value
        }
        
        urlRequest.httpBody = try? JSONSerialization.data(
            withJSONObject: requestBody,
            options: []
        )
        urlRequest.setValue(
            "application/json",
            forHTTPHeaderField: "Content-Type"
        )
        
        print("Request Body: \(requestBody)")
        
        let task = URLSession.shared.dataTask(with: urlRequest) {
            (
                data,
                response,
                error
            ) in
            if let error = error {
                print(
                    "Got error: \(error)"
                )
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print(
                    "Response: \(httpResponse.statusCode)"
                )
            }
        }
        
        task.resume()
    }
}

extension String {
    var urlEncoded: String {
        return addingPercentEncoding(
            withAllowedCharacters: .urlQueryAllowed
        ) ?? ""
    }
}
