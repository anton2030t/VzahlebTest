//
//  CoverCell.swift
//  VzahlebTest
//
//  Created by Anton Larchenko on 12.10.2020.
//

import UIKit

class CoverCell: UITableViewCell {

    var urlModel: String?
    var task: URLSessionDataTask?

    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    
    static let identifier = "CoverCell"
    
    override func prepareForReuse() {
        coverImageView.image = nil
        isHidden = false
        isSelected = false
        isHighlighted = false
        task?.cancel()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
