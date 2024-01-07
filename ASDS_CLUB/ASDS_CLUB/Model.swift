//
//  Model.swift
//  ASDS_CLUB
//
//  Created by Nurkhan Tashimov on 14.12.2023.
//

import Foundation
import Fluent
final class User: Model {
    static let schema = "users"
    @ID(key: .id)
    var id: UUID?
    @Field(key: "name")
    var name: String
    init() { }
    init(id: UUID? = nil, name: String) {
        self.id = id
        self.name = name
    }
}
