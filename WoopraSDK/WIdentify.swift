import Foundation
import UIKit

internal class WIdentify {
    
    private let wIdnetifyEndPoint = "https://www.woopra.com/track/identify"
    private let tracker: WTracker
    
    init(
        tracker: WTracker
    ) {
        self.tracker = tracker
    }
    
    func run() {
        guard let url = URL(string: wIdnetifyEndPoint) else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        var requestBody: [String: Any] = [
            "host": tracker.domain ?? "",
            "cookie": tracker.visitor.cookie,
            "app": "ios",
            "response": "xml",
            "os": "\(UIDevice.current.systemName) \(UIDevice.current.systemVersion)",
            "timeout": Int(
                tracker.idleTimeout * 1000
            ),
        ]
        
        let visitorProperties = tracker.visitor.properties
        for ( key, value ) in visitorProperties {
            requestBody["cv_\(key)"] = value
        }
        
        if  JSONSerialization.isValidJSONObject(requestBody) == false {
            print("Error: Request body contains invalid values for JSON serialization.")
            return
        }
        
        // Convert requestBody to JSON data
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody, options:[])
            request.httpBody = jsonData
            
            #if DEBUG
            if let requestBodyString = String(data: jsonData, encoding: .utf8) {
                print("Request Body: \(requestBodyString)")
            }
            #endif
        } catch {
            print("Error converting request body to JSON:\(error.localizedDescription)")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) {
            (data, response, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard data != nil else {
                print("Error: No response data")
                return
            }
            
            #if DEBUG
            if let httpResponse = response as? HTTPURLResponse {
                print("Response: \(httpResponse.statusCode)")
            }
            #endif
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
