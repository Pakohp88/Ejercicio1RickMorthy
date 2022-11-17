//
//  DetailViewController.swift
//  BackgroundContent
//
//  Created by Francisco Hernandez on 17/11/22.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    var urlImage : String?

    override func viewDidLoad() {
        super.viewDidLoad()        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuracion = URLSessionConfiguration.default
        let sesion = URLSession(configuration: configuracion)
        guard let laURL = URL(string: urlImage!)
        else { return }
        
        let request = URLRequest(url: laURL)
        let tarea = sesion.dataTask(with:request) { datos, response, error in
            if  nil != error {
                print ("Error \(String(describing: error?.localizedDescription))")
                return
            }
            guard let bytes = datos else {
                print ("URL sin datos")
                return
            }
            // para cualquier cambio que se haga en UI debe ser en el thread principal
            DispatchQueue.main.async {
                /*let imageview = UIImageView(frame: self.view.frame)
                imageview.autoresizingMask = [.flexibleWidth, .flexibleHeight]*/
                self.imageView.image = UIImage(data:bytes)
                self.view.addSubview(self.imageView)
            }
        }
        tarea.resume()
    }
    
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
