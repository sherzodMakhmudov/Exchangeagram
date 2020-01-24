//
//  CreatePostViewController.swift
//  Aincrad
//
//  Created by Sherzod Makhmudov on 1/2/20.
//  Copyright © 2020 com.SherzodMakhmudov. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController{
    let imageView: UIImageView = {
        let image = UIImage(named: "")
        let view = UIImageView(image: image)
        view.contentMode = .scaleAspectFill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(imageView)
        setupLayouts()
    }
    
    func setupLayouts(){
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
    }
}
