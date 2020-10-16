//
//  HeadlineModel.swift
//  HeadlinesHay
//
//  Created by Sajid Javed on 10/6/20.
//  Copyright © 2020 Sajid Javed. All rights reserved.
//

import Foundation


class HeadlineModel: Codable{
    
    //all the fields included in a topHeadlines request
    
    var status: String?
    var totalResults:Int?
    var articles: [Article] = []
    
    
    
}


class Article: Codable{
    
    //all the fields included in a topHeadlines request
    
    var source: Source?
    var author:String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    
}

class Source: Codable{
    
    //all the fields included in a topHeadlines request
    
    var id: String?
    var name:String?
    
    
}
