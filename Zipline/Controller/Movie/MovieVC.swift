//
//  MovieVC.swift
//  Zipline
//
//  Created by Sun on 2021/7/15.
//

import UIKit

class MovieVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private var page = 1
    private var isLoadingMore = false
    private var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        read_movies()
        setupTableView()
    }
    
    func read_movies() {
        
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.mask = nil
        tableView.reloadData()
    }
}

extension MovieVC: UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        
        cell.movie = movies[indexPath.row]
        
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHiehgt = scrollView.contentSize.height
        
        if (offsetY > contentHiehgt - scrollView.frame.height) && !isLoadingMore {
            isLoadingMore = true
            self.read_movies()
        }
    }
}
