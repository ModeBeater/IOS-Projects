//
//  ConfirmPage.swift
//  ASDS_CLUB
//
//  Created by Nurkhan Tashimov on 04.12.2023.
//

import UIKit

class ConfirmPage: UIViewController {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    override func viewDidLoad() {
        super.viewDidLoad()
        createPage()
        // Do any additional setup after loading the view.
    }
    func createPage(){
//        navigationItem.hidesBackButton = true
        let backgroundImage = UIImageView(image: UIImage(named: "background"))
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        let title = setLabel(string: "Подтверждение", size: 40)
        setConstraints(someLabel: title, x: 39, y: Int(0.15 * screenHeight))
        let codeLabel = setLabel(string: "Код:", size: 20)
        setConstraints(someLabel: codeLabel, x: 90, y: Int(0.214 * screenHeight))
        let code = UITextField()
        code.borderStyle = .roundedRect
        view.addSubview(code)
        code.snp.makeConstraints{ code in
            code.top.equalTo(view.safeAreaLayoutGuide).offset(0.25 * screenHeight)
//            code.leading.equalTo(view).offset(88)
            code.centerX.equalToSuperview()
            code.width.equalTo(0.529 * screenWidth)
            code.height.equalTo(0.038 * screenHeight)
        }
        let sendButton = UIButton()
        
        sendButton.backgroundColor = UIColor(red: 0.8, green: 0.52, blue: 0.845, alpha: 1)
        sendButton.layer.borderWidth = 1
        sendButton.layer.cornerRadius = 12
        sendButton.setTitle("Подтвердить", for: .normal)
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        sendButton.isUserInteractionEnabled = true
        sendButton.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        view.addSubview(sendButton)
        sendButton.snp.makeConstraints{sendButton in
            sendButton.top.equalTo(view.safeAreaLayoutGuide).offset(0.306 * screenHeight)
//            sendButton.leading.equalTo(view).offset(101)
            sendButton.centerX.equalToSuperview()
            sendButton.width.equalTo(0.466 * screenWidth)
            sendButton.height.equalTo(0.041 * screenHeight)
        }
//        let backward = setLabel(string: "Вернуться назад", size: 20)
//        backward.isUserInteractionEnabled = true
//        let tapGestureBackward = UITapGestureRecognizer(target: self, action: #selector(backwardTapped(_:)))
//        backward.addGestureRecognizer(tapGestureBackward)
//        setConstraints(someLabel: backward, x: 112, y: 314)
    }
    @objc func backwardTapped(_ sender: UITapGestureRecognizer) {
        print("UILabel был нажат!")
        guard let navigationController = navigationController else {
            print("Navigation controller is nil.")
            return
        }
        navigationController.popViewController(animated: true)
//        navigationController.pushViewController(RegisterPage(), animated: true)
    }
    @objc func sendPressed() {
        print("Button pressed!")
        guard let navigationController = navigationController else {
            print("Navigation controller is nil.")
            return
        }
        
        navigationController.setViewControllers([CustomTabBar()], animated: true)
    }
    func setLabel(string: String,size: Int) -> UILabel{
        let label = UILabel()
        label.text = string
        label.textColor = .white
        label.shadowColor = .black
        label.font = UIFont.boldSystemFont(ofSize: CGFloat(size))
        label.shadowOffset = CGSize(width: 0, height: 4)
        view.addSubview(label)
        return label
    }
    func setConstraints(someLabel: UILabel, x: Int, y: Int){
        someLabel.snp.makeConstraints{someLabel in
            someLabel.top.equalTo(view.safeAreaLayoutGuide).offset(y)
//            someLabel.leading.equalTo(view).offset(x)
            someLabel.centerX.equalToSuperview()
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

}
