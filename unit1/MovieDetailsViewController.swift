//
//  MovieDetailsViewController.swift
//  unit1
//
//  Created by Desmond Ofori Atta on 9/28/21.
//

import UIKit
import AlamofireImage

class MovieDetailsViewController: UIViewController {
    
    var movie: [String:Any]!
    
    @IBOutlet weak var synopsis: UILabel!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var backdropImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        movieTitle.text = movie["title"] as? String
        synopsis.text = movie["overview"] as? String
        
        let base_url = "https://image.tmdb.org/t/p/"
        var size = "w185"
        let poster_path = (movie["poster_path"] as! String)
        let url = URL(string: base_url + size + poster_path)
        thumbnail.af.setImage(withURL: url!)
        
        size = "w780"
        let backdrop_path = (movie["backdrop_path"] as! String)
        let backdropUrl = URL(string: base_url + size + backdrop_path)
        backdropImage.af.setImage(withURL: backdropUrl!)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //Pass selected movie
        let trailerView = segue.destination as! TrailerViewController
        let movieID = String(movie["id"] as! Int)
        trailerView.movieID = movieID
    }

}
