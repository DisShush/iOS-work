//
//  JSONData.swift
//  test_work
//
//  Created by Владислав Шушпанов on 10.08.2021.
//


import Foundation

struct JSONData: Codable {
    let data: [Datum]
    let view: [String]
}

struct Datum: Codable {
    let name: String
    let data: DataClass
}

struct DataClass: Codable {
    let text: String?
    let url: String?
    let selectedId: Int?
    let variants: [Variant]?

}

struct Variant: Codable {
    let id: Int
    let text: String
}
