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
        v.layer.cornerCurve = .continuous
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override func viewDidLoad() {
        setupViews()
        setupGestures()
    }
    
    private func setupViews() {
        view.addSubview(background)
        view.addSubview(drawerView)
        
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
    
    private func setupGestures() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        drawerView.addGestureRecognizer(panGesture)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapToDismiss(_:)))
        background.addGestureRecognizer(tapGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let minY = view.bounds.height - drawerView.bounds.height - 40
        
        if gesture.state == .changed {
            let newY = min(max(drawerView.frame.origin.y + translation.y, minY), view.bounds.height - 40)
            drawerView.frame.origin.y = newY
            gesture.setTranslation(.zero, in: view)

            let progress = (view.bounds.height - newY) / (view.bounds.height - minY)
            background.alpha = 0.2 * progress
        } else if gesture.state == .ended {
            let velocity = gesture.velocity(in: view).y
            let dismissThreshold: CGFloat = view.bounds.height - drawerView.bounds.height / 4

            // Use a threshold for the velocity and check if the drawer view is 1/4 down to determine if the drawer should be dismissed or reset
            if velocity > 500 || drawerView.frame.origin.y > dismissThreshold {
                dismissDrawer()
            } else {
                resetDrawer()
            }
        }
    }

    @objc func handleTapToDismiss(_ gesture: UITapGestureRecognizer) {
        dismissDrawer()
    }
    
    func dismissDrawer() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseOut], animations: {
            self.drawerView.frame.origin.y = self.view.bounds.height
            self.background.alpha = 0
        }) { _ in
            // Perform any additional actions after the dismissal animation is completed
        }
    }
    
    func resetDrawer() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: [.curveEaseOut], animations: {
            self.drawerView.frame.origin.y = self.view.bounds.height - self.drawerView.bounds.height - 40
            self.background.alpha = 0.2
        }) { _ in
            // Perform any additional actions after the reset animation is completed
        }
    }
}
