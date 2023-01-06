//
//  APIManager.swift
//  NetworkingExample
//
//  Created by rakeshDeshaboina on 05/01/23.
//

import Foundation

class cardManager:RequestProtocol{
    var path: String = "cardinfo.php"
    var method: HttpMethod = HttpMethod.get
    var parameter: parameters = [:]
    var serviceRequest = APIService<CardModel>()
    
    func getCardResponseData(success:@escaping(CardModel)->(), failure:@escaping(_ error: String)->Void){
        serviceRequest.execute(urlrequest: urlRequest()) { result in
            switch result {
            case .success(let response):
                success(response as! CardModel)
            case .failure(let error):
                failure(error.localizedDescription)
                
            }
        }
    }
    
}
