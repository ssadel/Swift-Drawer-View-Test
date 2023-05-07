//
//  DrawerViewController.swift
//  test
//
//  Created by Sidney Sadel on 5/6/23.
//

import UIKit

class DrawerViewController: UIViewController {
    
    var isActive:Bool
    
    init(isActive:Bool) {
        self.isActive = isActive
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var background: UIView = {
        let v = UIView()
        v.backgroundColor = .black
        v.alpha = 0.2
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    lazy var drawerView: UIView = {
        let v = UIView()
        v.backgroundColor = .white
        v.layer.cornerRadius = 30
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        setupViews()
    }
    
    private func setupViews() {
        view.addSubview(background)
        background.addSubview(drawerView)
        
        NSLayoutConstraint.activate([
            background.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            background.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            background.topAnchor.constraint(equalTo: view.topAnchor),
            background.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            drawerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            drawerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            drawerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            drawerView.heightAnchor.constraint(equalToConstant: 400)
        ])
    }
    
}
