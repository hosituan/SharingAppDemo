//
//  DetailViewController.swift
//  SharingAppDemo1
//
//  Created by Tuan Si Ho (3406) on 12/12/2022.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var exampleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Detail"
        setupView()
    }
    
    func setupView() {
        fetchButton.setAction { [weak self] in
            self?.fetchFromAPI()
        }
    }
    
    func fetchFromAPI() {
        RESTAPIService.fetchNotifcation { notis in
            //self.loadUI(notis: notis)
        }
    }
}
