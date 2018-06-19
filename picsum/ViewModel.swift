//
//  ViewModel.swift
//  picsum
//
//  Created by Freelance on 19/06/2018.
//  Copyright © 2018 Freelance. All rights reserved.
//

import Foundation
import UIKit

enum ViewState {
    case loading
    case error
    case none
}

class ViewModel: NSObject {
    
    var viewState = ViewState.none {
        didSet {
            NotificationCenter.default.post(name: NSNotification.Name("viewStateChanged"), object: nil)
        }
    }
    let apiClient = APIClient()
    var loadCount = 0
    
    let loadingString = "Loading"
    let errorString = "Oh noooo"
    
    private let randomImageURL = URL(string: "https://picsum.photos/200/300/?random")
    private let errorImageURL = URL(string: "https://vignette.wikia.nocookie.net/familyguy/images/1/14/Bruce.png/revision/latest?cb=20130420174101&amp;path-prefix=de")
        
    func getImage(completion: @escaping (UIImage) -> Void) {
        
        if loadCount < 4 {
            viewState = .loading
            
            apiClient.loadImageFromURL(url: randomImageURL!) {[weak self] (image) in
                DispatchQueue.main.async {
                    completion(image)
                    self?.viewState = .none
                    self?.loadCount += 1
                }
            }
        } else {
            errorOut()
            apiClient.loadImageFromURL(url: errorImageURL!) { (image) in
                DispatchQueue.main.async {
                    completion(image)
                }
            }
        }
    }
    
    func errorOut() {
        loadCount = 0
        viewState = .error
    }
    
}
