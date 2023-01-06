//
//  ViewController.swift
//  NetworkingExample
//
//  Created by rakeshDeshaboina on 05/01/23.
//

import UIKit

class ViewController: UIViewController {
    let comp = cardManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        comp.getCardResponseData { result in
            print(result)
        } failure: { error in
            print(error)
        }
       // getDetails()

        // Do any additional setup after loading the view.
    }
    func getDetails(){
        let url = URL(string: "https://db.ygoprodeck.com/api/v7/cardinfo.php")
        var urlRequest = URLRequest(url: url!)
        urlRequest.allHTTPHeaderFields = Environment.Development.header
        urlRequest.httpMethod = "GET"
        
        let session = URLSession.shared
        let datatask = session.dataTask(with: urlRequest){
            (data,response,error) in
            let decode = JSONDecoder()
            let result = try! decode.decode(CardModel.self, from: data!)
            print(result)
        }
        datatask.resume()
        
    }


}

