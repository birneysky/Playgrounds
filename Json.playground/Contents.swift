import UIKit
import Foundation

var str = "Hello, playground"

struct Loaction: Codable {
    var Longitude: Double
    var latitude: Double
}


struct GroceryProduct: Codable {
    private var name: String
    var points: Int
    var description: String?
    private var test: [Loaction]
    private var map: [Int:Loaction]
    init(name:String, points: Int, description:String) {
        self.name = name
        self.points = points
        self.description = description
        self.test = [Loaction(Longitude: 35.86, latitude: 78.99) ]
        self.map = [80809:Loaction(Longitude: 35.86, latitude: 78.99)]
    }
}

let pear = GroceryProduct(name: "Pear", points: 250, description: "A ripe pear.")

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted

let data = try encoder.encode(pear)
print(String(data: data, encoding: .utf8)!)

/// 如果某个属性，在结构体中未定义，解码时会自动忽略这条数据

let decoder = JSONDecoder()
let product = try decoder.decode(GroceryProduct.self, from: data)
print(product)
