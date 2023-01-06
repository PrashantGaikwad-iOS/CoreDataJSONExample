//
//  Employee.swift
//  CoreDBLearning
//
//  Created by prashant on 30/12/22.
//

import Foundation

struct Employee: Decodable {
    var name, email : String?
    var profilePicture: Data?
    let id: UUID
    let jsonFile: Data?
}

struct User: Decodable {
    var userId, id : Int
    var title, body: String
}
