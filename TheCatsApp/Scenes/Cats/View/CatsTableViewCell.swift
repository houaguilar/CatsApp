//
//  CatsTableViewCell.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23..
//

import UIKit

class CatsTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var contentCardView: UIView!
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var originLabel: UILabel!
    @IBOutlet weak var intelligenceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentCardView.layer.borderWidth = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func displayCell(name: String, image: String?, origin: String, intelligence: String) {
        nameLabel.text = name
        if let urlImage = image {
            let placeHolder = #imageLiteral(resourceName: "placeholderCats")
            catImage.sd_setImage(with: URL(string: urlImage)!, placeholderImage: placeHolder)
            catImage.contentMode = .scaleAspectFit
        }

        originLabel.text = origin
        intelligenceLabel.text = intelligence
        
    }
}
