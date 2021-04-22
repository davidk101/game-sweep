//
//  Event.swift
//  game-sweep
//
//  Created by David Kumar on 4/20/21.
//

import UIKit

class Events: Codable{
    
    let events: [Event]
    
    init(events: [Event]){
        
        self.events = events
    }
}

class Event: Codable{
    
    //let display_location : String
    let id: Int
    //let title: String
    //let datetime_local: Date
    //let performers: Performers
    
    init(id: Int){
        
        //self.display_location = display_location
        self.id = id
        //self.title = title
        //self.datetime_local = datetime_local
        //self.performers = performers
    }
}
