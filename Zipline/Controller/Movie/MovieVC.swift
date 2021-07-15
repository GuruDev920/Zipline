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

    }
}
