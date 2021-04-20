//
//  Event.swift
//  game-sweep
//
//  Created by David Kumar on 4/20/21.
//

import UIKit

class Event: Codable{
    
    let display_location : String
    let id: Int
    let title: String
    let datetime_local: Date
    let performers: Performers
    
    init(display_location : String, id: Int, title: String, datetime_local: Date, performers: Performers){
        
        self.display_location = display_location
        self.id = id
        self.title = title
        self.datetime_local = datetime_local
        self.performers = performers
    }
}

class Performers: Codable{
    
    let image: String
    
    init(image: String){
        
        self.image = image
    }
}
