//
//  ViewController.swift
//  game-sweep
//
//  Created by David Kumar on 4/20/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    final let url = URL(string: "https://api.seatgeek.com/2/events?client_id=" + CLIENT_ID)
    
    @IBOutlet weak var tableView: UITableView!
    
    private var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJson()
        
        tableView.delegate = self
        tableView.dataSource = self
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
        
        //print(cell.title.text)
    
        
        return cell
        
    }
    
    


}

