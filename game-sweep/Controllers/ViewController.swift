//
//  ViewController.swift
//  game-sweep
//
//  Created by David Kumar on 4/20/21.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
        
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
        
    private var events: [Event] = []

    override func viewDidLoad() {
        super.viewDidLoad()
            
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 199
        
    }
    
    // remove existing notifications
    override func viewWillDisappear(_ animated: Bool) {
        
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "cellData") , object: nil)
    }
    
    func downloadJson(text: String){
        
        if (text == ""){
            
            DispatchQueue.main.async {
                
                self.events = []
                self.tableView.tableFooterView = UIView()
                self.tableView.reloadData()
            }
        }
        
        else{
            
            let url = URL(string: "https://api.seatgeek.com/2/events?q=" + text + "&client_id=" + CLIENT_ID)
            
            guard let downloadURL = url else{
                return
            }
            
            URLSession.shared.dataTask(with: downloadURL){ [self]data, urlReponse, error in
                
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
        
        let text = searchText
        
        downloadJson(text: text)
    }
    
    // to persist text in search bar
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
        searchBar.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        NotificationCenter.default.post(name: Notification.Name(
                                            rawValue: "cellData"), object: ["titleString": events[indexPath.row].short_title, "locationString": events[indexPath.row].venue.display_location, "timeString": events[indexPath.row].datetime_local, "imageURLString": events[indexPath.row].performers[0].image])
        
        guard let vc = storyboard?.instantiateViewController(identifier: "detail_vc") as? DetailViewController else{
            
            return 
        }
        
        present(vc, animated: true, completion: nil)
    }
}

