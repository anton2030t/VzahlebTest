//
//  ViewController.swift
//  VzahlebTest
//
//  Created by Anton Larchenko on 12.10.2020.
//


import Foundation
import UIKit

class WebManager {
    
    func loadCovers(completion: @escaping ([CoverModel])->()) {
        
        let url = URL(string: "https://pivl.github.io/sample_api/covers/")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            guard let data = data else { return }
            
            do {
                let cover = try JSONDecoder().decode([CoverModel].self, from: data)
                completion(cover)
                print(cover)
            } catch let error {
                print(error)
            }
            
        }.resume()
    }
    
//    func imageURL(textId: String) -> String {
//        return "https://bmap-addicted-stories.eu-central-1.linodeobjects.com/images/\(textId)/cover-original.jpg"
//    }
//
//    func loadImage(textId: String, completion: @escaping (ImageModel)->()) {
//        guard let url = URL(string: imageURL(textId: textId)) else { return }
//
//        URLSession.shared.dataTask(with: url) { (data, response, error) in
//            guard let data = data else { return }
//
//            let images = ImageModel(image: (UIImage(data: data) ?? UIImage(named: "oops"))!)
//            completion(images)
//
//        }.resume()
//    }
    
}
