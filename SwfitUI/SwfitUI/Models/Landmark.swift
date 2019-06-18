//
//  Landmark.swift
//  SwfitUI
//
//  Created by birney on 2019/6/18.
//  Copyright © 2019 COOL. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Landmark {
    var id: Int
    var name: String
    fileprivate var imageName: String
    fileprivate var coordinates: Coordinates
    var state: String
    var part: String
    var category: Category
    
    var locationCoordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: coordinates.latitude, longitude: coordinates.longitude)
    }
    

//    func image(forSize size: Int) -> Image {
//        //ImageStore.shared.image(name: imageName, size: size)
//    }
    
    enum Category: String, CaseIterable, Codable, Hashable {
        case featured = "Featured"
        case lakes = "Lakes"
        case rivers = "Rivers"
    }
}


struct Coordinates: Hashable, Codable {
    var latitude: Double
    var longitude: Double
}
