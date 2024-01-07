//
//  ReservationTableViewController.swift
//  ASDS_CLUB
//
//  Created by Nurkhan Tashimov on 12.12.2023.
//

import UIKit
class ReservationCell: UITableViewCell {
    var typeLabel: UILabel!
    var startTimeLabel: UILabel!
    var endTimeLabel: UILabel!
}
class ReservationTableViewController: UITableViewController {

    var reservations: [Reservation] = [
        Reservation(type: "Computer", startTime: "10:00 AM", endTime: "11:00 AM"),
        Reservation(type: "PS", startTime: "2:00 PM", endTime: "3:00 PM"),
        // Add more data as needed
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "ReservationCell", bundle: nil), forCellReuseIdentifier: "ReservationCell")
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reservations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReservationCell", for: indexPath) as! ReservationCell

        let reservation = reservations[indexPath.row]
        cell.typeLabel.text = reservation.type
        cell.startTimeLabel.text = reservation.startTime
        cell.endTimeLabel.text = reservation.endTime

        return cell
    }

}
