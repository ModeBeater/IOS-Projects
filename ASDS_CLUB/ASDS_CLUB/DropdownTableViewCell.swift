//
//  DropdownTableViewCell.swift
//  ASDS_CLUB
//
//  Created by Nurkhan Tashimov on 07.12.2023.
//

import UIKit

class DropdownTableViewCell: UITableViewCell {

    static let reuseIdentifier = "DropdownTableViewCell"
        
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup() {
        contentView.addSubview(label)
        label.snp.makeConstraints{label in
            label.leading.equalTo(contentView).offset(8)
            label.trailing.equalTo(contentView).offset(-8)
            
        }
    }
    
    func set(_ text: String) {
        label.text = text
    }

}
