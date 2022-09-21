//
//  View.swift
//  CryptoViper
//
//  Created by Berkay Kuzu on 19.09.2022.
//

import Foundation
import UIKit

//Talks to -> presenter
//Class, protocol
//ViewController 

protocol AnyView {
    
    var presenter : AnyPresenter? {get set}
    
    func update(with cryptos: [Crypto]) // Aynı ismi kullanıyoruz, içerisindeki parametre değişiyor.
    func update(with error: String) // Aynı ismi kullanıyoruz, içerisindeki parametre değişiyor.
}

class CryptoViewController: UIViewController, AnyView, UITableViewDelegate, UITableViewDataSource {
    
    var presenter: AnyPresenter?
    var cryptos : [Crypto] = []
    
    private let tableView : UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }() // Burada tableView oluşturduk
    
    private let messagelabel : UILabel = {
        let label = UILabel()
        label.isHidden = false
        label.text = "Downloading..."
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .yellow
        view.addSubview(tableView) // Oluşturduğumuz görünümleri bu şekilde ekliyoruz.
        view.addSubview(messagelabel) // messageLabel'ı sınıf içerisinde oluşturdum ve buraya yazdım.
        
        tableView.delegate = self
        tableView.dataSource = self
    } // Burada tekrar viewDidLoad() func oluşturduk
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        tableView.frame = view.bounds // tableView ekranın boyutu kadar
        messagelabel.frame = CGRect(x: view.frame.width / 2 - 100, y: view.frame.height / 2 - 25, width: 200, height: 50)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cryptos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = cryptos[indexPath.row].currency
        content.secondaryText = cryptos[indexPath.row].price
        cell.contentConfiguration = content
        cell.backgroundColor = .yellow
        return cell
    }
    
    
    func update(with cryptos: [Crypto]) {
        DispatchQueue.main.async {
            self.cryptos = cryptos
            self.messagelabel.isHidden = true
            self.tableView.reloadData()
            self.tableView.isHidden = false // artık veriler gösterilecek!
        }
    }
    
    func update(with error: String) {
        DispatchQueue.main.async {
            self.cryptos = []
            self.tableView.isHidden = true
            self.messagelabel.text = error
            self.messagelabel.isHidden = false
        }
    }
    // Önce UIViewController sonra AnyView yazılır!
    
}

