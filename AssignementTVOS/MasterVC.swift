//
//  MasterVC.swift
//  AssignementTVOS
//
//  Created by Abhilash k George on 26/12/22.
//

import UIKit

class MasterVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchResultsUpdating {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var universities: [University] = [] {
        didSet {
            reloadTableViewData()
        }
    }
    
    var networkManager = NetworkManager()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
   
        guard let url = URL(string: "http://universities.hipolabs.com/search?name=middle") else { return }
        print("url called")
        fetchUniversities(url: url)
                

        
    }
    
    func fetchUniversities(url: URL) {
        universities = []
        networkManager.fetchUniversities(url: url) { universities in
            self.universities = universities
        }
    }
    
    
    func reloadTableViewData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return universities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")! as! CustomTableViewCell
        
        let university = universities[indexPath.row]
        cell.universityNameLbl.text = university.name
        cell.countryNameLbl.text = university.country
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomTableViewCell
        tableView.tableHeaderView = headerCell
        headerCell.universityNameLbl.text = "University"
        headerCell.countryNameLbl.text = "Country"
        headerCell.backgroundColor = .black
       
        return headerCell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        
       
        
        guard let text = searchController.searchBar.text else { return }
        

        if text.isEmpty {
            
            searchController.searchBar.placeholder = "Search for your country"


        } else {
            guard let url = URL(string: "http://universities.hipolabs.com/search?name=middle&country=\(text)") else { return }
            print(url)
            DispatchQueue.global(qos: .userInteractive).async {
                self.fetchUniversities(url: url)
            }
            
         }
        
    }
    


}

