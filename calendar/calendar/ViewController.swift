import UIKit
class ViewController: UIViewController {
    var data = [[String: String]]()
    static var calendar = UICalendarView()
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
//        UserDefaults.standard.removeObject(forKey: "20231017")
        self.navigationItem.title = "Calendar App"
        
        let goToButton = UIBarButtonItem(title: "add", style: .plain, target: self, action: #selector(addEvent))
        self.navigationItem.rightBarButtonItem = goToButton
        createCalendar()
    }
    @objc func addEvent(_ sender: Any){
        let storyboard = UIStoryboard(name:"Main",bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "FirstViewController")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func updatingCalendar(dateComponents: DateComponents){
        
    }
    func createCalendar(){
        ViewController.calendar.translatesAutoresizingMaskIntoConstraints = false
        ViewController.calendar.calendar = .current
        ViewController.calendar.locale = .current
        ViewController.calendar.fontDesign = .rounded
        ViewController.calendar.delegate = self
        let dateSelection = UICalendarSelectionSingleDate(delegate: self)
        ViewController.calendar.selectionBehavior = dateSelection
        view.addSubview(ViewController.calendar)
        
        
        NSLayoutConstraint.activate([
            ViewController.calendar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            ViewController.calendar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            ViewController.calendar.heightAnchor.constraint(equalToConstant: 350),
            ViewController.calendar.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
        ])
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: ViewController.calendar.bottomAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
func transformDate(date: Date) -> String{
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyyMMdd"
    return dateFormatter.string(from: date)
}
func getMonth(date: Date) -> Int{
    let calendar = Calendar.current
    return calendar.component(.month, from: date)
}
func getYear(date: Date) -> Int{
    let calendar = Calendar.current
    return calendar.component(.year, from: date)
}
extension ViewController: UICalendarViewDelegate, UICalendarSelectionSingleDateDelegate,UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let value1 = data[indexPath.row]["name"]
        let value2 = data[indexPath.row]["time"]
        print(value1!)
        cell.textLabel?.text = value2! + " " + value1!
//        print(value1!,value2!)
        return cell
    }
    func dateSelection(_ selection: UICalendarSelectionSingleDate, didSelectDate dateComponents: DateComponents?) {
        let date = Calendar.current.date(from: dateComponents!)
        
        if UserDefaults.standard.dictionaryRepresentation().keys.contains(transformDate(date: date!)){
            data = (UserDefaults.standard.object(forKey: transformDate(date: date!)) as? [[String: String]])!
            tableView.reloadData()
        }
        else{
            data.removeAll()
            tableView.reloadData()
            
        }
    }
    func calendarView(_ calendarView: UICalendarView, decorationFor dateComponents: DateComponents) -> UICalendarView.Decoration? {
        
        guard let date = Calendar.current.date(from: dateComponents) else {
            return nil
        }
        let dotView = UIView()
        if (getMonth(date: Calendar.current.date(from: dateComponents)!) != getMonth(date: Date())) && (getYear(date: Calendar.current.date(from: dateComponents)!) != getYear(date: Date())){
            if dateComponents.day == 1{
                dateSelection(UICalendarSelectionSingleDate.init(delegate: self), didSelectDate: dateComponents)
            }
        }
        if UserDefaults.standard.dictionaryRepresentation().keys.contains(transformDate(date: date)){
            dotView.frame = CGRect(x: 0, y: 0, width: 6, height: 6)
            dotView.layer.cornerRadius = 3
            dotView.backgroundColor = UIColor.red
        }   
        return .customView {
            return dotView
         }
    }
}
