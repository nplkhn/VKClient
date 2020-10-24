//
//  ProfileViewController.swift
//  VKClient
//
//  Created by Никита Плахин on 10/22/20.
//

import UIKit


class ProfileViewController: UIViewController {
    
    // View elements
    private var profileImageView = UIImageView()
    private var nameLabel = UILabel()
    private var statusLabel = UILabel()
    private var birthdayLabel = UILabel()
    private var logoutButton:UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.setTitleColor(.red, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 25, weight: .medium)
        button.sizeToFit()
        return button
    }()
    private var buttonContainer = UIView()
    private var topElementsContainer: UIStackView!
    private var nameAndStatusContainer: UIStackView!
    private var containerStackView: UIStackView!
    
    // Model
    private var user: UserWrapper.User? {
        didSet {
            nameLabel.text = user?.name
            statusLabel.text = user?.status
            
            if let birthday = user?.bdate {
                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.yyyy"
                let date = formatter.date(from: birthday)
                if let date = date {
                    birthdayLabel.text = "Birth Day: " + formatter.string(from: date)
                }
            }
            
            if let location = user?.location {
                let infoBlock = InfoBlockStackView(with: "Location", title: location)
                containerStackView.insertArrangedSubview(infoBlock, at: containerStackView.arrangedSubviews.count - 1)
            }
            
            if let education = user?.education {
                let infoBlock = InfoBlockStackView(with: "Education", title: education)
                containerStackView.insertArrangedSubview(infoBlock, at: containerStackView.arrangedSubviews.count - 1)
            }
            
            networkService.getImage(from: user?.photo100) { image in
                self.profileImageView.image = image
            }
        }
    }
    
    // Services
    private let authService = AuthService()
    private let networkService = NetworkService()
    private var networkDataFetcher: NetworkDataFetcher!

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        networkDataFetcher = NetworkDataFetcher(networking: networkService, authService: authService)
        
        networkDataFetcher.getUser { user in
            self.user = user
        }

        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        parent?.navigationItem.title = "Profile"
    }
    
    private func setupViews() {
        
        // Root view
        view.backgroundColor = .white
        
        // Logout button
        logoutButton.addTarget(self, action: #selector(self.logout), for: .touchUpInside)
        
        // Name label
        nameLabel.font = UIFont.systemFont(ofSize: 30, weight: .medium)
        
        // Status label
        statusLabel.font = UIFont.systemFont(ofSize: 20)
        
        // Profile image view
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        
        // Name and status container stack view
        nameAndStatusContainer = UIStackView(arrangedSubviews: [nameLabel, statusLabel])
        nameAndStatusContainer.axis = .vertical
        nameAndStatusContainer.spacing = 5
        nameAndStatusContainer.alignment = .leading
        
        // Top elemets container stack view
        topElementsContainer = UIStackView(arrangedSubviews: [profileImageView, nameAndStatusContainer])
        topElementsContainer.axis = .horizontal
        topElementsContainer.spacing = 30
        topElementsContainer.alignment = .center
        
        // Container stack view
        containerStackView = UIStackView(arrangedSubviews: [topElementsContainer, birthdayLabel, buttonContainer])
        containerStackView.axis = .vertical
        containerStackView.alignment = .leading
        containerStackView.distribution = .equalSpacing
        containerStackView.spacing = 15
        
        //
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        containerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        buttonContainer.addSubview(logoutButton)
        view.addSubview(containerStackView)
        
        NSLayoutConstraint.activate([
            // stack view
            NSLayoutConstraint(item: containerStackView, attribute: .leading, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .leading, multiplier: 1, constant: 10),
            NSLayoutConstraint(item: containerStackView, attribute: .top, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .top, multiplier: 1, constant: 25),
            NSLayoutConstraint(item: containerStackView, attribute: .trailing, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .trailing, multiplier: 1, constant: -10),

            
            NSLayoutConstraint(item: buttonContainer, attribute: .centerX, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .centerX, multiplier: 1, constant: 0),
            
            NSLayoutConstraint(item: logoutButton, attribute: .leading, relatedBy: .equal, toItem: buttonContainer, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: logoutButton, attribute: .top, relatedBy: .equal, toItem: buttonContainer, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: logoutButton, attribute: .trailing, relatedBy: .equal, toItem: buttonContainer, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint(item: logoutButton, attribute: .bottom, relatedBy: .equal, toItem: buttonContainer, attribute: .bottom, multiplier: 1, constant: 0),
        ])
    }
    
    // MARK: - handlers
    @objc func logout() {
        authService.logOut()
        UIApplication.shared.keyWindow?.rootViewController = LoginViewController()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
