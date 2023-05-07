//
//  DrawerViewController.swift
//  test
//
//  Created by Sidney Sadel on 5/6/23.
//


import UIKit
import SwiftUI

protocol DrawerViewDelegate:AnyObject {
    func hide()
    func show()
}

class DrawerViewController: UIViewController {

    lazy var drawerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 30
        view.clipsToBounds = true
        return view
    }()
    
    lazy var background: UIView = {
       let view = UIView()
        view.backgroundColor = .black
        view.layer.opacity = 0.15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    weak var delegate: DrawerViewDelegate?
    
    @Binding var isActive: Bool {
        didSet {
            updateDrawerVisibility(isActive)
        }
    }

    init(isActive: Binding<Bool>) {
        self._isActive = isActive
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupDrawerView()
        // updateDrawerVisibility(isActive)
    }

    private func setupDrawerView() {
        view.addSubview(drawerView)
        drawerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            drawerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            drawerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            drawerView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40),
            drawerView.heightAnchor.constraint(equalToConstant: 400)
        ])

        // You can add additional subviews, like buttons or labels, to the drawerView here.
    }
    
    private func updateDrawerVisibility(_ b:Bool) {
        if b {
            delegate?.show()
        } else {
            delegate?.hide()
        }
    }
}
