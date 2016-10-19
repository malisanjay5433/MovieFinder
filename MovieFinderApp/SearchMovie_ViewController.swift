//
//  ViewController.swift
//  MovieFinderApp
//
//  Created by Sanjay Mali on 19/10/16.
//  Copyright © 2016 Sanjay. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import KRProgressHUD
class SearchMovie_ViewController: UIViewController,UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "background")!)
        self.view.addSubview(searchBar)
        self.view.addSubview(container)
        self.searchBar.delegate = self
        constraint()
        
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func makeRequestPost(searchText:String){
        self.startLoading()
        let encodingText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let api = "http://omdbapi.com/?t=" + encodingText!
        Alamofire.request(api,method:.get)
            .responseJSON { response in
                //print(response.result)   // result of response serialization
                guard response.result.error == nil else {
                    print(response.result.error!)
                    return
                }
                
                if let json = response.data{
                    let json_Data = JSON(data:json)
                    let response = json_Data["Response"].string!
                  
                if response == "True"{
                    self.title_Label.text = "Title: " + json_Data["Title"].string!
                    self.genre_Label.text = "Genre: " + json_Data["Genre"].string!
                    self.releaseDate_Label.text = "Release Date:    " + json_Data["Released"].string!
                    self.rating_Label.text = "Rating:   " + json_Data["Rated"].string!
                    self.plot_Label.text = "Plot:   " + json_Data["Plot"].string!
                    self.endLoading()
                }else {
                    
                    self.endLoading()
                    let error = json_Data["Error"].string!
                    let alertController = UIAlertController(title: "", message: error, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
                    })
                   
                    alertController.addAction(ok)
                    self.present(alertController, animated: true, completion: nil)
                    }
                }
     
        }
        
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
         makeRequestPost(searchText: textField.text!)
    }
    
    
    let searchBar:UITextField = {
        let sb = UITextField()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.layer.borderWidth = 2.0
        sb.layer.borderColor = UIColor.white.cgColor
        sb.placeholder = "Search here any Movie"
//        sb.layer.cornerRadius = 3.0
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.layer.shadowColor = UIColor.white.cgColor
        sb.layer.shadowOffset = CGSize(width:3.0, height:2.0)
        sb.layer.shadowOpacity = 1.0
        sb.layer.shadowRadius = 3.0
        sb.layer.masksToBounds = false
        sb.textAlignment = .center
        sb.textColor = UIColor.white
        return sb
        
    }()
    
    let container:UIView = {
        let sb = UIView()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.backgroundColor = UIColor.clear
        return sb
        
    }()

    let title_Label:UILabel = {
        let sb = UILabel()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.textAlignment = .left
        sb.textColor = UIColor.white
//        sb.text = "Title:"
        sb.font = UIFont.systemFont(ofSize: 18)
        return sb
        
    }()
    let genre_Label:UILabel = {
        let sb = UILabel()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.textAlignment = .left
        sb.textColor = UIColor.white
//        sb.text = "Genre:"
        sb.font = UIFont.systemFont(ofSize: 18)
        return sb
        
    }()
    let releaseDate_Label:UILabel = {
        let sb = UILabel()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.textAlignment = .left
        sb.textColor = UIColor.white
//        sb.text = "Release Date:"
        sb.font = UIFont.systemFont(ofSize: 18)
        return sb
        
    }()
    let rating_Label:UILabel = {
        let sb = UILabel()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.textAlignment = .left
        sb.textColor = UIColor.white
//        sb.text = "Rating:"
        sb.font = UIFont.systemFont(ofSize: 18)
        return sb
        
    }()
    
    let plot_Label:UILabel = {
        let sb = UILabel()
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.translatesAutoresizingMaskIntoConstraints = false
        sb.textAlignment = .left
        sb.textColor = UIColor.white
//        sb.text = "Plot:"
        sb.backgroundColor = UIColor.clear
        sb.font = UIFont.systemFont(ofSize: 18)
        sb.numberOfLines = 0
        return sb
        
    }()
    
    func constraint(){
        
        searchBar.leftAnchor.constraint(equalTo:self.view.leftAnchor,constant:16).isActive = true
        searchBar.topAnchor.constraint(equalTo:self.view.topAnchor,constant:32).isActive = true
        searchBar.rightAnchor.constraint(equalTo:self.view.rightAnchor,constant:-16).isActive = true
        searchBar.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        container.leftAnchor.constraint(equalTo:self.view.leftAnchor,constant:16).isActive = true
        container.topAnchor.constraint(equalTo:self.searchBar.bottomAnchor,constant:16).isActive = true
        container.bottomAnchor.constraint(equalTo:self.view.bottomAnchor,constant:-16).isActive = true
        container.rightAnchor.constraint(equalTo:self.view.rightAnchor,constant:-16).isActive = true
       
        container.addSubview(title_Label)
        container.addSubview(genre_Label)
        container.addSubview(releaseDate_Label)
        container.addSubview(rating_Label)
        container.addSubview(plot_Label)

        title_Label.leftAnchor.constraint(equalTo:self.view.leftAnchor,constant:16).isActive = true
        title_Label.topAnchor.constraint(equalTo:self.container.topAnchor,constant:24).isActive = true
        title_Label.rightAnchor.constraint(equalTo:self.view.rightAnchor,constant:-16).isActive = true
        title_Label.heightAnchor.constraint(equalToConstant: 25).isActive = true

        genre_Label.leftAnchor.constraint(equalTo:self.view.leftAnchor,constant:16).isActive = true
        genre_Label.topAnchor.constraint(equalTo:self.title_Label.bottomAnchor,constant:16).isActive = true
        genre_Label.rightAnchor.constraint(equalTo:self.view.rightAnchor,constant:-16).isActive = true
        genre_Label.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        releaseDate_Label.leftAnchor.constraint(equalTo:self.view.leftAnchor,constant:16).isActive = true
        releaseDate_Label.topAnchor.constraint(equalTo:self.genre_Label.bottomAnchor,constant:16).isActive = true
        releaseDate_Label.rightAnchor.constraint(equalTo:self.view.rightAnchor,constant:-16).isActive = true
        releaseDate_Label.heightAnchor.constraint(equalToConstant: 25).isActive = true
        
        rating_Label.leftAnchor.constraint(equalTo:self.view.leftAnchor,constant:16).isActive = true
        rating_Label.topAnchor.constraint(equalTo:self.releaseDate_Label.bottomAnchor,constant:16).isActive = true
        rating_Label.rightAnchor.constraint(equalTo:self.view.rightAnchor,constant:-16).isActive = true
        rating_Label.heightAnchor.constraint(equalToConstant: 25).isActive = true
        plot_Label.leftAnchor.constraint(equalTo:self.view.leftAnchor,constant:16).isActive = true
        plot_Label.topAnchor.constraint(equalTo:self.rating_Label.bottomAnchor,constant:16).isActive = true
        plot_Label.rightAnchor.constraint(equalTo:self.view.rightAnchor,constant:-16).isActive = true
}
  
    func startLoading(){
        KRProgressHUD.show()
        KRProgressHUD.set(activityIndicatorStyle: .black)
    }
    func endLoading(){
        let delay = DispatchTime.now()
        DispatchQueue.main.asyncAfter(deadline: delay) {
            KRProgressHUD.dismiss()
        }
    }
    func mask(){
        KRProgressHUD.set(style: .white)
    }
}
extension UIColor{
    func HexToColor(_ hexString: String, alpha:CGFloat? = 1.0) -> UIColor {
        let hexint = Int(self.intFromHexString(hexString))
        let red = CGFloat((hexint & 0xff0000) >> 16) / 255.0
        let green = CGFloat((hexint & 0xff00) >> 8) / 255.0
        let blue = CGFloat((hexint & 0xff) >> 0) / 255.0
        let alpha = alpha!
        let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
        return color
    }
    func intFromHexString(_ hexStr: String) -> UInt32 {
        var hexInt: UInt32 = 0
        let scanner: Scanner = Scanner(string: hexStr)
        scanner.charactersToBeSkipped = CharacterSet(charactersIn: "#") as CharacterSet
        scanner.scanHexInt32(&hexInt)
        return hexInt
    }
}

