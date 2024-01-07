//
//  MainPage.swift
//  ASDS_CLUB
//
//  Created by Nurkhan Tashimov on 30.11.2023.
//

import UIKit

class MainPage: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        createPage()
        // Do any additional setup after loading the view.
    }
    func createPage(){
//        guard let navigationController = navigationController else {
//            print("Navigation controller is nil.")
//            return
//        }
//        
//        navigationController.setViewControllers([CustomTabBar()], animated: true)
        let backgroundImage = UIImageView(image: UIImage(named: "background"))
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
//        let newRootViewController = CustomTabBar()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
