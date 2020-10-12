//
//  ViewController.swift
//  VzahlebTest
//
//  Created by Anton Larchenko on 12.10.2020.
//

import UIKit

class ViewController: UIViewController {

    var coverModel = [CoverModel]()
    var imageModel = [ImageModel]()

    private let webManager = WebManager()
    @IBOutlet weak var coverTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        coverTableView.register(UINib(nibName: CoverCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: CoverCell.identifier)

        response()
    }
    
    func response() {
        webManager.loadCovers { [unowned self] (cover) in
            self.coverModel += cover
            DispatchQueue.main.async {
                self.coverTableView.reloadData()
            }
        }
    }


}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coverModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoverCell") as! CoverCell
        let model = coverModel[indexPath.row]
        let url = URL(string: model.image)
        
        func setupCell(image: UIImage) {
            cell.headerLabel.text = model.title
            cell.coverImageView.image = image
        }
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                cell.coverImageView.image = UIImage(data: data)
                model.publicImage = UIImage(data: data)
            }
        }.resume()
        
        if let image = model.publicImage {
            setupCell(image: image)
        } else {
            cell.task = URLSession.shared.dataTask(with: url!) { (data, urlResponse, error) in
                if let data = data, let imageData = UIImage(data: data) {
                    DispatchQueue.main.async {
                        setupCell(image: imageData)
                        model.publicImage = imageData
                    }
                }
            }
            cell.task?.resume()
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowDetail", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            if let indexPath = sender as? IndexPath {
                if let vc = segue.destination as? DetailViewController {
                    let model = coverModel[indexPath.row]
                    vc.publicImage = model.publicImage
                    model.delegate = vc

                    DispatchQueue.main.async {
                        vc.authorLabel.text = model.author
                        vc.descriptionTextView.text = model.description
                        vc.imageView.image = vc.publicImage
                    }
                    
                }
            }
        }
    }
    
}
