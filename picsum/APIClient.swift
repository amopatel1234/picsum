//
//  APIClient.swift
//  picsum
//
//  Created by Freelance on 19/06/2018.
//  Copyright © 2018 Freelance. All rights reserved.
//

import Foundation
import UIKit

class APIClient {
    
    func loadImageFromURL(url: URL, completion: @escaping (UIImage) -> Void) {
        
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            if let imageData = data {
                if let image = UIImage(data: imageData) {
                    completion(image)
                }
            }
        }).resume()
    }
}
