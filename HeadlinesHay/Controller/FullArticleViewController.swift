//
//  FullArticleViewController.swift
//  HeadlinesHay
//
//  Created by Sajid Javed on 10/11/20.
//  Copyright © 2020 Sajid Javed. All rights reserved.
//

import UIKit
import WebKit

class FullArticleViewController: UIViewController {
    
    
    var articleUrl = String()
    var articleTitle = String()
    

    @IBOutlet weak var webView: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
//        if let articleUrl = articleUrl {
//            print(videoId)
//        }
        self.title = articleTitle
        let url = URL(string: articleUrl)
        webView.load(URLRequest(url: url!))

        
        print("FullArticleViewController : ",articleUrl)
        
        
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
