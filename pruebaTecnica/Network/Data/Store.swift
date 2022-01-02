//
//  Store.swift
//  pruebaTecnica
//
//  Created by Nestor Cortés on 02-01-22.
//

import Foundation

struct StoreResponse: Decodable {
    let data: [DataArr]?
    let meta: Meta?
    let links: Links?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case meta = "meta"
        case links = "links"
    }
}

struct DataArr : Decodable{
    let data: [Data]
    enum CodingKeys: String, CodingKey {
      case data = "data"
    }
}

struct Data : Decodable{
    let id: String?
    let type: String?
    let attributes: Attributes?
    enum CodingKeys: String, CodingKey {
        case id
        case type
        case attributes
    }
}

struct Attributes : Decodable{
    let name: String?
    let code: String?
    let active: Bool?
    let full_address: String?
    let created_at: String?
    enum CodingKeys: String, CodingKey {
        case name
        case code
        case active
        case full_address
        case created_at
    }
}


struct Meta : Decodable{
    let pagination: Pagination?
    enum CodingKeys: String, CodingKey {
        case pagination = "pagination"
    }
}

struct Pagination : Decodable{
    let current_page: Int?
    let total: Int?
    let per_page: Int?
    enum CodingKeys: String, CodingKey {
        case current_page
        case total
        case per_page
    }
}

struct Link : Decodable{
    let link: Links?
    enum CodingKeys: String, CodingKey {
        case link = "links"
    }
}

struct Links : Decodable{
    let prev: String?
    let next: String?
    let first: String?
    let last: String?
    let selfp: String?
    enum CodingKeys: String, CodingKey {
        case prev
        case next
        case first
        case last
        case selfp = "self"
    }
}

