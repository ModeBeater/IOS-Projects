//
//  PSRoom.swift
//  ASDS_CLUB
//
//  Created by Nurkhan Tashimov on 04.12.2023.
//

import UIKit
import iOSDropDown
import FirebaseFirestore
import FirebaseAuth
class PSRoom: UIViewController {
    var selectedConsoles : [Int] = []
    let screenWidth = UIScreen.main.bounds.width
    let screenHeight = UIScreen.main.bounds.height
    let dropDown = DropDown(frame: CGRect(x: 44, y: 259, width: 228, height: 37))
    let db = Firestore.firestore()
    let datePicker2 = UIDatePicker()
    let datePicker1 = UIDatePicker()
    var PS: [UIButton] = []
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
        let pcImage = fillWhiteImage(name: "PS")
        view.addSubview(pcImage)
        pcImage.snp.makeConstraints{pcImage in
            pcImage.top.equalTo(view.safeAreaLayoutGuide).offset(-2)
//            pcImage.top
            pcImage.leading.equalTo(view).offset(0.106 * screenWidth)
            pcImage.width.equalTo(0.145 * screenWidth)
            pcImage.height.equalTo(0.059 * screenHeight)
        }
        let title = setLabel(string: "Выбор Playstation", size: 20)
        setConstraints(someLabel: title, x: Int(CGFloat(0.318 * screenWidth)), y: Int(CGFloat(0.0127 * screenHeight)))
        let subtitle = setLabel(string: "Выберите playstation и время:", size: 20)
        setConstraints(someLabel: subtitle, x: Int(CGFloat(0.1067 * screenWidth)), y: Int(CGFloat(0.082 * screenHeight)))
//        let newRootViewController = CustomTabBar()
        createDatePicker()
        let valueLabel = UILabel()
        view.addSubview(valueLabel)
        createHourPicker()
        createPayButton()
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "PSCell")
        collectionView.backgroundColor = nil
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.width.equalTo(0.427 * screenWidth)
            make.height.equalTo(0.422 * screenHeight)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(0.274 * screenHeight)
            make.leading.equalTo(view).offset(0.267 * screenWidth)
        }
//        let stackView = UIStackView()
//        stackView.axis = .vertical
//        stackView.distribution = .equalSpacing
//        stackView.alignment = .bottom
//        stackView.spacing = 8
        getNumberOfDevices { [self] numberOfDevices in
                for index in 1...numberOfDevices {
                    let width = 0.339 * screenWidth
                    let height = 0.125 * screenHeight
                    let button = SelectButton(imageSize: CGSize(width: Int(width), height: Int(height)))
                    button.setImage(UIImage(named: "PS")?.withRenderingMode(.alwaysTemplate), for: .normal)
                    button.imageView?.tintColor = .white
                    button.setTitle("\(index)", for: .normal)
                    button.titleLabel?.font = UIFontMetrics.default.scaledFont(for: UIFont.boldSystemFont(ofSize: 40))
                    button.addTarget(self, action: #selector(PSSelected), for: .touchUpInside)
                    button.layer.cornerRadius = 0
                    button.layer.borderWidth = 1
                    button.layer.borderColor = UIColor.white.cgColor
                    print(button.frame.size)
                    collectionView.addSubview(button)
                    PS.append(button)
                    button.snp.makeConstraints { make in
                        make.width.equalTo(0.427 * screenWidth)
                        make.height.equalTo(0.204 * screenHeight)
                        if index != 1{
                            make.top.equalTo(collectionView).offset(Int(0.208 * screenHeight) * index)
                        }
                    }
                    button.titleLabel?.snp.makeConstraints { title in
                        title.bottom.equalTo(button.snp.bottom)
                    }
                    button.imageView?.snp.makeConstraints { image in
                        image.top.equalTo(button).offset(10)
                        image.leading.equalTo(collectionView).offset(15)
                    }
                    updateConsoles()
                }
            collectionView.reloadData()
        }
    }
    func getNumberOfDevices(completion: @escaping (Int) -> Void) {
        var number = 1
        let documentReference = db.collection("PS").document("PsNumber")

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
    func updateConsoles(){
        for i in self.PS{
            if i.imageView?.tintColor != UIColor(red: 0.518, green: 0.647, blue: 0.98, alpha: 1){
                i.imageView?.tintColor = .white
                i.setTitleColor(.white, for: .normal)
                i.layer.borderColor = UIColor.white.cgColor
            }
        }
        db.document("PS/console").getDocument{ [self]snapshot, error in
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
                    let button = PS[PS.firstIndex(where: {$0.titleLabel?.text == (pcData["ps"] as! [String])[index]})!]
                    PS[PS.firstIndex(where: {$0.titleLabel?.text == (pcData["ps"] as! [String])[index]})!].imageView?.tintColor = .red
                    if selectedConsoles.contains(Int((button.titleLabel?.text)!)!){
                        selectedConsoles.removeAll(where: {$0 == Int((button.titleLabel?.text)!)})
                    }
                    button.imageView?.tintColor = .red
                    button.setTitleColor(UIColor.red, for: .normal)
                    button.layer.borderColor = UIColor.red.cgColor
//                    print("Naruto")
                }
                if (result2 == .orderedAscending && result3 == .orderedDescending) || (result3 == .orderedSame){
                    
                    let button = PS[PS.firstIndex(where: {$0.titleLabel?.text == (pcData["ps"] as! [String])[index]})!]
                    PS[PS.firstIndex(where: {$0.titleLabel?.text == (pcData["ps"] as! [String])[index]})!].imageView?.tintColor = .red
                    if selectedConsoles.contains(Int((button.titleLabel?.text)!)!){
                        selectedConsoles.removeAll(where: {$0 == Int((button.titleLabel?.text)!)})
                        print(selectedConsoles.count)
                    }
                    button.imageView?.tintColor = .red
                    button.setTitleColor(UIColor.red, for: .normal)
                    button.layer.borderColor = UIColor.red.cgColor
                }
            }
            updateTextHourPicker()
            
        }
    }
    @objc func PSSelected(_ sender: UIButton) {
            // Handle button tap
            print("Button tapped: \(sender.currentTitle ?? "")")
//            print()
        if sender.imageView?.tintColor == .white{
            sender.imageView?.tintColor = UIColor(red: 0.518, green: 0.647, blue: 0.98, alpha: 1)
            sender.setTitleColor(UIColor(red: 0.518, green: 0.647, blue: 0.98, alpha: 1), for: .normal)
            sender.layer.borderColor = UIColor(red: 0.518, green: 0.647, blue: 0.98, alpha: 1).cgColor
            selectedConsoles.append(Int((sender.titleLabel?.text)!)!)
            updateTextHourPicker()
            
        }
        else{
            sender.imageView?.tintColor = .white
            sender.setTitleColor(.white, for: .normal)
            sender.layer.borderColor = UIColor.white.cgColor
            selectedConsoles = selectedConsoles.filter {$0 != Int((sender.titleLabel?.text)!)!}
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
      default:
          break
      }
      
        return date!.addingTimeInterval(timeInterval)
  }
    
    func updateHourPicker(){
        updateConsoles()
    }
    func updateTextHourPicker(){
        print(getHour())
        if getHour() < 18 && getHour() >= 8{
            dropDown.optionArray = [" 1 час - \(selectedConsoles.count * 1490) тенге", " 2 + 1 - \(selectedConsoles.count * 2990) тенге"]
        }
        else{
            dropDown.optionArray = [" 1 час - \(selectedConsoles.count * 1990) тенге", " 2 + 1 - \(selectedConsoles.count * 3990) тенге"]
        }
        switch dropDown.selectedIndex {
        case 0: // 1 час
            dropDown.text = dropDown.optionArray[0]
        case 1: // 2 + 1
            dropDown.text = dropDown.optionArray[1]
        default:
            break
        }
    }
    func getHour() -> Int{
        let calendar = Calendar.current
        return calendar.component(.hour, from: datePicker2.date)
    }
    func createHourPicker(){
        let valueLabel = UILabel()
        view.addSubview(valueLabel)
//        dropDown.handleKeyboard = false
        if getHour() < 18 && getHour() >= 8{
            dropDown.optionArray = [" 1 час - \(selectedConsoles.count * 1490) тенге", " 2 + 1 - \(selectedConsoles.count * 2990) тенге"]
        }
        else{
            dropDown.optionArray = [" 1 час - \(selectedConsoles.count * 1990) тенге", " 2 + 1 - \(selectedConsoles.count * 3990) тенге"]
        }
        dropDown.selectedRowColor = .white
//        dropDown.textAlignment = .center
        dropDown.optionIds = [1,23]
        dropDown.cornerRadius = 7
        dropDown.isSearchEnable = false
        dropDown.checkMarkEnabled = false
        dropDown.backgroundColor = UIColor(red: 0.885, green: 0.885, blue: 0.885, alpha: 1)
        dropDown.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(dropDown)
        dropDown.didSelect { [self] (selectedText, index, id) in
            self.updateConsoles()
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
//        let datePicker1 = UIDatePicker()
        
        datePicker1.layer.cornerRadius = 7
        datePicker2.layer.cornerRadius = 7
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
        let standardPC = db.collection("PS").document("console")
        let userReservations = db.collection("UserReservations").document("users")

        var psnumbers: [String] = []
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

            psnumbers = data["ps"] as? [String] ?? []
            dates = data["date"] as? [String] ?? []
            times = data["time"] as? [String] ?? []
            userPosts = data["userPost"] as? [String] ?? []

            for i in selectedConsoles {
                psnumbers.append("\(i)")
                dates.append(dateFormatter.string(from: combineDate()))
                times.append("\(dropDown.selectedIndex ?? 5)")
                userPosts.append(Auth.auth().currentUser?.email ?? "")
            }

            let mydata: [String: Any] = [
                "ps": psnumbers,
                "date": dates,
                "time": times,
                "userPost": userPosts
            ]

            standardPC.setData(mydata) { error in
                if let error = error {
                    print("Error writing to StandardPC/pc collection: \(error.localizedDescription)")
                } else {
                    print("Data successfully written to StandardPC/pc collection")
                    self.updateConsoles()
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

            for i in selectedConsoles {
                endTimes.append(dateFormatter.string(from: getEndTime(dateString: dateFormatter.string(from: combineDate()), index: dropDown.selectedIndex!)))
                types.append("PS - \(i)")
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
         updateConsoles()
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
extension PSRoom: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PS.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PSCell", for: indexPath)
        for subview in cell.subviews {
            subview.removeFromSuperview()
        }
        
        let ps = PS[indexPath.item]
        cell.addSubview(ps)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0.427 * screenWidth, height: 0.204 * screenHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
