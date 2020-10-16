//
//  HeadlineCell.swift
//  HeadlinesHay
//
//  Created by Sajid Javed on 10/6/20.
//  Copyright © 2020 Sajid Javed. All rights reserved.
//

import UIKit

class HeadlineCell: UITableViewCell {

    @IBOutlet weak var rootContentView: UIView!
    
    
    @IBOutlet weak var headlineTitle: UILabel!
    
    
    @IBOutlet weak var sourceBtn: UIButton!
    @IBOutlet weak var headlineImage: UIImageView!
    
    @IBOutlet weak var descriptionLbl: UILabel!
    
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        stackView.addBackground(color: hexStringToUIColor(hex: "b3acab"))
        
        configuretitleLbl()
        configureImageView()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func configureImageView(){
        headlineImage.layer.cornerRadius = 5
        headlineImage.clipsToBounds = true
//        setImageViewConstraints()
    }
    func configuretitleLbl(){
        
        headlineTitle.numberOfLines = 0
        headlineTitle.lineBreakMode = .byWordWrapping
        descriptionLbl.numberOfLines = 0
        descriptionLbl.lineBreakMode = .byWordWrapping
//        setTitleLblConstraints()
    }
    
    func setImageViewConstraints(){
    headlineImage.translatesAutoresizingMaskIntoConstraints = false
//    headlineImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        //start constraint
        headlineImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12).isActive = true
        //top constraint
    headlineImage.topAnchor.constraint(equalTo: headlineTitle.bottomAnchor, constant: 10).isActive = true
//    headlineImage.heightAnchor.constraint(equalTo: headlineTitle.bottomAnchor).isActive = true
        //end constraint
    headlineImage.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    headlineImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10)
    
    }
    
    func setTitleLblConstraints(){
        headlineTitle.translatesAutoresizingMaskIntoConstraints = false
//        headlineImage.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        //end constraint
        headlineTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20)
        //start constraint
        headlineTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20).isActive = true
        //top constraint
        headlineTitle.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        //end constraint
        headlineTitle.widthAnchor.constraint(equalTo: widthAnchor, constant: 20)
//        headlineTitle.bottomAnchor.constraint(equalTo: headlineImage.topAnchor)
    }

}


extension UIStackView {
    func addBackground(color: UIColor) {
        let subView = UIView(frame: bounds)
        subView.backgroundColor = color
        subView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(subView, at: 0)
    }
}


//takes hex code and returns UIColor
func hexStringToUIColor (hex:String) -> UIColor {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
    
    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }
    
    if ((cString.count) != 6) {
        return UIColor.gray
    }
    
    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)
    
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}
