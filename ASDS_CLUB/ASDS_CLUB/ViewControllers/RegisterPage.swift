//
//  RegisterPage.swift
//  ASDS_CLUB
//
//  Created by Nurkhan Tashimov on 02.12.2023.
//

import UIKit
import FirebaseAuth
class RegisterPage: UIViewController {
    var registrationConstraints: [NSLayoutConstraint] = []
    var registerView = UIView()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let post = UITextField()
    let login = UITextField()
    let password = UITextField()
    let repeatPassword = UITextField()
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
        let title = setLabel(string: "Регистрация", size: 45)
        setConstraints(someLabel: title, x: 55  , y: Int(0.017 * screenHeight))
//        let loginLabel = setLabel(string: "Логин:", size: 20)
//        setConstraints(someLabel: loginLabel, x: 90, y: Int(0.108 * screenHeight))
//        login.borderStyle = .roundedRect
//        registerView.addSubview(login)
//        login.snp.makeConstraints{ login in
//            login.top.equalTo(registerView.safeAreaLayoutGuide).offset(0.144 * screenHeight)
////            login.leading.equalTo(registerView).offset(88)
//            login.centerX.equalToSuperview()
//            login.width.equalTo(0.529 * screenWidth)
//            login.height.equalTo(0.038 * screenHeight)
//        }
        let postLabel = setLabel(string: "Почта:", size: 20)
        setConstraints(someLabel: postLabel, x: 90, y: Int(0.108 * screenHeight))
        post.borderStyle = .roundedRect
        registerView.addSubview(post)
        post.snp.makeConstraints{ post in
            post.top.equalTo(registerView.safeAreaLayoutGuide).offset(0.144 * screenHeight)
//            post.leading.equalTo(registerView).offset(88)
            post.centerX.equalToSuperview()
            post.width.equalTo(0.529 * screenWidth)
            post.height.equalTo(0.038 * screenHeight)
        }
        let passwordLabel = setLabel(string: "Пароль:", size: 20)
        setConstraints(someLabel: passwordLabel, x: 90, y: Int(0.185 * screenHeight))
        password.borderStyle = .roundedRect
        password.isSecureTextEntry = true
//        password.autocapitalizationType = .none
        registerView.addSubview(password)
        password.snp.makeConstraints{ password in
            password.top.equalTo(registerView.safeAreaLayoutGuide).offset(0.221 * screenHeight)
//            password.leading.equalTo(registerView).offset(88)
            password.centerX.equalToSuperview()
            password.width.equalTo(0.529 * screenWidth)
            password.height.equalTo(0.038 * screenHeight)
        }
        let repeatPasswordLabel = setLabel(string: "Повторите пароль:", size: 20)
        setConstraints(someLabel: repeatPasswordLabel, x: 90, y: Int(0.259 * screenHeight))
        repeatPassword.borderStyle = .roundedRect
        repeatPassword.isSecureTextEntry = true
//        repeatPassword.autocapitalizationType = .none
        registerView.addSubview(repeatPassword)
        repeatPassword.snp.makeConstraints{ repeatPassword in
            repeatPassword.top.equalTo(registerView.safeAreaLayoutGuide).offset(0.293 * screenHeight)
//            repeatPassword.leading.equalTo(registerView).offset(88)
            repeatPassword.centerX.equalToSuperview()
            repeatPassword.width.equalTo(0.529 * screenWidth)
            repeatPassword.height.equalTo(0.038 * screenHeight)
        }
        let sendButton = UIButton()
        
        sendButton.backgroundColor = UIColor(red: 0.8, green: 0.52, blue: 0.845, alpha: 1)
        sendButton.layer.borderWidth = 1
        sendButton.layer.cornerRadius = 12
        sendButton.setTitle("Подтвердить", for: .normal)
        sendButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        sendButton.isUserInteractionEnabled = true
        sendButton.addTarget(self, action: #selector(sendPressed), for: .touchUpInside)
        
        registerView.addSubview(sendButton)
        sendButton.snp.makeConstraints{sendButton in
            sendButton.top.equalTo(registerView.safeAreaLayoutGuide).offset(0.339 * screenHeight)
//            sendButton.leading.equalTo(registerView).offset(119)
            sendButton.centerX.equalToSuperview()
            sendButton.width.equalTo(0.359 * screenWidth)
            sendButton.height.equalTo(0.04 * screenHeight)
        }
//        let backward = setLabel(string: "Войти", size: 20)
//        backward.isUserInteractionEnabled = true
//        let tapGestureBackward = UITapGestureRecognizer(target: self, action: #selector(backwardTapped(_:)))
//        backward.addGestureRecognizer(tapGestureBackward)
//        setConstraints(someLabel: backward, x: 167, y: 430)
        view.addSubview(registerView)
        registerView.snp.makeConstraints{registerView in
            registerView.top.equalTo(self.view.safeAreaLayoutGuide).offset(0.15 * screenHeight)
            registerView.width.equalTo(0.95 * screenWidth)
            registerView.height.equalTo(0.77 * screenHeight)
//            registerView.top.equalTo(self.view.safeAreaLayoutGuide).offset(100)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            tapGesture.cancelsTouchesInView = false
//        backward.addGestureRecognizer(tapGesture)

    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        // Закрыть клавиатуру
//        sendButton.snp.makeConstraints{sendButton in
//            sendButton.top.equalTo(view.safeAreaLayoutGuide).offset(478)
//            sendButton.leading.equalTo(view).offset(119)
//        }
        registerView.snp.updateConstraints{ registerView in
            registerView.top.equalTo(self.view.safeAreaLayoutGuide).offset(0.15 * screenHeight)
        }
        view.endEditing(true)
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 2.0) { [self] in
                registerView.snp.updateConstraints{ registerView in
                    registerView.top.equalTo(self.view.safeAreaLayoutGuide).offset(0.23 * screenHeight - keyboardSize.height)
                            
                        }
                    }
                }
        }

    @objc func keyboardWillHide(notification: Notification) {
        print("Hi")
        UIView.animate(withDuration: 2.0) { [self] in
            registerView.snp.updateConstraints{ registerView in
                registerView.top.equalTo(self.view.safeAreaLayoutGuide).offset(0.15 * screenHeight)

            }
        }
            

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
        if password.text == repeatPassword.text{
            if post.text != "" && password.text != ""{
                if post.text!.contains("@"){
                    Auth.auth().createUser(withEmail: post.text!, password: password.text!) { authResult, error in
                        // ...
                        //                        self.navigationController?.pushViewController(ConfirmPage(), animated: true)
                        if let user = Auth.auth().currentUser {
                            user.sendEmailVerification { error in
                                if let error = error {
                                    print("Error sending verification email: \(error.localizedDescription)")
                                } else {
                                    //                                    self.navigationController?.setViewControllers([CustomTabBar()], animated: true)
                                    //                                    self.navigationController?.popViewController(animated: true)
                                    let alertController = UIAlertController(title: "Подтверждение", message: "Вам на почту отправлено письмо. Пожалуйста, подтвердите регистрацию", preferredStyle: .alert)
                                    alertController.addAction(UIAlertAction(title: "OK", style: .default){_ in
                                        self.navigationController?.popViewController(animated: true)
                                    })
                                    self.present(alertController, animated: true, completion: nil)
                                    print("Verification email sent successfully.")
                                }
                            }
                        }
                    }
                    
                }
                else{
                    let alertController = UIAlertController(title: "Ошибка", message: "Почта не корректна", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    present(alertController, animated: true, completion: nil)
                }
            }
            else{
                let alertController = UIAlertController(title: "Ошибка", message: "Введите все данные", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                present(alertController, animated: true, completion: nil)
            }
        }
        else{
            let alertController = UIAlertController(title: "Ошибка", message: "Пароли не совпадают", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    func setLabel(string: String,size: Int) -> UILabel{
        let label = UILabel()
        label.text = string
        label.textColor = .white
        label.shadowColor = .black
        label.adjustsFontForContentSizeCategory = true
        label.font = UIFontMetrics.default.scaledFont(for: UIFont.boldSystemFont(ofSize: CGFloat(size)))
        label.shadowOffset = CGSize(width: 0, height: 4)
        registerView.addSubview(label)
        return label
    }
    func setConstraints(someLabel: UILabel, x: Int, y: Int){
        someLabel.snp.makeConstraints{someLabel in
            someLabel.top.equalTo(registerView.safeAreaLayoutGuide).offset(y)
//            someLabel.leading.equalTo(registerView).offset(x)
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
