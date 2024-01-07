//
//  ViewController.swift
//  ASDS_CLUB
//
//  Created by Nurkhan Tashimov on 27.11.2023.
//

import UIKit
import SnapKit
import FirebaseAuth
class ViewController: UIViewController {
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let login = UITextField()
    let password = UITextField()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        createLoginPage()
    }
    func createLoginPage(){
        let backgroundImage = UIImageView(image: UIImage(named: "background"))
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        let enter = setLabel(string: "Вход", size: 45)
        setConstraints(someLabel: enter, x: Int(0.342 * screenWidth), y: Int(0.134 * screenHeight))
        let loginLabel = setLabel(string: "Почта:", size: 20)
        setConstraints(someLabel: loginLabel, x: Int(0.220 * screenWidth), y: Int(0.204 * screenHeight))
        let forgotPassword = setLabel(string: "Забыл пароль", size: 20)
        forgotPassword.isUserInteractionEnabled = true
        let tapGestureForgot = UITapGestureRecognizer(target: self, action: #selector(forgotTapped(_:)))
        forgotPassword.addGestureRecognizer(tapGestureForgot)
        setConstraints(someLabel: forgotPassword, x: Int(0.306 * screenWidth), y: Int(0.447 * screenHeight))
        let register = setLabel(string: "Зарегистрироваться", size: 20)
        register.isUserInteractionEnabled = true
        let tapGestureRegister = UITapGestureRecognizer(target: self, action: #selector(registerTapped(_:)))
        register.addGestureRecognizer(tapGestureRegister)
        setConstraints(someLabel: register, x: Int(0.226 * screenWidth), y: Int(0.492 * screenHeight))
        login.borderStyle = .roundedRect
        view.addSubview(login)
        login.snp.makeConstraints{ login in
            login.top.equalTo(view.safeAreaLayoutGuide).offset(0.250 * screenHeight)
//            login.leading.equalTo(view).offset(0.1 * screenHeight)
            login.width.equalTo(0.529 * screenWidth)
            login.height.equalTo(0.038 * screenHeight)
            login.centerX.equalToSuperview()
        }
        let passwordLabel = setLabel(string: "Пароль:", size: 20)
        setConstraints(someLabel: passwordLabel, x: Int(0.218 * screenWidth), y: Int(0.296 * screenHeight))
        password.borderStyle = .roundedRect
        password.isSecureTextEntry = true
        password.autocapitalizationType = .none
        view.addSubview(password)
        password.snp.makeConstraints{ password in
            password.top.equalTo(view.safeAreaLayoutGuide).offset(0.335 * screenHeight)
//            password.leading.equalTo(view).offset(0.213 * screenWidth)
            password.width.equalTo(0.529 * screenWidth)
            password.height.equalTo(0.038 * screenHeight)
            password.centerX.equalToSuperview()
        }
        let enterButton = UIButton()
        
        enterButton.backgroundColor = UIColor(red: 0.8, green: 0.52, blue: 0.845, alpha: 1)
        enterButton.layer.borderWidth = 1
        enterButton.layer.cornerRadius = 12
        enterButton.setTitle("Войти", for: .normal)
        enterButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        enterButton.isUserInteractionEnabled = true
        enterButton.addTarget(self, action: #selector(enterPressed), for: .touchUpInside)
        
        view.addSubview(enterButton)
        enterButton.snp.makeConstraints{enterButton in
            enterButton.top.equalTo(view.safeAreaLayoutGuide).offset(0.387 * screenHeight)
//            enterButton.leading.equalTo(view).offset(0.286 * screenWidth)
            enterButton.centerX.equalToSuperview()
//            enterButton.center.equalToSuperview()
            enterButton.width.equalTo(0.386 * screenWidth)
            enterButton.height.equalTo(0.041 * screenHeight)
        }
    }
    @objc func enterPressed() {
        print("Button pressed!")
        if login.text != ""{
            if password.text != ""{
                Auth.auth().signIn(withEmail: login.text!, password: password.text!) { [weak self] authResult, error in
                guard let strongSelf = self else { return }
                
                if let error = error {
                    // Handle authentication error
                    print("Authentication error: \(error.localizedDescription)")
                    // You might want to present an alert to the user or take appropriate action
                    let alertController = UIAlertController(title: "Ошибка", message: "Неверные данные", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.present(alertController, animated: true, completion: nil)
                    return
                }
                if let user = Auth.auth().currentUser {
                    if user.isEmailVerified {
                        self?.navigationController?.setViewControllers([CustomTabBar()], animated: true)
                    } else {
                        // User's email is not verified.
                        // You can prompt the user to check their email for verification.
                        let alertController = UIAlertController(title: "Подтверждение", message: "Вам на почту отправлено письмо. Пожалуйста, подтвердите регистрацию", preferredStyle: .alert)
                        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self?.present(alertController, animated: true, completion: nil)
                    }
                }
                // Authentication successful
                print("User successfully signed in: \(authResult?.user.uid ?? "")")
                // Navigate to the next screen or perform any other actions
                }
            }
            else{
                let alertController = UIAlertController(title: "Ошибка", message: "Введите пароль", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertController, animated: true, completion: nil)
            }
        }
        else{
            let alertController = UIAlertController(title: "Ошибка", message: "Введите почту", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    
    }
    @objc func forgotTapped(_ sender: UITapGestureRecognizer) {
        print("UILabel был нажат!")
        guard let navigationController = navigationController else {
            print("Navigation controller is nil.")
            return
        }
        navigationController.pushViewController(ForgotPasswordPage(), animated: true)
    }
    @objc func registerTapped(_ sender: UITapGestureRecognizer) {
        print("UILabel был нажат!")
        guard let navigationController = navigationController else {
            print("Navigation controller is nil.")
            return
        }
        navigationController.pushViewController(RegisterPage(), animated: true)
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
}

