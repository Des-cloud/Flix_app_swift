//
//  MoviesViewController.swift
//  unit1
//
//  Created by Desmond Ofori Atta on 9/16/21.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    //Array of dictionaries to hold the movies
    var movies = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: [])
                        as! [String: Any]
                self.movies = dataDictionary["results"] as! [[String:Any]]
                self.tableView.reloadData()
             }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell") as! MovieTableViewCell
        let movie = movies[indexPath.row]
        
        cell.movieTitle.text = (movie["title"] as! String)
        cell.movieSynopsis.text = (movie["overview"] as! String)
        
        let base_url = "https://image.tmdb.org/t/p/"
        let size = "w185"
        let poster_path = (movie["poster_path"] as! String)
        
        guard let url = URL(string: base_url + size + poster_path) else { return cell }
        cell.movieThumbnail.af.setImage(withURL: url)
        
        return cell
    }
    
}

