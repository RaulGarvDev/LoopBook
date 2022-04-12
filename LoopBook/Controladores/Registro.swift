//
//  Registro.swift
//  LoopBook
//
//  Created by raul gonzalez de la aleja ruiz valdepeñas on 10/2/22.
//

import UIKit
import FirebaseAuth



class Registro: UIViewController {
    

    
    //MARK: Outlets registro
    
    @IBOutlet weak var nombreUsuario_TextField: UITextField!
    @IBOutlet weak var email_TextField: UITextField!
    @IBOutlet weak var contraseña_TextField: UITextField!
    @IBOutlet weak var repiteContraseña_TextField: UITextField!
    
    @IBOutlet weak var camara_Boton: UIButton!
    @IBOutlet weak var galeria_Boton: UIButton!
    @IBOutlet weak var crearCuenta_Boton: UIButton!
    
    
        
        private var email: String = ""
        private var password: String = ""
        private var nombreUsuario: String = ""
        private var repitePassword: String = ""
        
    
  
        

    
    //MARK: Cargar de pantalla
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    
    }

    //MARK: Actions
    @IBAction func registrarUsuarioFirebase(_ sender: Any) {
        
      
            email = email_TextField.text!
            password = contraseña_TextField.text!
            repitePassword = repiteContraseña_TextField.text!
            nombreUsuario = nombreUsuario_TextField.text!
            
        
        
        if (password == repitePassword){
            Auth.auth().createUser(withEmail: email, password: password) {
                (authResult, error ) in
                       
   
                if let authResult = authResult, error == nil {
                
                    self.navigationController?.pushViewController(MainViewController(email: authResult.user.email!, provider: .basic), animated: true)
                    
                  /*  self.email_TextField.text = ""
                    self.contraseña_TextField.text = ""
                    self.repiteContraseña_TextField.text = ""
                    self.nombreUsuario_TextField.text = ""
                    
                    let alertController = UIAlertController(title:"Registrado", message: "Has sido registrad@ correctamente", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)*/
                    
                }else{
                    let alertController = UIAlertController(title:"Error", message: "Se ha producido un error registrando al usuari@", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }else{
            let alertController = UIAlertController(title:"ErrorContraseña", message: "La contraseña debe ser la misma", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
            
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

