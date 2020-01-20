//
//  SearchFooterView.swift
//  MusicApp
//
//  Created by Stanly Shiyanovskiy on 18.01.2020.
//  Copyright © 2020 Stanly Shiyanovskiy. All rights reserved.
//

import UIKit

public class SearchFooterView: UIView {
    
    // MARK: - UI elements
    private var footerLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0.631372549, green: 0.6470588235, blue: 0.662745098, alpha: 1)
        return label
    }()
    
    private var loader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView()
        loader.translatesAutoresizingMaskIntoConstraints = false
        loader.hidesWhenStopped = true
        return loader
    }()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupElements()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupElements() {
        addSubview(loader)
        loader.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        loader.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        loader.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20).isActive = true
        
        addSubview(footerLabel)
        footerLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        footerLabel.topAnchor.constraint(equalTo: loader.bottomAnchor, constant: 8).isActive = true
    }
    
    public func showLoader() {
        loader.startAnimating()
        footerLabel.text = "Loading..."
    }
    
    public func hideLoader() {
        loader.stopAnimating()
        footerLabel.text = ""
    }
}
