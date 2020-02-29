//
//  RequestManager.swift
//  meTube
//
//  Created by Felipe Amorim Bastos on 29/02/20.
//  Copyright © 2020 Felipe Amorim Bastos. All rights reserved.
//

import Foundation
import Alamofire

class RequestManager {
    
    static func getVideos(title: String, pageToken: String,completion: @escaping ( _ response: [Items], _ response: String) -> Void){
    
        let param = ["key" : "AIzaSyC59Uj54KDRCuONXTdB5VPq30H1yy9I0KI",
                     "part" : "snippet",
                     "q" : title,
                     "maxResults" : "10",
                     "type" : "video",
                     "pageToken" : pageToken
        ]
        
        Alamofire.request("https://www.googleapis.com/youtube/v3/search?",
                          method: .get,
                          parameters: param,
                          headers: nil).responseJSON { response in
                            
                            switch response.result {
                            case.success:
                                
                                if let jsonData = response.data {
                                    
                                    do {
                                        
                                        let apiAnswer = try JSONDecoder.init().decode(Json4Swift_Base.self, from: jsonData)
                                        let videosDetail = apiAnswer.items
                                        let nextPageToken = apiAnswer.nextPageToken
                                        
                                        completion(videosDetail!, nextPageToken ?? "")
                                    }catch{
                                        completion([], "")
                                    }
                                }
                                break
                            case.failure:
                                completion([], "")
                                break
                            }
                        }
    }
}
