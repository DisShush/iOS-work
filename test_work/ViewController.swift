//
//  ViewController.swift
//  test_work
//
//  Created by Владислав Шушпанов on 10.08.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var stack: UIStackView!
    var networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        networkManager.downloudJSON() { data in
            self.createInterface(data: data)
        }
    }
    @objc private func buttontap(sender: subclassedUIButton) {
        guard let name = sender.name else { return }
        print(name)
    }
    
    func createInterface(data: JSONData) {
        DispatchQueue.main.async {
            for element in data.view {
                switch element {
                case "hz":
                    let button = subclassedUIButton(frame: CGRect(x: 0, y: 0, width: 50, height: 100))
                    button.name = "hz"
                    button.addTarget(self, action: #selector(self.buttontap), for: .touchUpInside)
                    for view in data.data {
                        if view.name == "hz" {
                            button.setTitle(view.data.text, for: .normal)
                        }
                    }
                    button.backgroundColor = #colorLiteral(red: 0.2198731899, green: 0.482974112, blue: 1, alpha: 1)
                    self.stack.addArrangedSubview(button)
                    
                case "selector":
                    self.stack.addArrangedSubview(self.tableView)
                    for view in data.data {
                        if view.name == "selector" {
                            guard let variants = view.data.variants else { return }
                            for index in 0..<variants.count {
                                guard let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) else { return }
                                guard let textLabel = cell.textLabel, let variants = view.data.variants else { return }
                                textLabel.text = variants[index].text
                            }
                        }
                    }
            
                case "picture":
                    let button = subclassedUIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 200))
                    button.name = "picture"
                    button.addTarget(self, action: #selector(self.buttontap), for: .touchUpInside)
                    self.stack.addArrangedSubview(button)
                    for view in data.data {
                        if view.name == "picture" {
                            guard let urlString = view.data.url else { return }
                            self.networkManager.downloudImage(urlString: urlString) { picture in
                                DispatchQueue.main.async {
                                button.setBackgroundImage(picture, for: .normal)
                                button.setTitle("", for: .normal)
                                }
                            }
                        }
                    }
                    
                default:
                    return
                }
            }
        }
    }
}

class subclassedUIButton: UIButton {
    var name: String?
}


