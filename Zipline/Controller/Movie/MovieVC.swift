//
//  MovieVC.swift
//  Zipline
//
//  Created by Sun on 2021/7/15.
//

import UIKit

class MovieVC: UIViewController {

    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment_control: UISegmentedControl!
    
    private var page = 0
    private var total_page = Int()
    private var isLoadingMore = false
    private var movies = [Movie]()
    private let titles = ["Top Rated Movies", "Popular Movies", "Recently Relased Movies"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        init_UI()
        read_movies()
        setupTableView()
    }
    
    @IBAction func segment_changed(_ sender: UISegmentedControl) {
        page = 0
        title_lbl.text = titles[sender.selectedSegmentIndex]
        read_movies()
    }
    
    func read_movies() {
        if page > 0 && page == total_page {
            print("read all")
            return
        }
        page += 1
        Services.get_top_movies(page: page) {(result, error) in
            if error != nil {
                print(error!)
                return
            }
            for item in result!["results"].arrayValue {
                self.movies.append(Movie(item))
            }
            self.total_page = result!["total_pages"].intValue
            DispatchQueue.main.async {
                self.isLoadingMore = false
                self.tableView.reloadData()
            }
        }
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 120
        tableView.register(UINib(nibName: "MovieCell", bundle: nil), forCellReuseIdentifier: "MovieCell")
        tableView.separatorStyle = .none
        tableView.reloadData()
    }
    
    func init_UI() {
        segment_control.selectedSegmentIndex = 0
        title_lbl.text = titles[0]
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
