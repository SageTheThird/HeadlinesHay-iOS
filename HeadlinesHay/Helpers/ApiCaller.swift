//
//  ApiCaller.swift
//  HeadlinesHay
//
//  Created by Sajid Javed on 10/13/20.
//  Copyright © 2020 Sajid Javed. All rights reserved.
//

import Foundation
import Alamofire


class ApiCaller{
    
    
    var topHeadlinesUrl = "https://newsapi.org/v2/top-headlines"
    var searchUrl = "https://newsapi.org/v2/everything"
    
    var query = "trump"
    var pageNo = 1
    
    
    public func getTopHeadlines(completion : @escaping ([Article], String)->()) -> Void {
        
        var articles = [Article]()
        
        let parameters: Parameters = [
            "country": "us",//make this universal
            "apiKey": "8833c0b1962c49a2b802549139ea04cd",
            "page" : String(pageNo)
        ]
        
        
        Alamofire.request(URL(string: topHeadlinesUrl)!, method: .get, parameters: parameters, headers: nil).responseJSON{ response in
            
            
            //to get status code
            if let status = response.response?.statusCode {
                switch(status){
                    
                case 426:
                    completion(articles, "Code 426 : Upgrade Plan For More Requests")
                    print("Upgrade Plan For More Requests")
                    
                case  400:
                    completion(articles, "Code 400 : Bad Request. The request was unacceptable, often due to a missing or misconfigured parameter.")
                    print("Bad Request. The request was unacceptable, often due to a missing or misconfigured parameter.")
                    
                case  401:
                    completion(articles, "Code 401 : Unauthorized. Your API key was missing from the request, or wasn't correct.")
                    print("Unauthorized. Your API key was missing from the request, or wasn't correct.")
                    
                case  429:
                    completion(articles, "Code 429 : Too Many Requests. You made too many requests within a window of time and have been rate limited. Back off for a while.")
                    print("Too Many Requests. You made too many requests within a window of time and have been rate limited. Back off for a while.")
                    
                case  500:
                    completion(articles, "Code 500 : Server Error. Something went wrong on our side.")
                    print("Server Error. Something went wrong on our side.")
                    
                    
                case 200:
                    
                    do{
                        
                        print("init Decoding")
                        let decodeJSON = JSONDecoder()
                        decodeJSON.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try! decodeJSON.decode(HeadlineModel.self, from: response.data!)
                        
                        articles = result.articles
                        
                        completion(articles, "Request Success")
                        print("Items Count in Helper : ",articles.count)
                        
                        
                    } catch {
                        //catch the errors
                        
                    }
                    
                default:
                    print("error with response status: \(status)")
                    
                }
            }
            
            
            
            
        }
        
        
    }
    
    
    
    public func searchNews(completion : @escaping ([Article])->()) -> Void {
        
        
        let parameters: Parameters = [
            "q" : query,//make this universal
            "apiKey": "8833c0b1962c49a2b802549139ea04cd",
            "page" : String(pageNo)
        ]
        
        
        Alamofire.request(URL(string: searchUrl)!, method: .get, parameters: parameters, headers: nil).responseJSON{ response in
            
            
            //to get status code
            if let status = response.response?.statusCode {
                switch(status){
                    
                case 426:
                    print("Upgrade Plan For More Requests")
                    
                case  400:
                    print("Bad Request. The request was unacceptable, often due to a missing or misconfigured parameter.")
                    
                case  401:
                    print("Unauthorized. Your API key was missing from the request, or wasn't correct.")
                    
                case  429:
                    print("Too Many Requests. You made too many requests within a window of time and have been rate limited. Back off for a while.")
                    
                case  500:
                    print("Server Error. Something went wrong on our side.")
                    
                    
                case 200:
                    
                    do{
                        
                        print("init Decoding")
                        let decodeJSON = JSONDecoder()
                        decodeJSON.keyDecodingStrategy = .convertFromSnakeCase
                        let result = try! decodeJSON.decode(HeadlineModel.self, from: response.data!)

                        completion(result.articles)
                        
                        
                    } catch {
                        //catch the errors
                        
                    }
                    
                default:
                    print("error with response status: \(status)")
                    
                }
            }
            
            
            
            
        }
        
        
    }
    
    
}
