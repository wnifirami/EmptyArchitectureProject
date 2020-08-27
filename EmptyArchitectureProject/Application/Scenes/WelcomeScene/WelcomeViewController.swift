//
//  WelcomeViewController.swift
//  EmptyArchitectureProject
//
//  Created by Rami Ounifi on 6/19/20.
//  Copyright © 2020 Yellow. All rights reserved.
//

import Foundation
import RxSwift
import NotificationBannerSwift
import RealmSwift
class WelcomeViewController: UIViewController {
    let disposeBag = DisposeBag()
    var viewModel: WelcomeViewModel?
    let realm =  RealmService.shared
    let userCellId = "UserCell"
    let userNib = UINib(nibName: "UserCell", bundle: nil)
    var usersArray: [UserResponseElement] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBindings()
        registerTable()
        // Do any additional setup after loading the view.
//        if  !NetworkRequests.shared.isConnected {
//
//        }
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate, appDelegate.isConnected {
            viewModel?.loadUsers()
        } else {
            getDataFromRealm()
        }
        
    }
    
    func setupBindings() {
        viewModel?.loadUsers()
        viewModel?
            .state
            .asDriver()
            .drive(onNext: stateChanged)
            .disposed(by: disposeBag)
    }
    
    // MARK: - init the views
    /// register table view
    func registerTable() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(userNib, forCellReuseIdentifier: userCellId)
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        
        
    }
    func stateChanged(state: WelcomeViewModel.State) {
        switch state {
        case .loading:
            debugPrint("loading")
        case .error(_):
            debugPrint("loading")
            
        case .loaded(let data):
            debugPrint(data, "data")
             realm.deleteAll(UserResponseElement.self).subscribe(onNext: { (isDeleted) in
                         debugPrint(isDeleted, "element deleted ")
                         if isDeleted {
                             self.realm.createArray(object: data).subscribe(onNext: { (status) in
                                 debugPrint(status, "added")
                             }).disposed(by: self.disposeBag)
                         }
                     }).disposed(by: disposeBag)
                     getDataFromRealm()
            
        default:
            break
        }
    }
        func getDataFromRealm() {
            realm.checkData(object: UserResponseElement.self).subscribe(onNext: { [weak self ] count  in
                if count > 0 {
                    self?.realm.readArray(object: UserResponseElement.self).subscribe(onNext: { [weak self] users in
                        self?.usersArray = users
                        }, onError: { (error) in
                            debugPrint(error, "error")
                    }).disposed(by: self!.disposeBag)
                } else {
                    AlertPopUp.alert.getAlertWithOkMessage(title: "Error", message: "Veuillez vous connecter afin d avoir des données", viewController: self!)
                }
            }).disposed(by: disposeBag) }
        
    }
    



extension WelcomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: userCellId, for: indexPath) as? UserCell
        cell?.descriptionUser.text = usersArray[indexPath.row].body
        cell?.titleUser.text = usersArray[indexPath.row].title
        return cell ?? UITableViewCell()
    }
    
    
}

//class OfflineBanner: UIView {
//    init() {
//        super.init(frame: .zero)
//        self.translatesAutoresizingMaskIntoConstraints = false
//        backgroundColor = .darkGray
//        let centerView = UIView()
//        addSubview(centerView)
//        
//        let titleLabel = UILabel()
//        titleLabel.font =  UIFont.boldSystemFont(ofSize: 16.0)
//        titleLabel.text = "No Internet Connection"
//        titleLabel.textColor = .white
//        titleLabel.textAlignment = .center
//        centerView.backgroundColor = .clear
//        centerView.addSubview(titleLabel)
//        
//        centerView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
//        centerView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10).isActive = true
//        centerView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10).isActive = true
//        centerView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10).isActive = true
//        centerView.translatesAutoresizingMaskIntoConstraints = false
//        
//        titleLabel.centerXAnchor.constraint(equalTo: centerView.centerXAnchor).isActive = true
//        titleLabel.centerYAnchor.constraint(equalTo: centerView.centerYAnchor).isActive = true
//        titleLabel.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 6).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: centerView.trailingAnchor, constant: -6).isActive = true
//        titleLabel.translatesAutoresizingMaskIntoConstraints = false
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}

class ConnectionStateBanner: UIView {
    var message: String = ""
    var color: UIColor = .gray
    init(message: String, color: UIColor) {
        super.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = color
        let centerView = UIView()
        addSubview(centerView)
        
        let titleLabel = UILabel()
        titleLabel.font =  UIFont.boldSystemFont(ofSize: 16.0)
        titleLabel.text = message
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        centerView.backgroundColor = .clear
        centerView.addSubview(titleLabel)
        
        centerView.topAnchor.constraint(equalTo: self.topAnchor,constant: 10).isActive = true
        centerView.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10).isActive = true
        centerView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10).isActive = true
        centerView.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -10).isActive = true
        centerView.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.centerXAnchor.constraint(equalTo: centerView.centerXAnchor).isActive = true
        titleLabel.centerYAnchor.constraint(equalTo: centerView.centerYAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: centerView.leadingAnchor, constant: 6).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: centerView.trailingAnchor, constant: -6).isActive = true
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
}
