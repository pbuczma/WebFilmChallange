//
//  FilmDetailsView.swift
//  WebFilmChallange
//
//  Created by Zespół ds Środowiska Pracy IT on 19/12/2019.
//  Copyright © 2019 Piotr Buczma. All rights reserved.
//

import Foundation
import UIKit

class FilmDetailsView: UIView {

    let lblTitle = UILabel()
    let lblOverview = UILabel()
    let lblReleaseDate    = UILabel()
    let lblAverageVote = UILabel()
    let viewPoster      = UIImageView()
    
    
    let stkViewVMain = UIStackView()
    let stkViewTop   = UIStackView()
    let stkViewHMiddle = UIStackView()
    let stkViewVRigth = UIStackView()
    let stkViewVLeft  = UIStackView()
    let stkViewBottom = UIStackView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setProps()
        addToView()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setProps(){
        
        self.backgroundColor = .white
        
        lblTitle.font = UIFont.systemFont(ofSize: 20)
        lblTitle.textAlignment = .center
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        stkViewVMain.translatesAutoresizingMaskIntoConstraints = false
        
        
        setStackViewProperties(stackView: stkViewVMain, axis: .vertical, distribution: .fill, aligmnet: .center, spacing: 15)
        setStackViewProperties(stackView: stkViewTop, axis: .horizontal, distribution: .fill, aligmnet: .leading, spacing: 5)
        setStackViewProperties(stackView: stkViewHMiddle, axis: .horizontal, distribution: .fill, aligmnet: .leading, spacing: 15)
        setStackViewProperties(stackView: stkViewVRigth, axis: .vertical, distribution: .fill, aligmnet: .leading, spacing: 20)
        setStackViewProperties(stackView: stkViewVLeft, axis: .vertical, distribution: .fill, aligmnet: .center, spacing: 5)
        setStackViewProperties(stackView: stkViewBottom, axis: .horizontal, distribution: .fill, aligmnet: .center, spacing: 5)
        
        viewPoster.contentMode = .scaleAspectFit
        
        lblOverview.numberOfLines = 0
        lblOverview.textAlignment = .justified
    
    }
    
    
    private func addToView(){
        
        stkViewTop.addArrangedSubview(lblTitle)
        stkViewVLeft.addArrangedSubview(viewPoster)
        stkViewVRigth.addArrangedSubview(lblReleaseDate)
        stkViewVRigth.addArrangedSubview(lblAverageVote)
        
        stkViewHMiddle.addArrangedSubview(stkViewVLeft)
        stkViewHMiddle.addArrangedSubview(stkViewVRigth)
        
        
        stkViewBottom.addArrangedSubview(lblOverview)
        
        stkViewVMain.addArrangedSubview(stkViewTop)
        stkViewVMain.addArrangedSubview(stkViewHMiddle)
        stkViewVMain.addArrangedSubview(stkViewBottom)
        
        self.addSubview(stkViewVMain)
        
    }
    
    
    override func updateConstraints() {
        
        super.updateConstraints()
        
        
        
        if #available(iOS 11.0, *) {
            self.stkViewVMain.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        } else {
            self.stkViewVMain.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 20).isActive = true
        }
        
        self.stkViewVMain.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.stkViewVMain.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        
        
        self.viewPoster.heightAnchor.constraint(equalToConstant: AppConstants.FILM_DETAILS_IMG_VIEW_HEIGTH).isActive = true
        self.viewPoster.widthAnchor.constraint(equalToConstant: AppConstants.FILM_DETAILS_IMG_VIEW_WIDTH).isActive = true
        
        
    }
    
    
    private func setStackViewProperties(stackView: UIStackView, axis: NSLayoutConstraint.Axis, distribution: UIStackView.Distribution, aligmnet : UIStackView.Alignment, spacing: CGFloat ){
        stackView.axis = axis
        stackView.distribution = distribution
        stackView.alignment = aligmnet
        stackView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        stackView.spacing = spacing
    }
    

}



