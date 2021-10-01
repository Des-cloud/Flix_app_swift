//
//  MovieGridViewController.swift
//  unit1
//
//  Created by Desmond Ofori Atta on 9/28/21.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var movies = [[String:Any]]()
    var filteredData = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
//        searchTab.delegate = self
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 20
        layout.minimumInteritemSpacing = 20

        let width = (view.frame.size.width - layout.minimumLineSpacing) / 2
        layout.itemSize = CGSize(width: width, height: width * 3/2)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
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
                 self.filteredData = self.movies
                 self.collectionView.reloadData()
             }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
        
        let movie = filteredData[indexPath.row]
        let base_url = "https://image.tmdb.org/t/p/"
        let size = "w185"
        let poster_path = (movie["poster_path"] as! String)
        
        guard let url = URL(string: base_url + size + poster_path) else { return cell }
        cell.posterView.af.setImage(withURL: url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView : UICollectionReusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "searchBar", for: indexPath)
        
        return searchView
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Find the selected movie
        let cell = sender as! UICollectionViewCell
        let index = collectionView.indexPath(for: cell)!
        let movie = filteredData[index.row]
        
        //Pass selected movie
        let movieDetailsController = segue.destination as! MovieDetailsViewController
        
        movieDetailsController.movie = movie
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        filteredData = []
        if searchBar.text == ""{
            filteredData = movies
        }
        else{
            for movie in movies {
                let name = movie["title"] as! String
                if name.lowercased().contains(searchBar.text!.lowercased()){
                    filteredData.append(movie)
                }
            }
        }
        self.collectionView.reloadData()
    }
    
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filteredData = []
//        if searchText == ""{
//            filteredData = movies
//        }
//        else{
//            for movie in movies {
//                let name = movie["title"] as! String
//                if name.lowercased().contains(searchText.lowercased()){
//                    filteredData.append(movie)
//                }
//            }
//        }
//        self.collectionView.reloadData()
//    }

}
