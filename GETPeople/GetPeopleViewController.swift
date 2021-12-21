//
//  ViewController.swift
//  GETPeople
//
//  Created by admin on 17/05/1443 AH.
//

import UIKit

class GetPeopleViewController: UITableViewController {
    
    let movieApi = "https://swapi.dev/api/people/"
    
    var movieArray: [movieCharacter] = []
    
    struct movieCharacter {
        let name: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMovieApi()
    }
    
    func getMovieApi(){
        let urlSession = URLSession.shared
        guard let url = URL.init(string: movieApi) else { return }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            self.parseData(data: data!)
        
    }
 
    task.resume()
}
    func parseData(data: Data){
        do {
        
     let jsonResult = try JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
            if let results = jsonResult["results"] as? [[String:Any]]{
            for result in results {
                parsingMovieApi(dict: result)
            }}
        
    } catch {
        print(error.localizedDescription)
    }
    }
    func parsingMovieApi(dict: [String:Any]){
       guard let name = dict["name"] as? String else {
                 return
             }
        
        let movieCharacter = movieCharacter.init(name: name)
        movieArray.append(movieCharacter)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        print(movieCharacter)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PeopleCell", for: indexPath)
        cell.textLabel?.text = movieArray[indexPath.row].name
        return cell
    }
}

