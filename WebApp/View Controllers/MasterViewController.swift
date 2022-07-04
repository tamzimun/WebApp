//
//  ViewController.swift
//  WebApp
//
//  Created by Aida Moldaly on 01.07.2022.
//

import UIKit

class MasterViewController: UIViewController {

    @IBOutlet var tableView: UITableView!
    
    private var listWebsites: [Website] = [
        Website(title: "Apple", siteUrl: "https://www.apple.com"),
        Website(title: "Youtube", siteUrl: "https://www.youtube.com")
    ]
    
    private var favWebsites: [Website] = [
        Website(title: "Instagram", siteUrl: "https://www.instagram.com")
    ]
    
    lazy var websites = listWebsites
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        
        let alert = UIAlertController(title: "Add website", message: "Fill all the fields", preferredStyle: .alert)
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = "Enter title"
        }
        alert.addTextField { (textField:UITextField) in
            textField.placeholder = "Enter url"
        }
        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [self] (action:UIAlertAction) in
            guard let textField =  alert.textFields?.first, ((alert.textFields?.first?.hasText) != nil) else {
                return
            }
            guard let textField2 =  alert.textFields?[1], ((alert.textFields?[1].hasText) != nil) else {
                return
            }
            let web = Website(title: textField.text!, siteUrl: textField2.text!)
            websites.append(web)
            tableView.reloadData()
            print("my massive is \(websites)")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func segmantedControl(_ sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex
        
        switch index {
        case 0:
            websites = listWebsites
        case 1:
            websites = favWebsites
        default:
            break
        }
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension MasterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return websites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "websiteCell") as! WebsiteCell
        cell.configure(with: websites[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller = DetailViewController.makeDetailViewController(title: websites[indexPath.row].title, urlString: websites[indexPath.row].siteUrl)
        controller.addFavDelegate = self
        splitViewController?.showDetailViewController(controller, sender: self)
        
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete
        {
            websites.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
}

extension MasterViewController: AddFavWebsiteDelegate {
    func addFavWeb(favWebsite: Website) {
        self.dismiss(animated: true) {
            self.favWebsites.append(favWebsite)
            self.tableView.reloadData()
        }
    }
}

