//
//  SelectItemListViewController.swift
//  DropdownUsingPopover
//
//  Created by Maochun Sun on 2020/7/2.
//  Copyright © 2020 Maochun. All rights reserved.
//

import UIKit

class SelectItemListViewController: UIViewController{
    
    var backgroundColor = UIColor.gray
    var selItemText : String = ""
    var theItemArray = [String]()
    
    lazy var theTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x:0, y:0, width: 0, height: 0), style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        //tableView.estimatedRowHeight = 70
        tableView.rowHeight = 50
        tableView.allowsSelection = true
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .gray
        tableView.isScrollEnabled = true
        tableView.backgroundColor = .white
        
        tableView.layer.cornerRadius = 12
        
        self.view.addSubview(tableView)
        

        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 14),
            tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 1),
            tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -1),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -1)
        
        ])
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "DropdownListItemCell")
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = backgroundColor
        
       
        self.theTableView.reloadData()
    }
    
}


extension SelectItemListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.theItemArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropdownListItemCell", for:indexPath)
        cell.selectionStyle = .default
        cell.textLabel?.text = self.theItemArray[indexPath.row]
        
        return cell
        
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        tableView.cellForRow(at: indexPath)?.accessoryView = UIImageView(image: UIImage(named: "list_icon_check"))
        
        
        self.selItemText = self.theItemArray[indexPath.row]

        
        self.dismiss(animated: true, completion: nil)
        self.popoverPresentationController?.delegate?.popoverPresentationControllerDidDismissPopover?(popoverPresentationController!)
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 50
    }
}
