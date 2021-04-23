//
//  ViewController.swift
//  game-sweep
//
//  Created by David Kumar on 4/20/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    final let url = URL(string: "https://api.seatgeek.com/2/events?client_id=" + CLIENT_ID)
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    private var events = [Event]()
    
    private var filteredEvents: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJson()
        
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        tableView.rowHeight = 220
    }
    
    func downloadJson(){
        
        guard let downloadURL = url else{
            return
        }
        
        URLSession.shared.dataTask(with: downloadURL){data, urlReponse, error in
            
            guard let data = data, error == nil, urlReponse != nil else{
                
                print("network error")
                return
            }
            
            do{
                
                let decoder = JSONDecoder()
                let downloadedEvents = try decoder.decode(Events.self, from: data)
                self.events = downloadedEvents.events
                
                DispatchQueue.main.async {
                    
                    self.tableView.reloadData()
                }
                
            }
            catch{
                
                print("error parsing JSON")
            }
                                                       
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell") as? EventCell else{
            
            return UITableViewCell()
        }
        
        cell.title.text = events[indexPath.row].short_title
        cell.location.text = events[indexPath.row].venue.display_location
        cell.time.text = events[indexPath.row].datetime_local
        
        if let imageURL = URL(string: events[indexPath.row].performers[0].image){
            
            DispatchQueue.global().async {
                
                let data = try? Data(contentsOf: imageURL)
                
                if let data = data{
                    
                    let image = UIImage(data: data)
                    
                    DispatchQueue.main.async {
                        
                        cell.imgView.image = image
                    }
                    
                }
            }
            
        }
        
        return cell
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        filteredEvents = []
        
        if searchText == ""{
            
            filteredEvents = events
        }
        
        else{
            
            for event in events{
                
                if event.short_title.lowercased().contains(searchText.lowercased()){
                    
                    filteredEvents.append(event)
                }
            }
            
        }
        
        self.tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        filteredEvents = []
        filteredEvents = events
        self.tableView.reloadData()
    }
    
    // to persist text in search bar
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
}

