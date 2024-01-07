//
//  CustomTableViewCell.swift
//  towns
//
//  Created by Nurkhan Tashimov on 26.10.2023.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    var initilized = false
    @IBOutlet weak var label: UILabel!
    //    @IBOutlet weak var text : UILabel!
    @IBOutlet weak var myImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    func setup(image: UIImage, text: String){
        initilized = true
        myImage.image = image
        label.text = text
    }
}
