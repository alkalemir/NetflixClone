//
//  HomeViewController.swift
//  NetflixClone
//
//  Created by alkalemir on 1.12.2022.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Fields
    let sections = [
        Section(label: "Only On Netflix", height: 200),
        Section(label: "Trending Now", height: 200),
        Section(label: "Top 10 TV Shows in Turkey Today", height: 200),
        Section(label: "TWatch it Again", height: 200),
    ]
    
    let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        return tableView
    }()
    
    let stackView: UIStackView = {
        
        let playButton = ButtonCreator.createButton(title: "Play", tint: .black, textFont: .systemFont(ofSize: 18, weight: .semibold), imageName: "play.fill")
        playButton.configureBorder()
        playButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: -10, bottom: 0, right: 0)
        playButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        playButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        playButton.heightAnchor.constraint(equalToConstant: 33).isActive = true
        playButton.addTarget(nil, action: #selector(playPressed), for: .touchUpInside)
        
        
        let infoButton = ButtonCreator.createButton(title: "", tint: .white, textFont: nil, imageName: "info.circle")
        infoButton.heightAnchor.constraint(equalToConstant: 33).isActive = true
        infoButton.widthAnchor.constraint(equalToConstant: 33).isActive = true
        infoButton.imageEdgeInsets = UIEdgeInsets(top: -10, left: -10, bottom: -10, right: 10)
        
        
        let myListButton = ButtonCreator.createButton(title: "My List", tint: .white, textFont: .systemFont(ofSize: 14, weight: .semibold), imageName: nil)

        
        let stackView = UIStackView(arrangedSubviews: [myListButton, playButton, infoButton])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    @objc func playPressed() {
        print("hello")
    }

    var movies = [Movie]() 
    // MARK: - ViewController Life Cycle Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureNavBar()
        configureTableView()
        
        APICaller.shared.fetchPopulerMovies { movies in
            self.movies = movies
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    // MARK: - Functions
    
    fileprivate func configureGradient() {
        
    }
    
    fileprivate func configureView() {
        view.backgroundColor = .black
        view.addSubview(tableView)
    }
    
    fileprivate func configureTableView() {
        tableView.setContentOffset(CGPoint(x: 0, y: 44 + UIApplication.statusBarHeight()), animated: false)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.showsVerticalScrollIndicator = false
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        let imageView = UIImageView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 450))
        imageView.image = UIImage(named: "heroImage")
        imageView.isUserInteractionEnabled = true
        let uiview = UIView(frame: .init(x: 0, y: 0, width: view.frame.width, height: 450))
        uiview.addSubview(imageView)
        imageView.frame = uiview.bounds
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        layer.frame = uiview.bounds
        uiview.layer.addSublayer(layer)
        tableView.tableHeaderView = uiview
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
    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as! MainTableViewCell
        cell.movies = movies
        
        return cell
    }

    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if scrollView.contentOffset.y < -44 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                scrollView.setContentOffset(CGPoint(x: 0, y: -44 + UIApplication.statusBarHeight()), animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].label
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        CGFloat(sections[indexPath.section].height)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else { return }
        header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
    }
}
