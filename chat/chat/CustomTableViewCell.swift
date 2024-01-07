//
//  CustomTableViewCell.swift
//  chat
//
//  Created by Nurkhan Tashimov on 03.11.2023.
//
import Foundation
import UIKit

class CustomTableViewCell: UITableViewCell {
    var myView = UIView()
    var messageConstraints: [NSLayoutConstraint] = []
    let sender: UILabel = {
        let label = UILabel()
//        label.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1.0, alpha: 1.0)
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    let message: UILabel = {
        let label = UILabel()
        label.textAlignment = .justified
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        if message.text?.count ?? 0 > 0{
//            setupViews()
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
//    func setupViews(person: String) {
//        NSLayoutConstraint.deactivate(messageConstraints)
//        if person == "Me" {
//            // Установить новые ограничения для случая "Me"
//            messageConstraints = [
//                message.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
//                message.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 12),
//            ]
//        } else {
//            // Установить новые ограничения для другого случая
//            messageConstraints = [
//                message.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
//                message.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -12),
//            ]
//        }
//        NSLayoutConstraint.activate(messageConstraints)
//        }
    func setup(dt:String,person:String){
        print(dt.count)
        if dt.count <= 28{
            message.text = " " + dt + " "
        }
        else{
            message.text = dt
        }
        sender.text = person
//        message.lineBreakMode = .byTruncatingTail
        self.contentView.addSubview(sender)
        self.contentView.addSubview(message)
        message.layer.cornerRadius = 5
        message.layer.masksToBounds = true
        message.preferredMaxLayoutWidth = 0.7 * UIScreen.main.bounds.width

        message.backgroundColor = UIColor(red: 0, green: 0.5, blue: 1.0, alpha: 0.7)
        NSLayoutConstraint.activate([
            message.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            message.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor, constant: -12),
            message.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 20),
//            message.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor),
//            message.centerYAnchor.constraint(equalTo: self.contentView.centerYAnchor),
            sender.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 12),
            sender.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -12),
        ])
        if sender.text == "Me"{
//            message.textAlignment = .right
            sender.textAlignment = .right
        }
        else{
//            message.textAlignment = .left
            sender.textAlignment = .left
        }
        NSLayoutConstraint.deactivate(messageConstraints)
        if person == "Me" {
            messageConstraints = [
                message.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
                message.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.leadingAnchor, constant: 12),
            ]
        } else {
            messageConstraints = [
                message.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
                message.trailingAnchor.constraint(lessThanOrEqualTo: contentView.trailingAnchor, constant: -12),
            ]
        }
        NSLayoutConstraint.activate(messageConstraints)
//        let attributedString = NSAttributedString(
//                    string: dt,
//                    attributes: [
//
//                        .foregroundColor: UIColor.black, // Цвет текста
//                        .font: UIFont.systemFont(ofSize: 16), // Шрифт текста
////                        .backgroundColor : UIColor(red: 0, green: 0.5, blue: 1.0, alpha: 0.7)
//                    ]
//                )
//        message.drawText(in: <#T##CGRect#>)
//        message.text = dt.padding(toLength: 10, withPad: "-", startingAt: 0)
        
//        message.attributedText = attributedString
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
//        message.backgroundColor = .white
//        print(message.numberOfLines)
//        print(message.layer.masksToBounds)
//        print(message.preferredMaxLayoutWidth)
        // Configure the view for the selected state
    }

}
