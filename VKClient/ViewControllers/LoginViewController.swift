//
//  LoginViewController.swift
//  VKClient
//
//  Created by Никита Плахин on 10/21/20.
//

import UIKit
import VK_ios_sdk

class LoginViewController: UIViewController, VKSdkUIDelegate {
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        
    }
    
    
    let authtorizationButton = UIButton(frame: .zero)
    private let authService = AuthService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = UIColor(named: "vkBlue")
        
        authtorizationButton.setTitle("Login via VK", for: .normal)
        authtorizationButton.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        authtorizationButton.setTitleColor(.white, for: .normal)
        authtorizationButton.sizeToFit()
        
        view.addSubview(authtorizationButton)
        
        authtorizationButton.translatesAutoresizingMaskIntoConstraints = false
        
        authtorizationButton.addTarget(self, action: #selector(self.login), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            NSLayoutConstraint(item: authtorizationButton, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: authtorizationButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0),
        ])
    }
    
    @objc func login() {
        print("try to login")
        authService.wakeUpSession()
    }
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
            if (self.presentedViewController != nil) {
                self.dismiss(animated: true, completion: {
                    print("hide current modal controller if presents")
                    self.present(controller, animated: true, completion: {
                        print("SFSafariViewController opened to login through a browser")
                    })
                })
            } else {
                self.present(controller, animated: true, completion: {
                    print("SFSafariViewController opened to login through a browser")
                })
            }
        }
}

