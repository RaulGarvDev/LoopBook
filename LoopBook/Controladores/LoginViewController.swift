//
//  ViewController.swift
//  LoopBook
//
//  Created by raul gonzalez de la aleja ruiz valdepeñas on 26/4/21.
//

import UIKit
import FirebaseAuth
import FirebaseAnalytics
import GoogleSignIn

class LoginViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var email_TextField: UITextField!
    @IBOutlet weak var contraseña_TextField: UITextField!
    
    @IBOutlet weak var olvidoContraseña_Boton: UIButton!
    @IBOutlet weak var iniciarSesion_Boton: UIButton!
    @IBOutlet weak var facebook_Boton: UIButton!
    @IBOutlet weak var gmail_Boton: UIButton!
    @IBOutlet weak var registro_Boton: UIButton!
    
    
    private var email: String = ""
    private var password: String = ""
    
    
    
    
    
    
    
    //MARK: Cargar de pantalla
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //Comprobar la sesión del usuario autentificado
        let defaults = UserDefaults.standard
        if let email = defaults.value(forKey: "email") as? String , let provider = defaults.value(forKey: "provider") as? String{
            
            //Aquí deberiamos implementar y esconder el stackview con todos los elementos
            
            navigationController?.pushViewController(MainViewController(email:email, provider: ProviderType.init(rawValue: provider)!), animated: true)
        }
        
       
        
      
        
    }
    
    @IBAction func iniciar_sesion(_ sender: Any) {
        
        if let email = email_TextField.text, let password = contraseña_TextField.text {
            
            Auth.auth().signIn(withEmail: email, password: password) {
                (authResult, error ) in
                
                
                if let authResult = authResult, error == nil {
                    
                    self.navigationController?.pushViewController(MainViewController(email: authResult.user.email!, provider: .basic), animated: true)
                    
                    
                }else{
                    let alertController = UIAlertController(title:"Error", message: "Email o contraseña incorrectos", preferredStyle: .alert)
                    
                    alertController.addAction(UIAlertAction(title: "Aceptar", style: .default))
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    
    
    
    @IBAction func facebook_Login(_ sender: Any) {
    }
    @IBAction func gmail_Login(_ sender: Any) {
        let id = "815236609193-0rl02c98nbard7seaug30n054fvp9ak3.apps.googleusercontent.com"
             
        let signInConfig = GIDConfiguration.init(clientID: id)
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
           guard error == nil else { return }

           // If sign in succeeded, display the app's main content View.
            // Falta por hacer
           
         }

        
    }
    @IBAction func olvidar_Contraseña(_ sender: Any) {
    }
    
    
}


