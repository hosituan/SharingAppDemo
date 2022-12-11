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
    let updateButton = UIButton().then {
        $0.setTitle("Update constraint", for: .normal)
        $0.setTitleColor(.blue, for: .normal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Home"
        setupView()
    }
    
    func setupView() {
        view.addSubviews(centerLabel, button, updateButton)
        centerLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(16)
            make.centerX.equalToSuperview()
        }
        
        button.snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(240)
            make.center.equalToSuperview()
        }
        updateButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(button.snp.bottom).offset(40)
        }
        button.setAction { [weak self] in
            self?.navigateToDetail()
        }
        updateButton.setAction { [weak self] in
            guard let self = self else { return }
            self.centerLabel.snp.updateConstraints({ make in
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(30)
            })
        }
    }
    
    func navigateToDetail() {
        let detailVC = Inject.ViewControllerHost(DetailViewController())
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
