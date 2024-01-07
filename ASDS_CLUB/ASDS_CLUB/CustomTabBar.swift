//
//  CustomTabBar.swift
//  ASDS_CLUB
//
//  Created by Nurkhan Tashimov on 04.12.2023.
//

import UIKit
import Foundation
import SnapKit
class CustomTabBar: UITabBarController {

    override func viewDidLoad() {
//            super.viewDidLoad()
            generateTabBar()
//            selectedIndex = -1
//            setTabBarAppearance()
        }

    func generateTabBar() {
        
//        view.backgroundColor = .black
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        let vc1 = StandardRoom()
        vc1.tabBarItem = UITabBarItem(title: "Standard", image: fillWhiteImage(name: "PC"), tag: 0)

        let vc2 = VipRoom()
        vc2.tabBarItem = UITabBarItem(title: "VIP", image: fillWhiteImage(name: "VIP"), tag: 1)

        let vc3 = PSRoom()
        vc3.tabBarItem = UITabBarItem(title: "Playstation", image: fillWhiteImage(name: "PS"), tag: 2)

        let vc4 = RetroRoom()
        vc4.tabBarItem = UITabBarItem(title: "Retro", image: fillWhiteImage(name: "Retro"), tag: 3)

        let vc5 = PartyRoom()
        vc5.tabBarItem = UITabBarItem(title: "Party room", image: fillWhiteImage(name: "Party"), tag: 4)

        // Add more view controllers as needed

        viewControllers = [vc1, vc2, vc3, vc4, vc5]
        for tabBarItem in tabBar.items ?? [] {
            tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 16)
        }
        // Set constraints for the size of tab bar items
        for (index, viewController) in viewControllers!.enumerated() {
            if let tabBarItem = viewController.tabBarItem {
                let itemWidth: CGFloat = 0.152 * screenWidth
                let itemHeight: CGFloat = 0.048 * screenHeight

                let imageView = UIImageView(image: tabBarItem.image)
                imageView.tintColor = .white
                imageView.contentMode = .scaleAspectFit
                tabBar.addSubview(imageView)
                
                imageView.snp.makeConstraints { make in
                    make.centerX.equalTo(tabBar.snp.centerX).multipliedBy((2.0 * CGFloat(index) + 1.0) / CGFloat(viewControllers!.count ))
                    make.centerY.equalTo(tabBar.snp.centerY).offset(-(0.024 * screenWidth))  // Adjust the vertical position as needed
                    make.width.equalTo(itemWidth)
                    make.height.equalTo(itemHeight)
                }
                viewController.tabBarItem.image = nil
            }
        }
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: -10, width: tabBar.frame.size.width, height: 1.0)
        topBorder.backgroundColor = UIColor.white.cgColor
        tabBar.layer.addSublayer(topBorder)
        if let items = tabBar.items {
            
            for item in items {
                // Set text color for normal state
                item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)], for: .normal)
                // Set text color for selected state
                item.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 0.518, green: 0.647, blue: 0.98, alpha: 1), NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 13)], for: .selected)
            }
        }
//        let lineView = UIView()
//        lineView.backgroundColor = .white // Set the color of the line
//        tabBar.addSubview(lineView)
        let profile = UIButton()
       profile.setImage(UIImage(named: "profile"), for: .normal)
       profile.imageView?.contentMode = .scaleAspectFit
       profile.addTarget(self, action: #selector(openProfile), for: .touchUpInside)
       view.addSubview(profile)

       // Disable user interaction for the navigation bar
       navigationController?.navigationBar.isUserInteractionEnabled = false

       // Add a tap gesture recognizer to the navigation bar
       let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(openProfile))
       navigationController?.navigationBar.addGestureRecognizer(tapGestureRecognizer)

       // Enable user interaction for the profile button
       profile.isUserInteractionEnabled = true

       // Set up constraints for the profile button
       profile.snp.makeConstraints { make in
           make.width.equalTo(0.1844 * screenWidth)
           make.height.equalTo(0.0992 * screenHeight)
           make.leading.equalTo(view.safeAreaLayoutGuide).offset(0.769 * screenWidth)
           make.top.equalTo(view.safeAreaLayoutGuide).offset(-15)
       }

       // Set up constraints for the line view
//       lineView.snp.makeConstraints { make in
////           make.top.equalTo(tabBar.snp.top)
////           make.bottom.equalTo(tabBar).offset(10)
//           make.leading.trailing.equalTo(tabBar)
//           make.height.equalTo(1.0) // Set the height of the line
//       }
    }
    func fillWhiteImage(name: String) -> UIImage{
        let image0 = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
//        let imageView = UIImageView(image: image0)
//        imageView.tintColor = .white
        return image0!
    }
    @objc func openProfile(_ sender: UIButton) {
        let bookPageVC = BooksViewController()
            
        // Set hidesBottomBarWhenPushed to true to hide the tab bar when pushing this view controller
        bookPageVC.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(bookPageVC, animated: true)
    }
}

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


