//
//  ReservationCell.swift
//  ASDS_CLUB
//
//  Created by Nurkhan Tashimov on 12.12.2023.
//

import UIKit

class ReservationCell: UITableViewCell {
    let typeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()

    let startTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()

    let endTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    let dateLabel: UILabel = {
       let label = UILabel()
       label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)

       return label
   }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(typeLabel)
        addSubview(startTimeLabel)
        addSubview(endTimeLabel)
        addSubview(dateLabel)
        typeLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(8)
            make.centerY.equalToSuperview()
        }

        dateLabel.snp.makeConstraints { make in
            make.leading.equalTo(typeLabel.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }

        startTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(dateLabel.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
        }

        endTimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(startTimeLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.centerY.equalToSuperview()
        }
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
