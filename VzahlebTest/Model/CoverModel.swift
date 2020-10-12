//
//  ViewController.swift
//  VzahlebTest
//
//  Created by Anton Larchenko on 12.10.2020.
//

import Foundation
import UIKit

final class CoverModel: Codable {
    var textId: String
    var title: String
    var image: String
    var rating: Float
    var description: String
    var author: String
    
    var delegate: DetailViewControllerDelegate?
    
    var publicImage: UIImage? {
        didSet {
            self.delegate?.update(with: publicImage!)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case textId = "textId"
        case title = "title"
        case image = "image"
        case rating = "rating"
        case description = "description"
        case author = "author"
    }
}

struct ImageModel {
    var image: UIImage
}
