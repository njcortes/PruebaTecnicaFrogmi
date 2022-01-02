//
//  NetworkingProvider.swift
//  pruebaTecnica
//
//  Created by Nestor Cortés on 02-01-22.
//

import Foundation
import Alamofire

final class NetworkingProvider {
    
    static let shared = NetworkingProvider()
    
    private var nextUrlStores = "https://api.frogmi.com/api/v3/stores?per_page=10"
    private let token = ""
    private let uuid = ""
    
    func getStores(success: @escaping (_ dataArr: DataArr) -> (),failure: @escaping (_ error: Error?) -> ()) {
        
        //let headers = HTTPHeaders( ["Authorization":"Bearer \(token)"])
        let headers: HTTPHeaders = ["X-Company-Uuid": "\(uuid)",
                           "Authorization": "Bearer \(token)"]
        
        AF.request(nextUrlStores, method: .get, headers: headers).validate(statusCode: 200..<600).responseJSON { response in
        
            switch (response.result){
                case .success:
                    print(response)
                    //var dataArr = [Data].self
                    guard let data = response.data else { return }
                    
                    do {
                        let decoder = JSONDecoder()
                        print("antes RES")
                        let res = try decoder.decode(DataArr.self, from: data)
                        print(res)
                        
                        
                        let links = try JSONDecoder().decode(Link.self, from: data)
                        self.nextUrlStores = (links.link?.next)!
                        print(links)
                        
                        
                        success(res)
                    } catch let error {
                        print(error)
                        failure(response.error)
                    }
                
                
                case .failure(let error):
                    failure(response.error)
                
            }
            

        }
    }
}
