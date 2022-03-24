//
//  DetailCocktailViewController.swift
//  CocktailApp
//
//  Created by Andrea Gualandris on 24/03/2022.
//
import UIKit

class DetailCocktailViewController: UIViewController {
    
    let rootURL = "https://www.thecocktaildb.com"
    
    let detailCocktailID = "detailCocktailID"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: detailCocktailID)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    
    var cocktailModel : Cocktail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        self.view.addSubview(tableView)
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    }
    
    func configureDetailControllerWith(cocktailString: String) {
        makeFetchingRequest(with: cocktailString)
    }
    
    private func makeFetchingRequest(with string: String) {
        guard let url = URL(string: "\(rootURL)/api/json/v1/1/search.php?i=\(string)") else { return }

        URLSession.shared.dataTask(with: url) {(data, response, error) in
            guard let data = data, error == nil else { return }
            // we have data
            var result: Cocktail?
            
            do{
                result = try  JSONDecoder().decode(Cocktail.self, from: data)
            }
            catch{
                print("failed to convert \(error.localizedDescription)")
            }
            
            guard let model = result else { return }
            
            self.cocktailModel = model
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }.resume()
    }
}

extension DetailCocktailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = UITableViewCell()
            cell.textLabel?.text = cocktailModel?.ingredients?.first?.strIngredient
            return cell
        case 1:
            let cell = UITableViewCell()
            cell.textLabel?.text = cocktailModel?.ingredients?.first?.strDescription
            cell.textLabel?.numberOfLines = 0
            cell.sizeToFit()
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Drink"
        case 1:
            return "Details"
        default:
            return nil
        }
    }
}
