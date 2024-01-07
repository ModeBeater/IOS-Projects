//
//  SelectButton.swift
//  ASDS_CLUB
//
//  Created by Nurkhan Tashimov on 10.12.2023.
//

import UIKit
class SelectButton: UIButton {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let spacing: CGFloat = 8.0 // Adjust the spacing between image and text
        
        // MARK: Initializers
        required init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
            setupButton()
        }
        
        init(imageSize: CGSize) {
            super.init(frame: .zero)
            self.imageSize = imageSize
            setupButton()
        }
        
        // Customizable image size
        var imageSize: CGSize = CGSize(width: 50, height: 50) {
            didSet {
                setNeedsLayout()
            }
        }
        
        // MARK: Private Methods
        private func setupButton() {
            // Set the content alignment to center
            self.contentVerticalAlignment = .center
            self.contentHorizontalAlignment = .center
        }
        
        // MARK: Layout Subviews
        override func layoutSubviews() {
            super.layoutSubviews()
            
            if let titleLabel = self.titleLabel {
                // Center text
                titleLabel.frame.origin.x = (self.bounds.width - titleLabel.frame.width) / 2.0
                titleLabel.frame.origin.y = (self.bounds.height - titleLabel.frame.height - spacing) / 2.0 + 0.04 * screenHeight
                if self.bounds.height > 100{
                    titleLabel.frame.origin.y += 25
                }
            }
            
            if let imageView = self.imageView {
                // Center image
                imageView.frame.size = imageSize
//                imageView.frame.origin.x = (self.bounds.width - imageSize.width) / 2.0
//                imageView.frame.origin.y = (titleLabel?.frame.maxY)! + spacing
            }
        }

}
