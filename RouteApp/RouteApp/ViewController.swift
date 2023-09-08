//
//  ViewController.swift
//  RouteApp
//
//  Created by Nurkhan Tashimov on 08.09.2023.
//

import UIKit
import MapKit
import CoreLocation
class ViewController: UIViewController {

    
    let mapView : MKMapView = { // my map
       let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false // позволяет управлять размером и позицией карты без ограничений
        return mapView
    }()
    let addAddressButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let routeButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "route"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    let resetButton : UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "reset"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setConstraints()
        addAddressButton.addTarget(self, action: #selector(addAdressButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        routeButton.addTarget(self, action: #selector(routeButtonTapped), for: .touchUpInside)
    }
    @objc func addAdressButtonTapped(){
        print("Hi")
    }
    @objc func resetButtonTapped(){
        
    }
    @objc func routeButtonTapped(){
        
    }
}

extension ViewController{
    func setConstraints(){
        view.addSubview(mapView) // mapView будет отображаться внутри контроллера viewController
        NSLayoutConstraint.activate([ // здесь активируются ограничения для mapView
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0), // constant это отступ от определнной позиции, 0 гарантирует что покроет всю поверхность
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
        mapView.addSubview(addAddressButton)
        NSLayoutConstraint.activate([
            addAddressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
            addAddressButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            addAddressButton.heightAnchor.constraint(equalToConstant: 70),
            addAddressButton.widthAnchor.constraint(equalToConstant: 70)
        ])
        mapView.addSubview(routeButton)
        NSLayoutConstraint.activate([
            routeButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            routeButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -30),
            routeButton.heightAnchor.constraint(equalToConstant: 70),
            routeButton.widthAnchor.constraint(equalToConstant: 70)
        ])
        mapView.addSubview(resetButton)
        NSLayoutConstraint.activate([
            resetButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            resetButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
            resetButton.heightAnchor.constraint(equalToConstant: 70),
            resetButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}

