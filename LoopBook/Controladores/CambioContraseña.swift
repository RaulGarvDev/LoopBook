//
//  CambioContraseña.swift
//  LoopBook
//
//  Created by raul gonzalez de la aleja ruiz valdepeñas on 10/2/22.
//

import UIKit
import Firebase


class CambioContraseña: UIViewController {
    
    // MARK: Outlets

 
    @IBOutlet weak var email_TextField: UITextField!
    @IBOutlet weak var cambiarContraseña_Boton: UIButton!
    
    
    //MARK: Cargar de pantalla
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func cambiarContraseña(_ sender: Any) {
        
        let auth = Auth.auth()
        
        auth.sendPasswordReset(withEmail: email_TextField.text!) { (error) in
           
            if error == nil{
                
                let alert = UIAlertController(title: "Email enviado",
                                              message: "Revisa tu correo",
                                              preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
                
            }else{
                
                let alert = UIAlertController(title: "Error",
                                              message: "Comprueba que el email es correcto",
                                              preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                
                self.present(alert, animated: true)
            }
                
            
        }
    }
    
}

