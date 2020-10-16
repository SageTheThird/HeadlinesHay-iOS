//
//  ViewController.swift
//  HeadlinesHay
//
//  Created by Sajid Javed on 10/6/20.
//  Copyright © 2020 Sajid Javed. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher

class ViewController: UIViewController, UISearchBarDelegate{
    

    let successRequestMessage = "Request Success"
    @IBOutlet weak var headlinesTableView: UITableView!
    var headlines = [Article]()
    //pagination vars
    var isLoading = false
    var searchNewFlag = false
    let api = ApiCaller()
    //searchBar in navigation
    let searchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewSetup()
        
        
        navigationWithSearchBarSetup()
        
        //requests api for the day's headlines and sets the data
        getTopHeadlines()

    }
    
    func getTopHeadlines(){
        
        
        self.isLoading = true
        
        api.getTopHeadlines(completion : { articles, error in
            
            if(error != self.successRequestMessage){
                self.showToast(message: error, font: .systemFont(ofSize: 13))
            }
            
            
            //add new items to the end of array
            self.headlines.append(contentsOf: articles)
            self.headlinesTableView.reloadData()
            
            //if request returns no new items, its the last page
            if(articles.count != 0){
                self.isLoading = false
            }
            
            
            
        })
     
    }
    
    
    func searchNews(){
        
        
        self.isLoading = true
        
        api.searchNews(completion : { articles in
            
            //add new items to the end of array
            self.headlines.append(contentsOf: articles)
            self.headlinesTableView.reloadData()
           
            
            
            //if request returns no new items, its the last page
            if(articles.count != 0){
                self.isLoading = false
            }
            
            
            
        })

    }
    

    
    
    
    
    func loadImageWith(url link:URL, on imageView: UIImageView!){
        // Downsampling and loading image in IV
        let processor = DownsamplingImageProcessor(size: CGSize(width: 400, height: 280))//resize processor
        imageView.kf.setImage(with: link, placeholder: UIImage(named: "placeholder"), options : [.transition(.fade(0.2)), .processor(processor)])
    }
    
    func triggerSearch(){
        headlines = [Article]()
        headlinesTableView.reloadData()
        searchNewFlag = true
        api.query = String(searchController.searchBar.text!)
        searchNews()
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("textDidChange : ",searchText)
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //here the user has pressed enter, query the api
        triggerSearch()
        print("Final Text : ",searchBar.text as Any)
    }
    
    
    
    
    func navigationWithSearchBarSetup(){
        //setup searchBar in navigation
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search News About"
        
        //changes text color of searchBar univerally
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).defaultTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        if #available(iOS 11.0, *) {
            
            navigationItem.hidesSearchBarWhenScrolling = false
        }
    }
    
    
    func tableViewSetup(){
        headlinesTableView.delegate = self
        headlinesTableView.dataSource = self
        //making TableView cells dynamic in size
        headlinesTableView.rowHeight = UITableView.automaticDimension
        headlinesTableView.estimatedRowHeight = 530
    }
    
}







//TableView Extension
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == headlines.count - 1 {
            //we are at the last cell
            if(!isLoading){
                print("Loading More Data : ",api.pageNo)
                if(searchNewFlag){
                    api.pageNo = api.pageNo+1
                    searchNews()
                }else{
                    api.pageNo = api.pageNo+1
                    getTopHeadlines()
                }
                
                
            }
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //when an item in tableView is clicked
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "full_article_vc") as! FullArticleViewController
        vc.modalPresentationStyle = .fullScreen
        if let url = headlines[indexPath.row].url {
            vc.articleUrl = url
        }
        if let title = headlines[indexPath.row].title {
            vc.articleTitle = title
        }
        //push the second controller to screen
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return headlines.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "headlineCell") as! HeadlineCell
        
        
        //checks and sets title
        if let title = headlines[indexPath.row].title {
            cell.headlineTitle.text = title
        }
        
        //checks and sets description
        if let description = headlines[indexPath.row].description {
            cell.descriptionLbl.text = description
        }
        
        if let source = headlines[indexPath.row].source?.name {
            let sourceText = "Read Now On " + source.uppercased()
            cell.sourceBtn.setTitle(sourceText, for: .normal)
        }
        
        //binds imageUrl to ImageView using kingfisher
        if let imageUrl = headlines[indexPath.row].urlToImage  {
            if let url = URL(string: imageUrl){
                
                //shows indicator while loading
                cell.headlineImage.kf.indicatorType = .activity
                loadImageWith(url: url, on: cell.headlineImage)
            }
            
           
            
        }
        
        
        
        return cell
    }
    
}
