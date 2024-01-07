//
//  ViewController.swift
//  towns
//
//  Created by Nurkhan Tashimov on 15.09.2023.
//

import UIKit
import Foundation


class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var listOfTowns = [
            ("Tokyo","https://upload.wikimedia.org/wikipedia/commons/b/b2/Skyscrapers_of_Shinjuku_2009_January.jpg"),
            ("Kyoto","https://lp-cms-production.imgix.net/2021-02/shutterstockRF_787331263.jpg"),
            ("Osaka","https://gaijinpot.scdn3.secure.raxcdn.com/app/uploads/sites/4/2023/02/iStock-Eloi_Omella-osaka-tower.jpg"),
            ("Bern","https://www.bern.com/assets/images/7/altstadt2-884b8f17.jpg"),
            ("Tzurich","https://tripmydream.cc/travelhub/travel/blocks/14/9298/block_149298.jpg?v1"),
            ("Zheneva","https://traveller-eu.ru/sites/default/files/ad_238774678-800x530.jpg"),
            ("Berlin","https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Museumsinsel_Berlin_Juli_2021_1_%28cropped%29.jpg/1200px-Museumsinsel_Berlin_Juli_2021_1_%28cropped%29.jpg"),
            ("Kyoln","https://www.bsigroup.ru/upload/resize_cache/tour/5/2/6/640_410_2/526a744ce0ba27b928ddb240e610afa8.jpg"),
            ("Gamburg","https://tripmydream.cc/travelhub/travel/blocks/14/5903/block_145903.jpg?v1"),
            ("New York","https://upload.wikimedia.org/wikipedia/commons/thumb/7/7a/View_of_Empire_State_Building_from_Rockefeller_Center_New_York_City_dllu_%28cropped%29.jpg/1200px-View_of_Empire_State_Building_from_Rockefeller_Center_New_York_City_dllu_%28cropped%29.jpg"),
            ("San Francisco","https://cdn.britannica.com/13/77413-050-95217C0B/Golden-Gate-Bridge-San-Francisco.jpg"),
            ("Rome","https://tourismmedia.italia.it/is/image/mitur/20220127150143-colosseo-roma-lazio-shutterstock-756032350-1?wid=1600&hei=900&fit=constrain,1&fmt=webp")
        ]
//    var listOfTowns = [("astana", "https://upload.wikimedia.org/wikipedia/commons/6/66/Central_Downtown_Astana_2.jpg"), ("almaty", "https://ru.m.wikipedia.org/wiki/%D0%A4%D0%B0%D0%B9%D0%BB:Almaty_montage_2015.PNG"), ("ekibastuz", "https://upload.wikimedia.org/wikipedia/commons/thumb/c/ce/Ekibastuz-2_railway_station._Main_hall%2C_night._2009.JPG/500px-Ekibastuz-2_railway_station._Main_hall%2C_night._2009.JPG"), ("pavlodar" , "https://ru.m.wikipedia.org/wiki/%D0%A4%D0%B0%D0%B9%D0%BB:%D0%93%D0%BE%D1%80%D0%BE%D0%B4_%D0%9F%D0%B0%D0%B2%D0%BB%D0%BE%D0%B4%D0%B0%D1%80,_%D0%9A%D0%B0%D0%B7%D0%B0%D1%85%D1%81%D1%82%D0%B0%D0%BD._%D0%97%D0%B4%D0%B0%D0%BD%D0%B8%D0%B5_%D0%B0%D0%BA%D0%B8%D0%BC%D0%B0%D1%82%D0%B0_%D0%9F%D0%B0%D0%B2%D0%BB%D0%BE%D0%B4%D0%B0%D1%80%D1%81%D0%BA%D0%BE%D0%B9_%D0%BE%D0%B1%D0%BB%D0%B0%D1%81%D1%82%D0%B8.jpg"),("newyork","https://ru.m.wikipedia.org/wiki/%D0%A4%D0%B0%D0%B9%D0%BB:View_of_Empire_State_Building_from_Rockefeller_Center_New_York_City_dllu.jpg"),("tokyo","https://ru.m.wikipedia.org/wiki/%D0%A4%D0%B0%D0%B9%D0%BB:Tokyo_Montage_2015.jpg"),("moscow","https://upload.wikimedia.org/wikipedia/commons/thumb/0/01/Moscow_July_2011-16.jpg/532px-Moscow_July_2011-16.jpg"),("novosibirsk","https://upload.wikimedia.org/wikipedia/commons/thumb/8/82/Bugrinskiybridge.jpg/264px-Bugrinskiybridge.jpg"),("shymkent","https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Ordabasy_Plaza_%28Shymkent%29.jpg/274px-Ordabasy_Plaza_%28Shymkent%29.jpg"),("gonkong","https://upload.wikimedia.org/wikipedia/commons/thumb/2/23/Hong_Kong_Skyline_Restitch_-_Dec_2007.jpg/400px-Hong_Kong_Skyline_Restitch_-_Dec_2007.jpg"),("london","https://upload.wikimedia.org/wikipedia/commons/thumb/c/cd/London_Montage_L.jpg/550px-London_Montage_L.jpg"),("singapore","https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/1_singapore_city_skyline_dusk_panorama_2011.jpg/600px-1_singapore_city_skyline_dusk_panorama_2011.jpg"),("paris","https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/La_Tour_Eiffel_vue_de_la_Tour_Saint-Jacques%2C_Paris_ao%C3%BBt_2014_%282%29.jpg/560px-La_Tour_Eiffel_vue_de_la_Tour_Saint-Jacques%2C_Paris_ao%C3%BBt_2014_%282%29.jpg"),("stambul","https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Istanbul_view.png/532px-Istanbul_view.png"),("praga","https://upload.wikimedia.org/wikipedia/commons/thumb/f/fb/Prague_Collage_2017.png/580px-Prague_Collage_2017.png"),("milan","https://upload.wikimedia.org/wikipedia/commons/thumb/5/58/Milan.Proper.Wikipedia.Image.png/534px-Milan.Proper.Wikipedia.Image.png"),("osaka","https://upload.wikimedia.org/wikipedia/commons/thumb/4/4b/Osaka_montage.jpg/580px-Osaka_montage.jpg"),("berlin","https://upload.wikimedia.org/wikipedia/commons/thumb/a/a6/Brandenburger_Tor_abends.jpg/264px-Brandenburger_Tor_abends.jpg"),("Pekin","https://upload.wikimedia.org/wikipedia/commons/thumb/d/dd/Beijing_montage.png/548px-Beijing_montage.png"),("sidney","https://upload.wikimedia.org/wikipedia/commons/thumb/6/65/Sydney_montage_2018.jpg/508px-Sydney_montage_2018.jpg")]
    var used = [Int]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        }
    
}

extension ViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200.0
    }
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Hi")
//    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfTowns.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
//        cell.label.text = listOfTowns[indexPath.row].0
        
//            DispatchQueue.main.async {
//                print("hello")
//                if let imageUrl = URL(string: self.listOfTowns[indexPath.row].1){
//                    print("hi")
//
//                    URLSession.shared.dataTask(with: imageUrl) { data, response, error in if let data = data{
////                        print("hello")
//                        if !cell.initilized{
//                            cell.setup(image: UIImage(data: data)! , text: self.listOfTowns[indexPath.row].0)
//                        }
//                        else{
//                            cell.label.text = self.listOfTowns[indexPath.row].0
//                        }
//                    }
//                    }.resume()
//                }
//            }
//        cell.initilized = true
//        print(cell.label)
//        if let imageUrl = URL(string: listOfTowns[indexPath.row].1) {
//                        URLSession.shared.dataTask(with: imageUrl) { data, response, error in
//                            if let data = data {
//                                DispatchQueue.main.async {
//                                    if !cell.initilized{
//                                        cell.setup(image: UIImage(data: data)! , text: self.listOfTowns[indexPath.row].0)
//                                    } else {
//                                        cell.myImage.image = UIImage(data: data)!
//                                        cell.label.text = self.listOfTowns[indexPath.row].0
//                                    }
//                                }
//                            }
//                        }.resume()
//                    }
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomTableViewCell
        if !cell.initilized{
            print(indexPath.row)
            cell.label.text = self.listOfTowns[indexPath.row].0
            cell.initilized = true
        }
        if let imageUrl = URL(string: self.listOfTowns[indexPath.row].1) {
               URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                   if let data = data {
                       DispatchQueue.main.async {
                           cell.myImage.image = UIImage(data: data)
                       }
                   }
               }.resume()
           }
        return cell
    }
}
