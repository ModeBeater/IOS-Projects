//
//  VipRoom.swift
//  ASDS_CLUB
//
//  Created by Nurkhan Tashimov on 04.12.2023.
//

import UIKit
import iOSDropDown
import FirebaseFirestore
import FirebaseAuth
class VipRoom: UIViewController {
    let  dropDown = DropDown()
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    var selectedComputers : [Int] = []
    let datePicker1 = UIDatePicker()
    let db = Firestore.firestore()
    let datePicker2 = UIDatePicker()
    var computerButtons : [UIButton] = []
    var rooms: [UIView] = []
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        return collectionView
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
        let pcImage = fillWhiteImage(name: "VIP")
        view.addSubview(pcImage)
        pcImage.snp.makeConstraints{pcImage in
            pcImage.top.equalTo(view.safeAreaLayoutGuide).offset(-2)
//            pcImage.top
            pcImage.leading.equalTo(view).offset(0.106 * screenWidth)
            pcImage.width.equalTo(0.145 * screenWidth)
            pcImage.height.equalTo(0.059 * screenHeight)
        }
        let title = setLabel(string: "Выбор VIP", size: 20)
        setConstraints(someLabel: title, x: Int(CGFloat(0.318 * screenWidth)), y: Int(CGFloat(0.0127 * screenHeight)))
        let subtitle = setLabel(string: "Выберите компьютер и время:", size: 20)
        setConstraints(someLabel: subtitle, x: Int(CGFloat(0.1067 * screenWidth)), y: Int(CGFloat(0.082 * screenHeight)))
//        let newRootViewController = CustomTabBar()
        createDatePicker()
        let valueLabel = UILabel()
        view.addSubview(valueLabel)
        createHourPicker()
        createPayButton()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "ComputerCell")
        collectionView.backgroundColor = nil
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0.342 * screenHeight)
//            make.leading.equalTo(view).offset(44)
            make.width.equalTo(view.bounds.width)
            make.height.equalTo(0.3445 * screenHeight)
        }
        var i = 1
        getNumberOfDevices { [self] numberOfDevices in
            for _ in 1...numberOfDevices{
                createComputers(x: Int(0.046 * screenWidth), y: Int(0.316 * screenHeight) * i, start1: i + 4 * (i - 1), end1: i + 1 + 4 * (i - 1), start2: i + 2 + 4 * (i - 1), end2: i + 4 + 4 * (i - 1), vipNumber: i)
                i += 1
                createComputers(x: Int(0.5 * screenHeight) , y: Int(0.316 * screenHeight) * i, start1: i + 4 * (i - 1), end1: i + 1 + 4 * (i - 1), start2: i + 2 + 4 * (i - 1), end2: i + 4 + 4 * (i - 1), vipNumber: i)
                i += 1
            }
            updateComputers()
            collectionView.reloadData()
        }
//        createComputers(x: 19, y: 274, start1: 1,end1: 2, start2: 3, end2: 5)
//        createComputers(x: 206, y: 274, start1: 6, end1: 7, start2: 8, end2: 10)
//        dropDown.snp.makeConstraints{selectionHours in
//            selectionHours.width.equalTo(100)
//            selectionHours.height.equalTo(34)
//            selectionHours.top.equalTo(view).offset(82)
//            selectionHours.leading.equalTo(view).offset(264)
//
//        }
    }
    func getNumberOfDevices(completion: @escaping (Int) -> Void) {
        var number = 1
        let documentReference = db.collection("VIP").document("pcNumber")

        // Assuming you want to retrieve the value of a field called "count"
        documentReference.getDocument { (document, error) in
            if let document = document, document.exists {
                if let fieldValue = document.get("count") as? Int {
                    // Use the fieldValue as needed
                    number = fieldValue
                    completion(number) // Call the completion handler
                } else {
                    print("Field does not exist or is nil.")
                    completion(number) // Call the completion handler with default value
                }
            } else {
                print("Document does not exist or there was an error: \(error?.localizedDescription ?? "Unknown error")")
                completion(number) // Call the completion handler with default value
            }
        }
    }
    func createComputers(x: Int, y: Int, start1 : Int, end1: Int, start2 : Int, end2 : Int, vipNumber : Int){
        let stackView1 = createStack(start: start1,end: end1)
        let stackView2 = createStack(start: start2,end: end2)
        let firstRoom = UIView()
        firstRoom.layer.borderWidth = 2.0 // Set the border width as needed
        firstRoom.layer.borderColor = UIColor.white.cgColor // Set the border color as needed

        // Add the rectangle view to your main view
        collectionView.addSubview(firstRoom)
        rooms.append(firstRoom)
        firstRoom.snp.makeConstraints{firstRoom in
            firstRoom.width.equalTo(0.437 * screenWidth)
            firstRoom.height.equalTo(0.3445 * screenHeight)
            firstRoom.top.equalTo(view.safeAreaLayoutGuide).offset(y + Int(0.01 * screenHeight))
            firstRoom.leading.equalTo(view).offset(x + Int(0.02 * screenWidth))
        }
        firstRoom.addSubview(stackView1)
        firstRoom.addSubview(stackView2)
        stackView1.snp.makeConstraints{stackView1 in
            stackView1.width.equalTo(0.177 * screenWidth)
            stackView1.height.equalTo(0.208 * screenHeight)
            stackView1.top.equalTo(firstRoom).offset(Int(0.01 * screenHeight))
            stackView1.leading.equalTo(firstRoom).offset(Int(0.01 * screenWidth))
        }
        stackView2.snp.makeConstraints{stackView2 in
            stackView2.width.equalTo(0.177 * screenWidth)
            stackView2.height.equalTo(0.326 * screenHeight)
            stackView2.top.equalTo(firstRoom).offset(Int(0.01 * screenHeight))
            stackView2.leading.equalTo(stackView1).offset(0.243 * screenWidth)
        }
//        firstRoom.addSubview(stackView1)
//        firstRoom.addSubview(stackView2)
        let Vip1 = UILabel()
//        let Vip2 = UILabel()
        Vip1.text = "VIP \(vipNumber)"
        Vip1.font = UIFont.boldSystemFont(ofSize: 20)
        Vip1.textColor = .white
        firstRoom.addSubview(Vip1)
        Vip1.snp.makeConstraints{vip in
            vip.top.equalTo(firstRoom).offset(0.269 * screenHeight)
            vip.leading.equalTo(0.07 * screenWidth)
        }
        
    }
    func createStack(start: Int, end: Int) -> UIStackView{
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
//        stackView.alignment = .bottom
        stackView.spacing = 8
        for index in start...end {
            let width = 0.153 * screenWidth
            let height = 0.061 * screenHeight
            let button = SelectButton(imageSize: CGSize(width: Int(width), height: Int(height)))
            button.setImage(UIImage(named: "PC")?.withRenderingMode(.alwaysTemplate), for: .normal)
            button.imageView?.tintColor = .white
            button.setTitle("\(index)", for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            button.addTarget(self, action: #selector(computerSelected), for: .touchUpInside)
//            button.contentVerticalAlignment = .bottom
            button.layer.cornerRadius = 0
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.white.cgColor
            print(button.frame.size)
            stackView.addArrangedSubview(button)
            button.titleLabel?.snp.makeConstraints{title in
                title.bottom.equalTo(button.snp.bottom)
            }
            button.imageView?.snp.makeConstraints{image in
                image.top.equalTo(button).offset(10)
                image.leading.equalTo(stackView).offset(5)
            }
            button.snp.makeConstraints{ make in
                make.width.equalTo(0.177 * screenWidth)
                make.height.equalTo(0.096 * screenHeight)
            }
            computerButtons.append(button)
        }
//        view.addSubview(stackView)
        return stackView
    }
    func updateComputers(){
        for i in self.computerButtons{
            if i.imageView?.tintColor != UIColor(red: 0.518, green: 0.647, blue: 0.98, alpha: 1){
                i.imageView?.tintColor = .white
                i.setTitleColor(.white, for: .normal)
                i.layer.borderColor = UIColor.white.cgColor
            }
        }
        db.document("VIP/pc").getDocument{ [self]snapshot, error in
            guard let pcData = snapshot?.data(), error == nil else{
                return
            }
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            for (index, value) in (pcData["date"] as? [String] ?? []).enumerated(){
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                let indexOfTime = (pcData["time"] as! [String])[index]
                let currentDate = dateFormatter.date(from: dateFormatter.string(from: combineDate()))!
                print(combineDate())
//                print(currentDate, getEndTime(dateString: value, index: Int(indexOfTime)!))
//                print(currentDate,dateFormatter.date(from: value)!)
                let result1 = currentDate.compare(getEndTime(dateString: value, index: Int(indexOfTime)!))
                let result2 = currentDate.compare(dateFormatter.date(from: value)!)
                let result3 = currentDate.compare(getBeforeStartTime(dateString: value, index: dropDown.selectedIndex ?? 5))
                print(currentDate, getBeforeStartTime(dateString: value, index: dropDown.selectedIndex ?? 5))
//                print(result1.rawValue)
//                print(result2.rawValue)
//                print(result3.rawValue)
                if (result1 == .orderedAscending && result2 == .orderedDescending) || (result2 == .orderedSame){
                    let button = self.computerButtons[self.computerButtons.firstIndex(where: {$0.titleLabel?.text == (pcData["PC"] as! [String])[index]})!]
                    self.computerButtons[self.computerButtons.firstIndex(where: {$0.titleLabel?.text == (pcData["PC"] as! [String])[index]})!].imageView?.tintColor = .red
                    if selectedComputers.contains(Int((button.titleLabel?.text)!)!){
                        selectedComputers.removeAll(where: {$0 == Int((button.titleLabel?.text)!)})
                    }
                    button.imageView?.tintColor = .red
                    button.setTitleColor(UIColor.red, for: .normal)
                    button.layer.borderColor = UIColor.red.cgColor
//                    print("Naruto")
                }
                if (result2 == .orderedAscending && result3 == .orderedDescending) || (result3 == .orderedSame){
                    
                    let button = self.computerButtons[self.computerButtons.firstIndex(where: {$0.titleLabel?.text == (pcData["PC"] as! [String])[index]})!]
                    self.computerButtons[self.computerButtons.firstIndex(where: {$0.titleLabel?.text == (pcData["PC"] as! [String])[index]})!].imageView?.tintColor = .red
                    if selectedComputers.contains(Int((button.titleLabel?.text)!)!){
                        selectedComputers.removeAll(where: {$0 == Int((button.titleLabel?.text)!)})
                        print(selectedComputers.count)
                    }
                    button.imageView?.tintColor = .red
                    button.setTitleColor(UIColor.red, for: .normal)
                    button.layer.borderColor = UIColor.red.cgColor
                }
            }
            updateTextHourPicker()
            
        }
    }
    @objc func computerSelected(_ sender: UIButton) {
            // Handle button tap
            print("Button tapped: \(sender.currentTitle ?? "")")
//            print()
        if sender.imageView?.tintColor == .white{
            sender.imageView?.tintColor = UIColor(red: 0.518, green: 0.647, blue: 0.98, alpha: 1)
            sender.setTitleColor(UIColor(red: 0.518, green: 0.647, blue: 0.98, alpha: 1), for: .normal)
            sender.layer.borderColor = UIColor(red: 0.518, green: 0.647, blue: 0.98, alpha: 1).cgColor
            selectedComputers.append(Int((sender.titleLabel?.text)!)!)
            updateTextHourPicker()
            
        }
        else{
            sender.imageView?.tintColor = .white
            sender.setTitleColor(.white, for: .normal)
            sender.layer.borderColor = UIColor.white.cgColor
            selectedComputers = selectedComputers.filter {$0 != Int((sender.titleLabel?.text)!)!}
            updateTextHourPicker()
        }
//        sender.imageView?.tintColor = .red
        }
    func getDay() -> Int{
        let selectedDate = datePicker1.date
        let calendar = Calendar.current
        return calendar.component(.weekday, from: selectedDate)
    }
    func combineDate() -> Date{
        let selectedDate = datePicker1.date
        let selectedTime = datePicker2.date
        
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year, .month, .day], from: selectedDate)
        let timeComponents = calendar.dateComponents([.hour, .minute], from: selectedTime)
        
        // Combine date and time components
        var combinedComponents = DateComponents()
        combinedComponents.year = dateComponents.year
        combinedComponents.month = dateComponents.month
        combinedComponents.day = dateComponents.day
        combinedComponents.hour = timeComponents.hour
        combinedComponents.minute = timeComponents.minute
        return calendar.date(from: combinedComponents)!
        //        if let combinedDateTime = calendar.date(from: combinedComponents) {
        //            print("Combined DateTime: \(combinedDateTime)")
        //        } else {
        //            print("Error combining date and time.")
        //        }
    }
    func getBeforeStartTime(dateString: String, index: Int) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
  //      dateFormatter.timeZone = TimeZone(identifier: "UTC")
        let date = dateFormatter.date(from: dateString)
        var timeInterval: TimeInterval = 0
        switch index {
        case 0: // 1 час
            timeInterval = 1 * 60 * 60
        case 1: // 2 + 1
            timeInterval = (2 + 1) * 60 * 60
        case 2: // 3 + 2
            timeInterval = (3 + 2) * 60 * 60
        case 3: // день
            timeInterval = 10 * 60 * 60
        case 4: // ночь
            timeInterval = 10 * 60 * 60
        default:
            break
        }
        return date!.addingTimeInterval(-timeInterval)
    }
    func getEndTime(dateString: String, index : Int) -> Date {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
      let date = dateFormatter.date(from: dateString)
      var timeInterval: TimeInterval = 0
      switch index {
      case 0: // 1 час
          timeInterval = 1 * 60 * 60
      case 1: // 2 + 1
          timeInterval = (2 + 1) * 60 * 60
      case 2: // 3 + 2
          timeInterval = (3 + 2) * 60 * 60
      case 3: // день
          timeInterval = 10 * 60 * 60
      case 4: // ночь
          timeInterval = 10 * 60 * 60
      default:
          break
      }
      
        return date!.addingTimeInterval(timeInterval)
  }
    
    func updateHourPicker(){
        updateComputers()
    }
    func updateTextHourPicker(){
        if getDay() == 1 || getDay() == 6{
            dropDown.optionArray = [" 1 час - \(selectedComputers.count * 1390) тенге", " 2 + 1 - \(selectedComputers.count * 2780) тенге", " 3 + 2 - \(selectedComputers.count * 4170) тенге"," день - \(selectedComputers.count * 4490) тенге"," ночь - \(selectedComputers.count * 5000) тенге"]
        }
        else{
            dropDown.optionArray = [" 1 час - \(selectedComputers.count * 1190) тенге", " 2 + 1 - \(selectedComputers.count * 2380) тенге", " 3 + 2 - \(selectedComputers.count * 3570) тенге"," день - \(selectedComputers.count * 3990) тенге"," ночь - \(selectedComputers.count * 4490) тенге"]
        }
        switch dropDown.selectedIndex {
        case 0: // 1 час
            dropDown.text = dropDown.optionArray[0]
        case 1: // 2 + 1
            dropDown.text = dropDown.optionArray[1]
        case 2: // 3 + 2
            dropDown.text = dropDown.optionArray[2]
        case 3: // день
            dropDown.text = dropDown.optionArray[3]
            let calendar = Calendar.current
            let newDate = calendar.date(bySettingHour: 8, minute: 0, second: 0, of: datePicker2.date)
            datePicker2.date = newDate ?? Date()
        case 4: // ночь
            dropDown.text = dropDown.optionArray[4]
            let calendar = Calendar.current
            let newDate = calendar.date(bySettingHour: 22, minute: 0, second: 0, of: datePicker2.date)
            datePicker2.date = newDate ?? Date()
        default:
            break
        }
    }
    func createHourPicker(){
        let valueLabel = UILabel()
        view.addSubview(valueLabel)
//        dropDown.handleKeyboard = false
        if getDay() == 1 || getDay() == 6{
            dropDown.optionArray = [" 1 час - \(selectedComputers.count * 1390) тенге", " 2 + 1 - \(selectedComputers.count * 2780) тенге", " 3 + 2 - \(selectedComputers.count * 4170) тенге"," день - \(selectedComputers.count * 4490) тенге"," ночь - \(selectedComputers.count * 4990) тенге"]
        }
        else{
            dropDown.optionArray = [" 1 час - \(selectedComputers.count * 1190) тенге", " 2 + 1 - \(selectedComputers.count * 2380) тенге", " 3 + 2 - \(selectedComputers.count * 3570) тенге"," день - \(selectedComputers.count * 3990) тенге"," ночь - \(selectedComputers.count * 4490) тенге"]
        }
        dropDown.selectedRowColor = .white
//        dropDown.textAlignment = .center
        dropDown.optionIds = [1,23,54,22,24]
        dropDown.cornerRadius = 7
        dropDown.isSearchEnable = false
        dropDown.checkMarkEnabled = false
        dropDown.backgroundColor = UIColor(red: 0.885, green: 0.885, blue: 0.885, alpha: 1)
        dropDown.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(dropDown)
        dropDown.didSelect { [self] (selectedText, index, id) in
            self.updateComputers()
        }
        dropDown.snp.makeConstraints { make in
            make.top.equalTo(datePicker1).offset(0.0578 * screenHeight)
            make.leading.equalTo(view).offset(0.1068 * screenWidth)
            make.width.equalTo(0.553 * screenWidth)
            make.height.equalTo(0.0427 * screenHeight)
        }
    }
    func createPayButton(){
        let payButton = UIButton()
        payButton.backgroundColor = UIColor(red: 0.8, green: 0.52, blue: 0.845, alpha: 1)
        payButton.tintColor = .white
        payButton.layer.cornerRadius = 7
        payButton.layer.masksToBounds = true
        payButton.setTitle("бронь", for: .normal)
        payButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        payButton.addTarget(self, action: #selector(pay), for: .touchUpInside)
//        payButton.lab = "оплатить"
        view.addSubview(payButton)
        payButton.snp.makeConstraints{payButton in
            payButton.width.equalTo(0.182 * screenWidth)
            payButton.height.equalTo(0.039 * screenHeight)
            payButton.top.equalTo(view.safeAreaLayoutGuide).offset(0.188 * screenHeight)
            payButton.leading.equalTo(view).offset(0.6747 * screenWidth)
        }
    }
    func createDatePicker(){
        
        datePicker1.layer.cornerRadius = 7
        datePicker2.layer.cornerRadius = 7
        datePicker1.layer.masksToBounds = true
        datePicker2.layer.masksToBounds = true
        datePicker1.layer.masksToBounds = true
        datePicker2.layer.masksToBounds = true
        datePicker1.timeZone = TimeZone.current
        datePicker2.timeZone = TimeZone.current
        // Customize the date pickers as needed
        datePicker1.datePickerMode = .date
        datePicker2.datePickerMode = .time
        datePicker1.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        datePicker2.addTarget(self, action: #selector(dateChanged(_:)), for: .valueChanged)
        // Create a container view to hold the date pickers
        datePicker1.backgroundColor = UIColor(red: 0.885, green: 0.885, blue: 0.885, alpha: 1)
        datePicker2.backgroundColor = UIColor(red: 0.885, green: 0.885, blue: 0.885, alpha: 1)
        datePicker1.minimumDate = Date() // Set the minimum date to today
        datePicker1.maximumDate = Calendar.current.date(byAdding: .year, value: 1, to: Date())
        // Add the container view to your main view
        view.addSubview(datePicker1)
        view.addSubview(datePicker2)
        datePicker1.snp.makeConstraints{datePicker1 in
            datePicker1.top.equalTo(view.safeAreaLayoutGuide).offset(0.129 * screenHeight)
            datePicker1.leading.equalTo(view).offset(0.1067 * screenWidth)
            
        }
        datePicker2.snp.makeConstraints{datePicker2 in
            datePicker2.top.equalTo(view.safeAreaLayoutGuide).offset(0.129 * screenHeight)
            datePicker2.leading.equalTo(datePicker1).offset(0.3846 * screenWidth)
            
        }
    }
    @objc func pay(_ sender: UIButton) {
        if dropDown.selectedIndex == nil{
            return
        }
        let standardPC = db.collection("VIP").document("pc")
        let userReservations = db.collection("UserReservations").document("users")

        var pcnumbers: [String] = []
        var dates: [String] = []
        var times: [String] = []
        var userPosts: [String] = []

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone.current

        // Update StandardPC/pc collection
        standardPC.getDocument { [self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }

            pcnumbers = data["PC"] as? [String] ?? []
            dates = data["date"] as? [String] ?? []
            times = data["time"] as? [String] ?? []
            userPosts = data["userPost"] as? [String] ?? []

            for i in selectedComputers {
                pcnumbers.append("\(i)")
                dates.append(dateFormatter.string(from: combineDate()))
                times.append("\(dropDown.selectedIndex ?? 5)")
                userPosts.append(Auth.auth().currentUser?.email ?? "")
            }

            let mydata: [String: Any] = [
                "PC": pcnumbers,
                "date": dates,
                "time": times,
                "userPost": userPosts
            ]

            standardPC.setData(mydata) { error in
                if let error = error {
                    print("Error writing to StandardPC/pc collection: \(error.localizedDescription)")
                } else {
                    print("Data successfully written to StandardPC/pc collection")
                    self.updateComputers()
                }
            }
        }

        // Update UserReservations/users collection
        var types: [String] = []
        var endTimes: [String] = []

        userReservations.getDocument { [self] snapshot, error in
            guard let data = snapshot?.data(), error == nil else {
                return
            }
            let dbReservations = data["reservations"] as? [String: [String]] ?? [:]
            endTimes = dbReservations["endTime"] ?? []
            dates = dbReservations["startTime"] ?? []
            types = dbReservations["type"] ?? []

            for i in selectedComputers {
                endTimes.append(dateFormatter.string(from: getEndTime(dateString: dateFormatter.string(from: combineDate()), index: dropDown.selectedIndex!)))
                types.append("VIP - \(i)")
                dates.append(dateFormatter.string(from: datePicker1.date))
            }

            let reservations: [String: [String]] = [
                "endTime": endTimes,
                "startTime": dates,
                "type": types
            ]

            let dataToProfile: [String: Any] = [
                "reservations": reservations,
                "userPost": Auth.auth().currentUser?.email ?? ""
            ]

            userReservations.setData(dataToProfile) { error in
                if let error = error {
                    print("Error writing to UserReservations/users collection: \(error.localizedDescription)")
                } else {
                    print("Data successfully written to UserReservations/users collection")
                }
            }
        }
    }
     @objc func dateChanged(_ sender: UIDatePicker) {
         // Handle date changes here
         let selectedDate = sender.date
         print("Selected Date: \(selectedDate)")
         updateHourPicker()
         updateComputers()
    }
    func fillWhiteImage(name: String) -> UIImageView{
        let image0 = UIImage(named: name)?.withRenderingMode(.alwaysTemplate)
        let imageView = UIImageView(image: image0)
        imageView.tintColor = .white
        return imageView
    }
    func setConstraints(someLabel: UILabel, x: Int, y: Int){
        someLabel.snp.makeConstraints{someLabel in
            someLabel.top.equalTo(view.safeAreaLayoutGuide).offset(y)
            someLabel.leading.equalTo(view).offset(x)
        }
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

}
extension VipRoom: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return rooms.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ComputerCell", for: indexPath)
        for subview in cell.subviews {
            subview.removeFromSuperview()
        }
        
        let room = rooms[indexPath.item]
        cell.addSubview(room)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0.437 * screenWidth, height: 0.3445 * screenHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
