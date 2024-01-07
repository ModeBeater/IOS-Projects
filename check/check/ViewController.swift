//
//  ViewController.swift
//  check
//
//  Created by Nurkhan Tashimov on 16.11.2023.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        super.view.backgroundColor = .gray
        // Do any additional setup after loading the view.
//        var view = UIView()
//        let imageView = UIImageView()
//        imageView.image = UIImage(named: "PS")
//
//        // Установка размеров и положения UIImageView
//        imageView.frame = CGRect(x: 50, y: 50, width: 200, height: 200)
//        var label = UILabel()
//        label.text = "HI"
////        label.backgroundColor = .red
//        label.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
//        label.textColor = UIColor.black
////        super.view.addSubview(label)
//        // Добавление UIImageView на экран
//
//        view.addSubview(label)
//        view.addSubview(imageView)
//        view.frame = CGRect(x: 100, y: 100, width: 60, height: 46.39)
//        let image0 = UIImage(named: "PS")?.withRenderingMode(.alwaysTemplate)
//        let imageView = UIImageView(image: image0)
//        imageView.tintColor = .white
//        layer0.contents = image0
//        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 1, b: 0, c: 0, d: 1, tx: 0, ty: 0))
//        layer0.bounds = view.bounds
//        layer0.position = view.center
//        view.layer.addSublayer(layer0)
        view.addSubview(fillWhiteImage(name: "PS"))
        

    }


}
func fillWhiteImage(name: String) -> UIImageView{
    let image0 = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
    let imageView = UIImageView(image: image0)
    imageView.tintColor = .white
    return imageView
}

