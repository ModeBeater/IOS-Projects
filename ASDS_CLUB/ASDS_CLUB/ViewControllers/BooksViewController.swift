//
//  BooksViewController.swift
//  ASDS_CLUB
//
//  Created by Nurkhan Tashimov on 12.12.2023.
//

import UIKit
import Alamofire
import FirebaseAuth
import FirebaseFirestore
struct Reservation {
    var type: String // "Computer" or "PS"
    var startTime: String
    var endTime: String
}
class BooksViewController: UIViewController {
    var timer: Timer?
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let db = Firestore.firestore()
    var reservations: [Reservation] = [
//        Reservation(type: "Computer", startTime: "2023-12-17 20:20:02", endTime: "23:20:02"),
//        Reservation(type: "PS", startTime: "9:00 PM", endTime: "11:11 PM", date: "2023-12-15"),
    ]
    var currentDevice : String = ""
    var secondsLeft : Double = 0
    let timerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30)
        label.textAlignment = .center
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        createPage()
        // Do any additional setup after loading the view.
    }
    func createPage(){
        let backgroundImage = UIImageView(image: UIImage(named: "background"))
        backgroundImage.contentMode = .scaleAspectFill
        view.addSubview(backgroundImage)
        let exitButton = UIButton()
        exitButton.setImage(UIImage(named: "exit")?.withRenderingMode(.alwaysTemplate), for: .normal)
        exitButton.imageView?.tintColor = .white
        exitButton.addTarget(self, action: #selector(exit), for: .touchUpInside)
//        view.addSubview(exitButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: exitButton)
        exitButton.snp.makeConstraints{button in
            button.width.equalTo(0.121 * screenWidth)
            button.height.equalTo(0.578 * screenHeight)
//            button.leading.equalTo(view.safeAreaLayoutGuide).offset(317)
//            button.top.equalTo(view.safeAreaLayoutGuide).offset(0)
        }
        
        db.collection("UserReservations").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Ошибка при получении документов: \(error.localizedDescription)")
            } else {
                for document in querySnapshot!.documents {
                    let postData = document.data()
                    if Auth.auth().currentUser?.email == postData["userPost"] as? String ?? ""{
                        let map = postData["reservations"] as? [String : [String]] ?? [:]
                        for i in 0...(map["type"]!.count - 1){
                            self.reservations.append(Reservation(type: map["type"]![map["type"]!.count - 1 - i], startTime: map["startTime"]![map["type"]!.count - 1 - i], endTime: map["endTime"]![map["type"]!.count - 1 - i]))
                            print(i, map["type"]![i])
                            
                        }
                        
                    }
                }
                self.createTable()
                
            }
        }
        let left = UILabel()
        left.text = "Остаток времени:"
        left.font = UIFont.boldSystemFont(ofSize: 40)
        left.textColor = .white
        left.textAlignment = .left
        view.addSubview(left)
        left.snp.makeConstraints{left in
            left.top.equalTo(view).offset(0.158 * screenHeight)
            left.centerX.equalToSuperview()
            
        }
        let button = UIButton()
        button.setTitle("Забронировать", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        button.backgroundColor = UIColor(red: 0.8, green: 0.52, blue: 0.845, alpha: 1)
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        button.addTarget(self, action: #selector(book), for: .touchUpInside)
        view.addSubview(button)
        button.snp.makeConstraints{button in
            button.width.equalTo(0.466 * screenWidth)
            button.height.equalTo(0.041 * screenHeight)
            button.top.equalTo(view).offset(0.329 * screenHeight)
            button.leading.equalTo(view).offset(0.262 * screenWidth)
        }
        let books = UILabel()
        books.text = "бронирования:"
        books.font = UIFont.boldSystemFont(ofSize: 30)
        books.textColor = .white
        books.textAlignment = .left
        view.addSubview(books)
        books.snp.makeConstraints{books in
            books.top.equalTo(view).offset(0.3838 * screenHeight)
            books.centerX.equalToSuperview()
            
        }
//        createTable()
    }
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        timer?.fire()
    }
    @objc func updateTimer() {
        secondsLeft -= 1
        let hours = Int(secondsLeft) / 3600
        let minutes = (Int(secondsLeft) % 3600) / 60
        DispatchQueue.main.async {
                self.timerLabel.text = String(format: "%02d:%02d", hours, minutes)
                
                if self.secondsLeft > 360 {
                    self.timerLabel.textColor = .green
                } else {
                    self.timerLabel.textColor = .red
                }
                
                if self.secondsLeft <= 0 {
                    self.stopTimer()
                }
            }
    }
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    func createTable(){
        let tableView = UITableView()
        tableView.backgroundColor = UIColor.clear
//        tableView.separatorStyle = .none
        tableView.layer.borderWidth = 2.0
        tableView.layer.borderColor = UIColor.white.cgColor
        tableView.register(ReservationCell.self, forCellReuseIdentifier: "ReservationCell")
        tableView.dataSource = self
        view.addSubview(tableView)
        tableView.snp.makeConstraints{tableView in
            tableView.top.equalTo(view).offset(0.438 * screenHeight)
            tableView.leading.equalTo(view).offset(0.051 * screenWidth)
            tableView.width.equalTo(0.893 * screenWidth)
            tableView.height.equalTo(0.343 * screenHeight)
        }
        if currentDevice == ""{
            for reservation in reservations{
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                if isCurrentTimeInReservation(reservation: reservation){
                    guard let end = dateFormatter.date(from: "\(reservation.endTime)") else {
                        print("Error: Couldn't create dates from strings.")
                        return
                    }
                    
                    currentDevice = reservation.type
                    secondsLeft = end.timeIntervalSinceNow
                    break
                }
            }
        }
        let device = UILabel()
        if currentDevice != ""{
            device.text = currentDevice
            device.font = UIFont.boldSystemFont(ofSize: 30)
            device.textColor = .white
            device.textAlignment = .center
            view.addSubview(device)
            device.snp.makeConstraints{device in
                device.width.equalTo(0.512 * screenWidth)
                device.height.equalTo(0.0416 * screenHeight)
                device.top.equalTo(view).offset(0.275 * screenHeight)
                device.centerX.equalToSuperview()
            }
            if secondsLeft > 360{
                timerLabel.textColor = .green
            }
            else{
                timerLabel.textColor = .red
            }
            view.addSubview(timerLabel)
            timerLabel.frame = CGRect()
            timerLabel.snp.makeConstraints{make in
                make.centerX.equalToSuperview()
                make.top.equalTo(view).offset(0.2335 * screenHeight)
                make.width.equalTo(0.536 * screenWidth)
                make.height.equalTo(0.0416 * screenHeight)
            }
            startTimer()
        }
    }
    @objc func book(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @objc func exit(_ sender: UIButton) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
            navigationController?.popViewController(animated: true)
            navigationController?.setViewControllers([ViewController()], animated: true)
        } catch let signOutError as NSError {
          print("Error signing out: %@", signOutError)
        }

    }
    func isCurrentTimeInReservation(reservation: Reservation) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        print("Sakura")
        // Get the current date and time
        let currentDate = Date()
        
        // Get the reservation's start and end time as Date objects
        guard let reservationStartTime = dateFormatter.date(from: reservation.startTime),
              let reservationEndTime = dateFormatter.date(from: reservation.endTime) else {
            return false
        }
        print("Kakashi")
        print(currentDate, reservationStartTime, reservationEndTime)
        // Compare the current time with the reservation's start and end time
        return currentDate >= reservationStartTime && currentDate <= reservationEndTime
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

extension BooksViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? ReservationCell {
                cell.backgroundColor = UIColor(red: 0.518, green: 0.647, blue: 0.98, alpha: 1)
                cell.selectionStyle = .none // or .default, depending on your preference
            }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell", for: indexPath) as! ReservationCell

        let reservation = reservations[indexPath.row]
        cell.typeLabel.text = reservation.type
        cell.startTimeLabel.text = reservation.startTime
        cell.endTimeLabel.text = String(reservation.endTime.suffix(8))
        cell.backgroundColor = UIColor.clear
        return cell
    }
    
    
}
