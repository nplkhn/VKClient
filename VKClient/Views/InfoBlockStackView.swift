//
//  InfoBlockStackView.swift
//  VKClient
//
//  Created by Никита Плахин on 10/24/20.
//

import UIKit

class InfoBlockStackView: UIStackView {
    
    private let blockTitleLabel: UILabel
    private let titleLabel: UILabel
    private let subtitleLabel: UILabel
    
    init() {
        blockTitleLabel = UILabel()
        titleLabel = UILabel()
        subtitleLabel = UILabel()
        super.init(frame: .zero)
        
        setupViews()
    }
    
    convenience init(with blockTitle: String, title: String = "", subtitle: String = "") {
        self.init()
        blockTitleLabel.text = blockTitle
        titleLabel.text = title
        subtitleLabel.text = subtitle
        
        setupViews()
    }
    
    func setupViews() {
        // Block title label
        blockTitleLabel.frame.size.width = self.frame.size.width
        blockTitleLabel.textAlignment = .natural
        blockTitleLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)

        
        // Title label
        titleLabel.textAlignment = .natural
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .light)
        titleLabel.sizeToFit()
        
        // Subtitle label
        subtitleLabel.textAlignment = .natural
        subtitleLabel.font = UIFont.systemFont(ofSize: 15, weight: .light)
        subtitleLabel.sizeToFit()
        
        setCustomSpacing(5, after: blockTitleLabel)
        axis = .vertical
        alignment = .leading
        distribution = .fill
        
        addArrangedSubview(blockTitleLabel)
        addArrangedSubview(titleLabel)
        addArrangedSubview(subtitleLabel)
        
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */


}
