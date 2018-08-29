//
//  ImageLibrary.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-08-29.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation
import UIKit

let imageCache = URLCache(memoryCapacity: 10, diskCapacity: 10, diskPath: nil)

class ImageLibrary {
    
    func fetch(from url: URL, completion: @escaping(UIImage) -> Void) {
        let request = URLRequest(url: url)
        if let image = imageCache.cachedResponse(for: request){
            completion(UIImage(data: image.data)!)
        } else {
            URLSession.shared.dataTask(with: url){ (data, response, error) in
                guard let data = data else { return }
                let cache = CachedURLResponse(response: response!, data: data)
                imageCache.storeCachedResponse(cache, for: request)
                let image = UIImage(data: data)!
                completion(image)
                }.resume()
        }
    }
}
