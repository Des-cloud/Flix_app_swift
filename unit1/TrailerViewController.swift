//
//  TrailerViewController.swift
//  unit1
//
//  Created by Desmond Ofori Atta on 9/28/21.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {
    var movieID : String = ""
    var movie : String = ""
    @IBOutlet weak var trailerView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        
        let task = session.dataTask(with: request) { [self] (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                 let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: [])
                     as! [String: Any]

                 let movies = dataDictionary["results"] as! [[String:Any]]
                 for trailer in movies {
                     if (trailer["type"] as! String == "Trailer"){
                         self.movie = trailer["key"] as! String
                         break;
                     }
                 }
    
                 let trailerUrl = "https://www.youtube.com/watch?v=\(self.movie)"
                 self.trailerView.load(URLRequest(url:URL(string: trailerUrl)!))
             }
        }
        task.resume()
    }

}
