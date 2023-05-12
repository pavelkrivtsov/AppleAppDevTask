//
//  CustomCell.swift
//  AppleAppDevTask
//
//  Created by Pavel Krivtsov on 12.05.2023.
//

import UIKit
import SnapKit
import Kingfisher

final class CustomCell: UITableViewCell {
    
    static let cellIdentifier = "CustomCell"
    
    private var cardView = UIView()
    
    private var companyNameLabel = UILabel()
    private var logoImageView = UIImageView()
    
    private var topSeperatorLine = UIView()
    private var bottomSeparatorLine = UIView()
    
    private var requiredSumIntLabel = UILabel()
    private var requiredSumTextLabel = UILabel()
    
    private var cashbackLabel = UILabel()
    private var cashbackPercentLabel = UILabel()
    
    private var lavelLabel = UILabel()
    private var lavelGradeLabel = UILabel()
    
    private var eyeButton = UIButton()
    private var trashButton = UIButton()
    private var aboutButton = UIButton()
    private var aboutButtonConfig = UIButton.Configuration.filled()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .clear
        
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints {
            $0.leading.trailing.bottom.top.equalToSuperview().inset(16)
        }
        
        cardView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints {
            $0.height.width.equalTo(44)
            $0.trailing.top.equalToSuperview().inset(16)
//            $0.bottom.equalToSuperview().inset(16)
        }
        //
        cardView.addSubview(companyNameLabel)
        companyNameLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.height.equalTo(logoImageView.snp.height)
            $0.trailing.equalTo(logoImageView.snp.leading).offset(-8)
            $0.centerY.equalTo(logoImageView.snp.centerY)
//            $0.bottom.equalToSuperview().inset(16)
        }
        
        cardView.addSubview(topSeperatorLine)
        topSeperatorLine.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
            $0.top.equalTo(logoImageView.snp.bottom).offset(8)
//            $0.bottom.equalToSuperview().inset(8)
        }
        
        cardView.addSubview(requiredSumIntLabel)
        requiredSumIntLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(topSeperatorLine.snp.bottom).offset(16)
//            $0.bottom.equalToSuperview().inset(8)
        }
        
        cardView.addSubview(requiredSumTextLabel)
        requiredSumTextLabel.snp.makeConstraints {
            $0.leading.equalTo(requiredSumIntLabel.snp.trailing).offset(8)
            $0.bottom.equalTo(requiredSumIntLabel.snp.bottom).inset(1)
        }
        
        cardView.addSubview(cashbackLabel)
        cashbackLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(requiredSumIntLabel.snp.bottom).offset(16)
//            $0.bottom.equalToSuperview().inset(16)
        }
        
        cardView.addSubview(cashbackPercentLabel)
        cashbackPercentLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(16)
            $0.top.equalTo(cashbackLabel.snp.bottom).offset(8)
//            $0.bottom.equalToSuperview().inset(16)
        
        }
        
        cardView.addSubview(lavelLabel)
        lavelLabel.snp.makeConstraints {
            $0.leading.equalTo(cashbackLabel.snp.trailing).offset(48)
            $0.centerY.equalTo(cashbackLabel.snp.centerY)
//            $0.bottom.equalToSuperview().inset(16)
        }
        
        cardView.addSubview(lavelGradeLabel)
        lavelGradeLabel.snp.makeConstraints {
            $0.leading.equalTo(lavelLabel.snp.leading)
            $0.top.equalTo(lavelLabel.snp.bottom).offset(8)
//            $0.bottom.equalToSuperview().inset(16)
        }
        
        cardView.addSubview(bottomSeparatorLine)
        bottomSeparatorLine.snp.makeConstraints {
            $0.top.equalTo(cashbackPercentLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(1)
        }
        
        cardView.addSubview(aboutButton)
        aboutButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(bottomSeparatorLine.snp.bottom).offset(8)
            $0.bottom.equalToSuperview().inset(16)
        }
        
        cardView.addSubview(eyeButton)
        eyeButton.snp.makeConstraints {
            $0.leading.equalTo(bottomSeparatorLine.snp.leading).offset(16)
            $0.top.equalTo(bottomSeparatorLine.snp.bottom).offset(16)
            $0.centerY.equalTo(aboutButton.snp.centerY)
        }
        
        cardView.addSubview(trashButton)
        trashButton.snp.makeConstraints {
            $0.leading.equalTo(eyeButton.snp.trailing).offset(48)
            $0.top.equalTo(bottomSeparatorLine.snp.bottom).offset(16)
            $0.centerY.equalTo(aboutButton.snp.centerY)
        }

        cardView.layer.cornerRadius = contentView.frame.height / 2
        
        logoImageView.layer.cornerRadius = 22
        logoImageView.clipsToBounds = true
        
        companyNameLabel.font = .systemFont(ofSize: 24)
//        companyNameLabel.backgroundColor = .green
        
        topSeperatorLine.backgroundColor = .lightGray
        
        requiredSumIntLabel.font = .systemFont(ofSize: 24, weight: .bold)
        requiredSumIntLabel.clipsToBounds = true
        
        requiredSumTextLabel.text = "баллов"
        requiredSumTextLabel.font = .systemFont(ofSize: 20)
        
        cashbackLabel.text = "Кешбэк"
        cashbackLabel.font = .systemFont(ofSize: 16)
//        cashbackLabel.backgroundColor = .green
        cashbackPercentLabel.font = .systemFont(ofSize: 20)
//        cashbackPercentLabel.backgroundColor = .green
        
        lavelLabel.text = "Уровень"
        lavelLabel.font = .systemFont(ofSize: 16)
//        lavelLabel.backgroundColor = . green
        lavelGradeLabel.font = .systemFont(ofSize: 20)
//        lavelGradeLabel.backgroundColor = .green
        
        bottomSeparatorLine.backgroundColor = .lightGray
        
        var container = AttributeContainer()
        container.font = UIFont.systemFont(ofSize: 20)
        aboutButtonConfig.attributedTitle = AttributedString("Подробнее", attributes: container)
        aboutButtonConfig.contentInsets = .init(top: 10, leading: 30, bottom: 10, trailing: 30)
        aboutButtonConfig.cornerStyle = .large
        aboutButton.configuration = aboutButtonConfig

        eyeButton.setImage(.init(systemName: "eye"), for: .normal)
        eyeButton.imageView?.contentMode = .scaleAspectFit

        trashButton.setImage(.init(systemName: "trash"), for: .normal)
        trashButton.imageView?.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        requiredSumIntLabel.text = "0"
        
    }
    
    func configure(item: ResponseItem){
        
        guard let url = URL(string: item.mobileAppDashboard.logo) else {
            print("CustomCell configure error")
            return
        }
        logoImageView.kf.setImage(with: url)
        
        cardView.backgroundColor = UIColor.init(hex: item.mobileAppDashboard.cardBackgroundColor)
        companyNameLabel.text = item.mobileAppDashboard.companyName
        companyNameLabel.textColor = UIColor.init(hex: item.mobileAppDashboard.highlightTextColor)
        requiredSumIntLabel.text = String(item.customerMarkParameters.loyaltyLevel.requiredSum)
        requiredSumIntLabel.textColor = UIColor.init(hex: item.mobileAppDashboard.highlightTextColor)
        requiredSumTextLabel.textColor = UIColor.init(hex: item.mobileAppDashboard.textColor)
        cashbackLabel.textColor = UIColor.init(hex: item.mobileAppDashboard.textColor)
        cashbackPercentLabel.text = String(item.customerMarkParameters.loyaltyLevel.cashToMark) + " %"
        lavelLabel.textColor = UIColor.init(hex: item.mobileAppDashboard.textColor)
        lavelGradeLabel.text = item.customerMarkParameters.loyaltyLevel.name
    
        eyeButton.imageView?.tintColor = UIColor.init(hex: item.mobileAppDashboard.mainColor)
        trashButton.imageView?.tintColor = UIColor.init(hex: item.mobileAppDashboard.accentColor)
                
        aboutButtonConfig.baseBackgroundColor = UIColor.init(hex: item.mobileAppDashboard.backgroundColor)
        aboutButtonConfig.baseForegroundColor = UIColor.init(hex: item.mobileAppDashboard.mainColor)
        aboutButton.configuration = aboutButtonConfig
    }
}
