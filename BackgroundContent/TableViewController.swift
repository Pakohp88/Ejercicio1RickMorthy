//
//  TableViewController.swift
//  BackgroundContent
//
//  Created by Ángel González on 29/10/22.
//

import UIKit

class TableViewController: UITableViewController {
    var personajes = [Result]()
    var selectedCharacterUrlImage: String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let ad = UIApplication.shared.delegate as! AppDelegate
        if ad.internetStatus {
            if let url=URL(string: "https://rickandmortyapi.com/api/character/") {
                do {
                    let bytes = try Data(contentsOf: url)
                    let rick = try JSONDecoder().decode(Rick.self, from: bytes)
                    personajes = rick.results
                }
                catch {
                }
            }
        }
        else{
            let ac = UIAlertController(title:"Error", message:"No hay conexión a Internet", preferredStyle: .alert)
                        let action = UIAlertAction(title: "Enterado", style: .default)
                        ac.addAction(action)
                        self.present(ac, animated: true)
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personajes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "personCell", for: indexPath)
        let personaje = personajes[indexPath.row]
        cell.textLabel?.text = personaje.name
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCharacterUrlImage = personajes[indexPath.row].image
        self.performSegue(withIdentifier: "rickMorthySeague", sender: self.self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! DetailViewController
        destination.urlImage = selectedCharacterUrlImage
    }
        
}
