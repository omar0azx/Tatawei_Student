//
//  WebVC.swift
//  Tatawei Student
//
//  Created by testuser on 14/04/1446 AH.
//

import UIKit
import WebKit

class WebVC: UIViewController, Storyboarded {

    //MARK: - Varibales
    
    var coordinator: MainCoordinator?
    
    var webUrl: String?
    
    
    //MARK: - IBOutleats
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check if webUrl is a valid string and load it in the web view
        guard let webURL = webUrl, let url = URL(string: webURL) else {
            print("Invalid URL string")
            return
        }

        let req = URLRequest(url: url)
        webView.load(req)  // Ensure myWebview is properly connected

       // Do any additional setup after loading the view.
    }
    
    
    //MARK: - IBAcitions
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Functions
}
