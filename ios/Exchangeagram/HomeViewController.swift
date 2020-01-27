//
//  HomeViewController.swift
//  Aincrad
//
//  Created by Sherzod Makhmudov on 12/22/19.
//  Copyright © 2019 com.SherzodMakhmudov. All rights reserved.
//

import Alamofire
import SDWebImage

struct Post: Decodable{
    let id: String
    let createdAt: Int
    let text:String
    let user: User
    let imageUrl: String
}

struct User:Decodable{
    let fullName:String
    let id:String
}

class HomeViewController: UITableViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showCookies()

        navigationItem.rightBarButtonItems = [.init(title: "My posts", style: .plain, target: self, action: #selector(fetchPosts)),
                                              .init(title: "Create post", style: .plain, target: self, action: #selector(createPost))]
        navigationItem.leftBarButtonItem = .init(title: "Log In", style: .plain, target: self, action: #selector(handleLogin))
    }
    
    fileprivate func showCookies() {
        HTTPCookieStorage.shared.cookies?.forEach({ (cookie) in
            print(cookie)
        })
    }
    
    @objc fileprivate func handleLogin() {
        print("Show login and sign up pages")
        let navController = UINavigationController(rootViewController: LoginViewController())
        present(navController, animated: true)
    }
    
    var posts = [Post]()
    @objc func fetchPosts() {
        //Tutorial 10 shows how to connect ios to a server
        
        guard let url = URL(string: "http://localhost:1337/home") else { return }
        
        Alamofire.request(url).validate(statusCode: 200..<300).responseData { (dataResponse) in
            if let error = dataResponse.error{
                print("Failed to fetch posts:", error)
                return
            }
            guard let data = dataResponse.data else {return}
            DispatchQueue.main.async {
                do{
                    let post = try JSONDecoder().decode([Post].self, from: data)
                    self.posts = post
                    self.tableView.reloadData()
                }catch{
                    print(error)
                }
            }
        }
    }
    
    @objc func createPost(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {return}
        dismiss(animated: true) {
            
            let createPostViewController = CreatePostViewController(selectedImage: image)
            createPostViewController.homeViewController = self
            self.present(createPostViewController, animated: true, completion: nil)

    }
}
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = PostCell(style: .subtitle, reuseIdentifier: cellId)
        let post = posts[indexPath.row]
        cell.usernameLabel.text = post.user.fullName
        cell.postTextLabel.text = post.text
        cell.postImageView.sd_setImage(with: URL(string:post.imageUrl))
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }

}
