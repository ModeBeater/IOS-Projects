//
//  ForgotPasswordPage.swift
//  ASDS_CLUB
//
//  Created by Nurkhan Tashimov on 02.12.2023.
//

import UIKit
import FirebaseAuth
class ForgotPasswordPage: UIViewController {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let post = UITextField()
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
        let title = setLabel(string: "Восстановление", size: 40)
        setConstraints(someLabel: title, x: Int(0.094 * screenWidth), y: Int(0.15 * screenHeight))
        let postLabel = setLabel(string: "Почта:", size: 20)
        setConstraints(someLabel: postLabel, x: 90, y: Int(0.214 * screenHeight))
        post.borderStyle = .roundedRect
        view.addSubview(post)
        post.snp.makeConstraints{ post in
            post.top.equalTo(view.safeAreaLayoutGuide).offset(0.25 * screenHeight)
//            post.leading.equalTo(view).offset(88)
            post.centerX.equalToSuperview()
            post.width.equalTo(0.529 * screenWidth)
            post.height.equalTo(0.038 * screenHeight)
        }
        let sendButton = UIButton()
        
        sendButton.backgroundColor = UIColor(red: 0.8, green: 0.52, blue: 0.845, alpha: 1)
        sendButton.layer.borderWidth = 1
        sendButton.layer.cornerRadius = 12
        sendButton.setTitle("Отправить код", for: .normal)
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
//    @objc func backwardTapped(_ sender: UITapGestureRecognizer) {
//        print("UILabel был нажат!")
//        guard let navigationController = navigationController else {
//            print("Navigation controller is nil.")
//            return
//        }
//        navigationController.popViewController(animated: true)
////        navigationController.pushViewController(RegisterPage(), animated: true)
//    }
    @objc func sendPressed() {
        if let email = post.text {
            Auth.auth().sendPasswordReset(withEmail: email) { error in
                if let error = error {
                    // Handle the error
                    print("Password reset error: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Ошибка", message: "Не получилось отправить письмо", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true, completion: nil)
                } else {
                    // Password reset email sent successfully
                    print("Password reset email sent successfully.")
                    let alertController = UIAlertController(title: "Подтверждение", message: "Вам на почту отправлено письмо. Пожалуйста, подтвердите регистрацию", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default){_ in
                        self.navigationController?.popViewController(animated: true)
                    })
                    self.present(alertController, animated: true, completion: nil)
//                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        print("Button pressed!")
//        guard let navigationController = navigationController else {
//            print("Navigation controller is nil.")
//            return
//        }
//        navigationController.popViewController(animated: true)
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
