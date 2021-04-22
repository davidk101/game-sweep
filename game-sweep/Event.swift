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
    
    let id: Int
    let short_title: String
    let datetime_local: String
    let venue: Venue
    let performers: [Performers]
    
    init(id: Int, datetime_local: String, short_title: String, venue: Venue, performers: [Performers]){
        
        self.id = id
        self.short_title = short_title
        self.datetime_local = datetime_local
        self.venue = venue
        self.performers = performers
    }
}

class Venue: Codable{
    
    let display_location: String
    
    init(display_location: String){
        
        self.display_location = display_location
    }
}

class Performers: Codable{
    
    let image: String
    
    init(image: String){
        
        self.image = image
    }
}
