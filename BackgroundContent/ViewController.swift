//
//  ViewController.swift
//  BackgroundContent
//
//  Created by Ángel González on 29/10/22.
//

import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuracion = URLSessionConfiguration.default
        let sesion = URLSession(configuration: configuracion)
        guard let laURL = URL(string:"https://www.nasa.gov/sites/default/files/thumbnails/image/halloween_sun_2014.jpeg")
        else { return }
        
        let request = URLRequest(url: laURL)
        let tarea = sesion.dataTask(with:request) { datos, response, error in
            if  nil != error {
                print ("algo salió mal \(String(describing: error?.localizedDescription))")
                return
            }
            guard let bytes = datos else {
                print ("el response no trajo datos")
                return
            }
            // para cualquier cambio que se haga en UI debe ser en el thread principal
            DispatchQueue.main.async {
                let imageview = UIImageView(frame: self.view.frame)
                imageview.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                imageview.image = UIImage(data:bytes)
                self.view.addSubview(imageview)
            }
        }
        tarea.resume()
    }
}

    
