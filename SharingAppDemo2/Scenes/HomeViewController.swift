//
//  HomeViewController.swift
//  SharingAppDemo2
//
//  Created by Tuan Si Ho (3406) on 11/12/2022.
//

import Foundation
import UIKit
import SnapKit
import Then
import InjectHotReload

class HomeViewController: UIViewController {
    let centerLabel = UILabel().then {
        $0.text = "Example label"
        $0.font = .systemFont(ofSize: 16)
        $0.backgroundColor = .white
    }
    
    let button = UIButton().then {
        $0.setTitle("Navigate Detail", for: .normal)
        $0.backgroundColor = .blue
        $0.layer.cornerRadius = 12
        $0.layer.masksToBounds = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"
        setupView()
    }
    
    func setupView() {
        view.addSubviews(centerLabel, button)
        centerLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        button.snp.makeConstraints { make in
            make.top.equalTo(centerLabel.snp.bottom).offset(12)
            make.height.equalTo(56)
            make.width.equalTo(240)
            make.centerX.equalToSuperview()
        }
        
        button.setAction { [weak self] in
            self?.navigateToDetail()
        }
    }
    
    func navigateToDetail() {
        let detailVC = Inject.ViewControllerHost(DetailViewController())
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
