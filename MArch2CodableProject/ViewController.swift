//
//  ViewController.swift
//  MArch2CodableProject
//
//  Created by Consultant on 3/2/22.
//

import UIKit

class ViewController: UIViewController {
    var heroes = [Hero]()
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        setupTableView()

        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func setupTableView() {
        fetchJson { [unowned self] in
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
   
    
    func fetchJson(completed: @escaping () ->()) {
        guard let url = URL(string: "https://api.opendota.com/api/heroStats") else {return}
        let session = URLSession.shared
        
        let task = session.dataTask(with:url){data,response, error in
            
            guard error == nil else{
                print("Error: \(error?.localizedDescription ?? "something strange happended")")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("server error")
                return
            }
            
            guard data != nil else {
                print("error we have not data bub")
                return
            }
            
            do {
                self.heroes = try JSONDecoder().decode([Hero].self, from: data!)
                DispatchQueue.main.async {
                    completed()
                }
                
            } catch {
                print("Error: \(error.localizedDescription)")
            }

        }
        task.resume()
    }

}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
        cell.textLabel?.text = heroes[indexPath.row].name.capitalized
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.hero = heroes[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}
