//
//  HomeViewController.swift
//  SharingAppDemo1
//
//  Created by Tuan Si Ho (3406) on 12/12/2022.
//

import Foundation
import UIKit
import InjectHotReload

class HomeViewController: UIViewController {
    @IBOutlet weak var detailButton: UIButton!
    @IBOutlet weak var exampleLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView() {
        detailButton.setAction { [weak self] in
            self?.navigateToDetail()
        }
    }
    
    func navigateToDetail() {
        let detailVC = Inject.ViewControllerHost(DetailViewController())
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
