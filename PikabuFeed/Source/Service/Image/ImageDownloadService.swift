//
//  ImageDownloadService.swift
//  PikabuFeed
//
//  Created by Nikita Rostovskii on 07.01.2021.
//

import UIKit

final class ImageDownloadService {
    
    private static let defaultImage = UIImage(named: "PreviewEmpty") ?? UIImage()
    
    static func loadImage(from urlString: String?, completion: @escaping (UIImage) -> Void) {
        guard let urlString = urlString, let url = URL(string: urlString) else {
            completion(defaultImage)
            return
        }
        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url),
               let image = UIImage(data: data) {
                
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(defaultImage)
                }
            }
            
        }
    }
}
