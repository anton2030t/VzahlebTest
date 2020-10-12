//
//  DetailViewController.swift
//  VzahlebTest
//
//  Created by Anton Larchenko on 12.10.2020.
//

import UIKit

protocol DetailViewControllerDelegate: class {
    func update(with image: UIImage)
}

class DetailViewController: UIViewController {
    
    var publicImage: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let oopsImage = UIImage(named: "oops")!
        imageView.image = publicImage ?? oopsImage
    }
    
}

extension DetailViewController: DetailViewControllerDelegate {
    func update(with image: UIImage) {
        guard isViewLoaded else { return }
        imageView.image = image
    }
}
