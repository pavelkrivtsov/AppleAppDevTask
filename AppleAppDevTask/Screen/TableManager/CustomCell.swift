//
//  CustomCell.swift
//  AppleAppDevTask
//
//  Created by Pavel Krivtsov on 12.05.2023.
//

import UIKit

final class CustomCell: UITableViewCell {
    
    static let cellIdentifier = "CustomCell"
    private var companyNameLabel = UILabel()
    
//    private var logo = ""
//    internal var backgroundColor = ""
//    private var mainColor = ""
//    private var cardBackgroundColor = ""
//    private var textColor = ""
//    private var highlightTextColor = ""
//    private var accentColor = ""
    
    override func prepareForReuse() {
        super.prepareForReuse()

    }
    
    func configure(item: ResponseItem){

    }
}
