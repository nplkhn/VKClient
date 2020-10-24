//
//  AuthService.swift
//  VKClient
//
//  Created by Никита Плахин on 10/24/20.
//

import Foundation
import VK_ios_sdk

protocol AuthServiceDelegate: class {
    func authServiceShouldShow(_ viewController: UIViewController)
    func authServiceSignIn()
    func authServiceDidSignInFail()
}

class AuthService: NSObject, VKSdkDelegate, VKSdkUIDelegate {
    
    private let appId = "7636163"
    private let scope: [String] = ["friends", "wall"]
    let vkSDK: VKSdk
    
    weak var delegate: AuthServiceDelegate? = UIApplication.shared.delegate as! AppDelegate
    
    var token: String? {
        VKSdk.accessToken()?.accessToken
    }
    
    override init() {
        vkSDK = VKSdk.initialize(withAppId: appId)
        super.init()
        vkSDK.register(self)
        vkSDK.uiDelegate = self
    }
    
    func wakeUpSession() {
        VKSdk.wakeUpSession(scope) { [delegate] (state, error) in
            if state == VKAuthorizationState.authorized {
                print("VKAuthorizationState.authorized")
                delegate?.authServiceSignIn()
            } else if state == VKAuthorizationState.initialized {
                print("VKAuthorizationState.initialized")
                delegate?.authServiceDidSignInFail()
                VKSdk.authorize(self.scope)
            } else {
                print("auth problems, state \(state) error \(String(describing: error))")
                delegate?.authServiceDidSignInFail()
            }
        }
    }
    
    func logIn() {
        VKSdk.authorize(self.scope)
    }
    
    func logOut() {
        VKSdk.forceLogout()
    }
    
    // MARK: - VKSDK delegate
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        print(#function)
        if result.token != nil {
            delegate?.authServiceSignIn()
        }
    }

    func vkSdkUserAuthorizationFailed() {
        print(#function)
    }
    
    // MARK: - VKSDK UI delegate
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        print(#function)
        delegate?.authServiceShouldShow(controller)
        
    }

    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {
        print(#function)
    }
}
