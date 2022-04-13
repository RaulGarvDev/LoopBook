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
import FacebookLogin


class LoginViewController: UIViewController {
    
    // MARK: Outlets
    
    @IBOutlet weak var email_TextField: UITextField!
    @IBOutlet weak var contraseña_TextField: UITextField!
    
    @IBOutlet weak var olvidoContraseña_Boton: UIButton!
    @IBOutlet weak var iniciarSesion_Boton: UIButton!
    @IBOutlet weak var facebook_Boton: UIButton!
    @IBOutlet weak var gmail_Boton: UIButton!
    @IBOutlet weak var registro_Boton: UIButton!
    @IBOutlet weak var stackView1: UIStackView!
    @IBOutlet weak var stackView2: UIStackView!
    @IBOutlet weak var stackView3: UIStackView!
    
    
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
            stackView1.isHidden = true
            stackView2.isHidden = true
            stackView3.isHidden = true
            
            navigationController?.pushViewController(MainViewController(email:email, provider: ProviderType.init(rawValue: provider)!), animated: true)
        }
        
        stackView1.isHidden = false
        stackView2.isHidden = false
        stackView3.isHidden = false
        
      
    
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
       let loginManager = LoginManager()
        loginManager.logOut()
        loginManager.logIn(permissions: [.email], viewController: self) { (result) in
            
            switch result {
                
            case .success(granted: let granted, declined: let declined, token: let token):
                
                let token2 = token?.tokenString
                let credential = FacebookAuthProvider.credential(withAccessToken: token!.tokenString)
              
                Auth.auth().signIn(with:  credential ) { (result, error) in
                    self.navigationController?.pushViewController(MainViewController(email: token2!, provider: .facebook), animated: true)
                }
                      
                
            case .cancelled:
                break
            case .failed(_):
                break
                //popup
            }
        }
    }
    
    
    @IBAction func gmail_Login(_ sender: Any) {
        
        let id = "815236609193-0rl02c98nbard7seaug30n054fvp9ak3.apps.googleusercontent.com"
      
        
        let signInConfig = GIDConfiguration.init(clientID: id)
        
       
            
        GIDSignIn.sharedInstance.signIn(with: signInConfig, presenting: self) { user, error in
            guard error == nil else { return }
            guard let user = user else { return }

            let email: String
            email = user.profile!.email
            
            self.navigationController?.pushViewController(MainViewController(email: email, provider: .gmail), animated: true)
        }
            
            
        
    }

                   
        

        
    
    @IBAction func olvidar_Contraseña(_ sender: Any) {
    }
    
    
    
}


