//
//  User.swift
//  StayHydrated
//
//  Created by Paul Blanchet on 17/05/2023.
//

import Foundation

struct User: Codable, Hashable{
    var id_user:Int
    var nom : String
    var taille : Float
    var poids : Float
    var activite : String
    var objectif : Float
    var age: Int
    var obj_auto: Bool
}
