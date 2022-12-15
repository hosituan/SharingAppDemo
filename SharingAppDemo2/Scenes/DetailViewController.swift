//
//  DetailViewController.swift
//  SharingAppDemo2
//
//  Created by Tuan Si Ho (3406) on 11/12/2022.
//

import Foundation
import SnapKit
import Then
import Alamofire

class DetailViewController: UIViewController {
    let exampleLabel = UILabel().then {
        $0.text = "Detail screen new"
    }
    let newLabel = UILabel().then {
        $0.text = "new label"
    }
    let fetchButton = UIButton().then {
        $0.setTitle("Fetch Data", for: .normal)
        $0.backgroundColor = .red
        $0.cornerRadius = 12
    }
    let stackView = UIStackView().then {
        $0.axis = .vertical
        $0.distribution = .fill
        $0.spacing = 16
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Detail 1"
        view.backgroundColor = .white
        setupView()
    }
    
    func setupView() {
        view.addSubviews(exampleLabel, fetchButton, stackView)
        
        exampleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(110)
            make.left.equalToSuperview().offset(99)
        }
        fetchButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(56)
            make.width.equalTo(240)
        }
        fetchButton.setAction { [weak self] in
            self?.fetchFromAPI()
        }
        stackView.snp.makeConstraints { make in
            make.top.equalTo(fetchButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(16)
            make.right.equalToSuperview().inset(16)
        }
        newLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(16)
        }
    }
    
    func createStackView(title: String?) -> UIView {
        let view = UIView()
        let titleLabel = UILabel().then {
            $0.text = title
            $0.font = .systemFont(ofSize: 16)
        }
        view.addSubviews(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(16)
            make.bottom.equalToSuperview().inset(16)
        }
        return view
    }
    
    func fetchFromAPI() {
        RESTAPIService.fetchNotifcation { notis in
            self.loadUI(notis: notis)
        }
    }
    
    func loadUI(notis: [NotificationData]?) {
        if let notis = notis {
            // Clear current subview
            for subview in stackView.arrangedSubviews {
                subview.removeFromSuperview()
            }
            
            // Reload new data
            for noti in notis {
                let stack = self.createStackView(title: noti.title)
                self.stackView.addArrangedSubviews(stack)
            }
        }
    }
}
