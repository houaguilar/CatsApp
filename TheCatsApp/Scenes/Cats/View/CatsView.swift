//
//  CatsView.swift
//  TheCatsApp
//
//  Created by Jordy Aguilar on 15/04/23.
//

import UIKit
import SnapKit
import SDWebImage

final class CatsView: UIView {
    private var products: DisplayProducts = []
    let tableView = UITableView()
    func setupUI() {
        self.backgroundColor = .white
        createCatsList()
    }
    func createCatsList() {
        
        tableView.layer.masksToBounds = true
        self.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        let nib = UINib(nibName: "CatsTableViewCell", bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: "CatsTableViewCell")

        tableView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
    }

}

extension CatsView: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = self.products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "CatsTableViewCell") as! CatsTableViewCell
        cell.displayCell(name: product.name, image: product.image, origin: product.origin, intelligence: String(product.intelligence))
        return cell
    }
    
    func displayProducts(products: DisplayProducts) {
        self.products = products
        tableView.reloadData()
    }
}
