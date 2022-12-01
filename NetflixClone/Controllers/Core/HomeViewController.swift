//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by alkalemir on 1.12.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Fields

    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    let stackView: UIStackView = {
        let playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setTitle("Play", for: .normal)
        playButton.setImage(UIImage(systemName: "play.fill"), for: .normal)
        playButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)

        playButton.backgroundColor = .white
        playButton.setTitleColor(.black, for: .normal)
        playButton.tintColor = .black
        playButton.layer.cornerRadius = 3
        playButton.imageView?.contentMode = .scaleAspectFit

        playButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        playButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        playButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 33).isActive = true
        
        let infoButton = UIButton()
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.setImage(UIImage(systemName: "info.circle"), for: .normal)
        infoButton.tintColor = .white
        infoButton.heightAnchor.constraint(equalToConstant: 33).isActive = true
        infoButton.widthAnchor.constraint(equalToConstant: 33).isActive = true
        infoButton.imageEdgeInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: 10)
        let myListButton = UIButton()
        myListButton.translatesAutoresizingMaskIntoConstraints = false
        myListButton.tintColor = .white
        myListButton.setTitle("My List", for: .normal)
        myListButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        
        let stackView = UIStackView(arrangedSubviews: [myListButton, playButton, infoButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()

    // MARK: - ViewController Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavBar()
        configureTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    // MARK: - Functions
    
    fileprivate func configureView() {
        view.backgroundColor = .black
        view.addSubview(tableView)
    }
    
    fileprivate func configureTableView() {
        tableView.setContentOffset(CGPoint(x: 0, y: 44 + UIApplication.statusBarHeight()), animated: false)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        let imageView = UIImageView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 450))
        imageView.image = UIImage(named: "heroImage")
        tableView.tableHeaderView = imageView
        tableView.tableHeaderView?.addSubview(stackView)
        
        NSLayoutConstraint.activate([
//            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: tableView.tableHeaderView!.bottomAnchor, constant: -10),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50)
        ])
    }
    
    fileprivate func configureNavBar() {
        
        /// TODO : Set navbar default appearance to transparent and when it scrolls set it to opaque
       
        let logo = UIImage(named: "netflixLogo")?.withRenderingMode(.alwaysOriginal)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: logo, style: .done, target: self, action: nil)
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(image: UIImage(systemName: "person.crop.circle"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "magnifyingglass"), style: .done, target: self, action: nil),
            UIBarButtonItem(image: UIImage(systemName: "airplayvideo"), style: .done, target: self, action: nil)
        ]
        navigationItem.rightBarButtonItems?.forEach({ $0.tintColor = .white })
    }
}

typealias TableViewStuff = UITableViewDataSource & UITableViewDelegate

extension HomeViewController: TableViewStuff {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -44 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                scrollView.setContentOffset(CGPoint(x: 0, y: -44 + UIApplication.statusBarHeight()), animated: true)
            }
        }
    }
}
