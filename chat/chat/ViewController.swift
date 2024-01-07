//
//  ViewController.swift
//  chat
//
//  Created by Nurkhan Tashimov on 01.11.2023.
//

import UIKit

class ViewController: UIViewController {
    var textViewConstraints: [NSLayoutConstraint] = []
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var textView: UITextView!
    //    @IBOutlet weak var textView: UITextView!
    var originalTableViewHeight: CGFloat = 0.0
    var tapGesture: UITapGestureRecognizer!
//    var tempConstant : CGFloat
    @IBOutlet weak var tableView: UITableView!
    var messages = [(String(),String())]
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTable()
        configureTextView()
        
        // Do any additional setup after loading the view.
    }
    func configureTextView(){
//        textView.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
//        textView.didchange
//        textView.delegate = self
//        textView.isScrollEnabled = false
//        textView.textContainerInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        textView.delegate = self
        textView.becomeFirstResponder()
        textView.layer.borderWidth = 0.2
        textView.layer.cornerRadius = 10
        sendButton.addTarget(self, action: #selector(sendMessage), for: .touchUpInside)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
            tapGesture.cancelsTouchesInView = false
            tableView.addGestureRecognizer(tapGesture)
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        // Закрыть клавиатуру
        
        view.endEditing(true)
        textViewConstraints = [
            self.textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10),
            self.sendButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 10),

        ]
        NSLayoutConstraint.activate(self.textViewConstraints)
    }
    func configureTable(){
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.frame = view.bounds
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomMessageCell")
        messages.removeAll()
        originalTableViewHeight = tableView.frame.height
    }
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                    UIView.animate(withDuration: 0.3) {
                        let tableViewHeight = self.originalTableViewHeight - keyboardSize.height - self.textView.frame.size.height - 90
                        self.tableView.frame = CGRect(x: 16, y: 59, width: self.tableView.frame.width, height: tableViewHeight)
                        if self.messages.count > 0{
                            let indexPath = IndexPath(row: self.messages.count - 1, section: 0)
                            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
                        }
                    }
                }
        NSLayoutConstraint.deactivate(textViewConstraints)
        if let userInfo = notification.userInfo,let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
            textViewConstraints = [
                self.textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -keyboardSize.cgRectValue.height-10),
                self.sendButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -keyboardSize.cgRectValue.height-10),

            ]
        }
        UIView.animate(withDuration: 0.3) {
            NSLayoutConstraint.activate(self.textViewConstraints)
        }
            
        }

    @objc func keyboardWillHide(notification: Notification) {
        UIView.animate(withDuration: 0.3) {
            self.tableView.frame = CGRect(x: 16, y: 59, width: self.tableView.frame.width, height: self.originalTableViewHeight)
            
            }
        NSLayoutConstraint.deactivate(textViewConstraints)
                if let userInfo = notification.userInfo,let keyboardSize = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue{
                    textViewConstraints = [
                        self.textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: keyboardSize.cgRectValue.height-10),
                        self.sendButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: keyboardSize.cgRectValue.height-10),
                        
                    ]
                }
                UIView.animate(withDuration: 0.3) {
                    NSLayoutConstraint.activate(self.textViewConstraints)
                    
            }
    }
    @objc func sendMessage(){
        if textView.text!.count > 0{
            messages.append((textView.text!,"Me"))
            messages.append((textView.text!,"You"))
//            UserDefaults.standard.setValue(textField.text!, forKey: "Me")
//            UserDefaults.standard.setValue(textField.text!, forKey: "You")
            let indexPath1 = IndexPath(row: messages.count - 2, section: 0)
            let indexPath2 = IndexPath(row: messages.count - 1, section: 0)
            tableView.beginUpdates()
            tableView.insertRows(at: [indexPath1, indexPath2], with: .bottom)
            tableView.endUpdates()
            textView.text?.removeAll()
            
            let lastIndexPath = IndexPath(row: messages.count - 1, section: 0)
            tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
            textView.constraints.filter { $0.firstAttribute == .height && $0.secondItem == nil }.first?.constant = 30

//            let lastIndexPath = IndexPath(row: messages.count - 1, section: 0)
//                         tableView.scrollToRow(at: lastIndexPath, at: .bottom, animated: true)
//            tableView.reloadData()
//            tableView.insertRows(at: [IndexPath(row: messages.count - 1, section: 0)], with: .automatic)
//            tableView.insertRows(at: [IndexPath(row: messages.count - 2, section: 0)], with: .automatic)
        }
//        print(messages)
//        print(UserDefaults.standard.string(forKey: "Me")!)
//        print(UserDefaults.standard.dictionaryRepresentation().values.count)
    }
    func textViewDidChange(_ textView: UITextView) {
             
         let size = CGSize(width: textView.frame.size.width, height: .greatestFiniteMagnitude)
         let estimatedSize = textView.sizeThatFits(size)
         textView.isScrollEnabled = estimatedSize.height > 50
         textView.constraints.filter { $0.firstAttribute == .height && $0.secondItem == nil }.first?.constant = 30
             
    }
//    func updateTextViewHeight() {
//        let size = CGSize(width: textView.frame.width, height: .infinity)
//        let estimatedSize = textView.sizeThatFits(size)
//
//        textView.constraints.forEach { (constraint) in
//            if constraint.firstAttribute == .height {
//                constraint.constant = estimatedSize.height
//            }
//        }
//    }
}


extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let customCell = cell as? CustomTableViewCell {
            customCell.updateConstraintsIfNeeded()
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomMessageCell",for: indexPath) as! CustomTableViewCell
        
        cell.setup(dt: messages[indexPath.row].0, person: messages[indexPath.row].1)
//        cell.setNeedsLayout()
        cell.layoutIfNeeded()
        return cell
    }
    func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
        return false
    }
}
extension ViewController: UITextViewDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            return true
        }
    
}
//extension ViewController: UITextViewDelegate{
//    func textViewDidChange(_ textView: UITextView) {
//            updateTextViewHeight()
//        }
//
//}
