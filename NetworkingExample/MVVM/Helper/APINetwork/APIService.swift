//
//  APIService.swift
//  NetworkingExample
//
//  Created by rakeshDeshaboina on 05/01/23.
//

import Foundation
import UIKit

enum HttpMethod:String {
    case post = "POST"
    case get = "GET"
}
enum APIResult<T> {
case success(T)
    case failure(failResponse)
}
enum failResponse:Error{
    case InvaliedResponse
    case NoDataFoundResponse
    case ErrorResponse
}
protocol EvironemetalProtocol {
    var baseUrl:String{get}
    var header:[String:String]{get}
}
enum Environment:EvironemetalProtocol {
    case Development
        case Production
    
    var baseUrl: String{
        switch self {
        case .Development:
            return "https://db.ygoprodeck.com/api/v7/"
        case .Production:
            return ""
        }
    }
    
    var header: [String : String]{
        switch self{
        case .Development:
            return ["Content-Type":"application/json"]
        case .Production:
            return ["":""]
        }
    }
    

}
typealias parameters = [String:Any]
protocol RequestProtocol {
    var path:String{get}
    var method:HttpMethod{get}
    var parameter:parameters{get}
}

protocol NetworkProtocol{
    associatedtype T: Decodable
    func decode(_ data:Data)-> T?
    func execute(urlrequest:URLRequest?, complition:@escaping(APIResult<Any>)->Void)
}
class APIService<T:Decodable>:NetworkProtocol{
    func decode(_ data: Data) -> T? {
        print(T.self)
        let jsonDecoder = JSONDecoder()
        let result = try! jsonDecoder.decode(T.self, from: data)
        do {
            let re = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            let result = try jsonDecoder.decode(T.self, from: data)
            return result
        } catch let error {
            return nil
        }
    }
    
    func execute(urlrequest: URLRequest?, complition: @escaping (APIResult<Any>) -> Void) {
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: urlrequest!){
            (data,response,error) in
            guard  error == nil else {
                return complition(APIResult.failure(.ErrorResponse))
            }
            guard  let data = data else {
                return complition(APIResult.failure(.NoDataFoundResponse))
            }
            print(data,error,response)
            let jsonResponse = self.decode(data)
            guard jsonResponse != nil else {
                return complition(APIResult.failure(.InvaliedResponse))
            }
            complition(APIResult.success(jsonResponse as Any) )
            
        }
        dataTask.resume()
    }
    
    
}
extension RequestProtocol{
    func url(baseUrl:String)-> URL? {
        guard var urlComponents = URLComponents.init(string: baseUrl) else {
            return nil
        }
        urlComponents.path = urlComponents.path + path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }
    var queryItems : [URLQueryItem]? {
        guard  method == HttpMethod.post else {
            return nil
        }
        let queryParameter = parameter.map { (key: String, value: Any) -> URLQueryItem in
            let valueString = String(describing: value)
            return URLQueryItem(name: key, value: valueString)
        }
        return queryParameter
    }
    var jsonBody : Data? {
        guard method == HttpMethod.get else {
            return nil
        }
        let jsonParameters = parameter.reduce("") { partialResult, value in
            return partialResult + "&\(value.key)=\(value.value)"
        }.data(using: .utf8)
        return jsonParameters
    }
    func urlRequest()-> URLRequest? {
        guard  let url = url(baseUrl: Environment.Development.baseUrl) else {
            return nil
        }
        print(url)
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = Environment.Development.header
        request.httpBody = jsonBody
        return request
        
    }
}
