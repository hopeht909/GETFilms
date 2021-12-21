//
//  GetFilmsViewController.swift
//  GETPeople
//
//  Created by admin on 17/05/1443 AH.
//

import UIKit

class GetFilmsViewController: UITableViewController {

    let filmApi = "https://swapi.dev/api/films/"
    
    var filmArray = [filmCharacter]()
    
    struct filmCharacter{
       let title: String
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getFilmApi()
        
    }
    
    func getFilmApi(){
        let urlSession = URLSession.shared
        guard let url = URL.init(string: filmApi) else { return }
        
        let task = urlSession.dataTask(with: url) { data, response, error in
            self.parseData(data: data!)
        }
        
        task.resume()
    }
    
    func parseData(data: Data){
        do{
            if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                if let results = jsonResult["results"] {
                   let resultsArray = results as! NSArray
                    for result in resultsArray {
                        parsingMovieApi(dict: result as! [String : Any])
                    }
                    
                }}
        }
        catch{
            print(error.localizedDescription)
        }
    }
    func parsingMovieApi(dict: [String:Any]){
       guard let title = dict["title"] as? String else {
                 return
             }
        
        let filmCharacter = filmCharacter.init(title: title)
        filmArray.append(filmCharacter)
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmCell", for: indexPath)
        
        cell.textLabel?.text = filmArray[indexPath.row].title
        return cell
    }
    
}
