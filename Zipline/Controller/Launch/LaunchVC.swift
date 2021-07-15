//
//  LaunchVC.swift
//  Zipline
//
//  Created by Sun on 2021/7/15.
//

import UIKit

class LaunchVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.pushViewController(MovieVC(), animated: true)
    }
}
