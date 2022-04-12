//
//  MainViewController2.swift
//  LoopBook
//
//  Created by raul gonzalez de la aleja ruiz valdepeñas on 19/2/22.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

enum ProviderType: String {
    case basic
    case gmail
}

class MainViewController: UIViewController {
    
    @IBOutlet weak var email_TextField: UILabel!
    @IBOutlet weak var cerrarSesion_Button: UIButton!
    @IBOutlet weak var providerLabel: UILabel!
    
    private let email: String
    private let provider: ProviderType
    
    
    //Constructores
    
    
    
    // init
    init(email: String, provider: ProviderType){
        self.email = email
        self.provider = provider
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Comienza la carga de pantalla
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        title = "Inicio"
        
        navigationItem.setHidesBackButton(true, animated: false)
        
        
        email_TextField.text = email
        providerLabel.text = provider.rawValue
        
        //Guardamos los datos del usuario
        let defaults = UserDefaults.standard
        defaults.set(email, forKey: "email")
        defaults.set(provider.rawValue, forKey: "provider")
        defaults.synchronize()
        
        print ("Esto es lo que tiene email: ",email)

        
        
    }
    
    @IBAction func cerrarSesion(_ sender: Any) {
        
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "email")
        defaults.removeObject(forKey: "provider")
        defaults.synchronize()
        
        
        switch provider {
        case .basic, .gmail:
            do {
                try Auth.auth().signOut()
                navigationController?.popViewController(animated: true)
            }catch{
                //Se ha producido un error
            }
        }
        
        GIDSignIn.sharedInstance.signOut()

    }
    
    
    
    
}//Fin MainViewController
