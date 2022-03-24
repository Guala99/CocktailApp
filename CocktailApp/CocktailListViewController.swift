//
//  ViewController.swift
//  CocktailApp
//
//  Created by Andrea Gualandris on 23/03/2022.
//

import UIKit

class CocktailListViewController: UIViewController {
    
    var cocktailsModel: [String] = [
        "Tequila",
        "Vodka",
        "Gin",
        "Champagne",
        "Wine",
        "Rum",
        "Prosecco",
        "Beer",
        "Whiskey"
    ]
    
    let cocktailID = "cocktailID"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cocktailID)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpUI()
    }
    
    func setUpUI(){
        self.view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
}

extension CocktailListViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cocktailsModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cocktailID)
        cell.textLabel?.text = cocktailsModel[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Choose what you want to drink"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailCocktailViewController()
        detailVC.configureDetailControllerWith(cocktailString: cocktailsModel[indexPath.item])
        self.present(detailVC, animated: true)
        
    }
}
