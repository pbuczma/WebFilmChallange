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
        lblTitle.text = NSLocalizedString("FILM_DETAILS_LBL_TITLE", comment: "List of films")
        
        stkViewVMain.translatesAutoresizingMaskIntoConstraints = false
        stkViewTop.translatesAutoresizingMaskIntoConstraints = false
        stkViewHMiddle.translatesAutoresizingMaskIntoConstraints = false
        stkViewVRigth.translatesAutoresizingMaskIntoConstraints = false
        stkViewVLeft.translatesAutoresizingMaskIntoConstraints = false
        stkViewBottom.translatesAutoresizingMaskIntoConstraints = false
        
        
    }
    
    
    private func addToView(){
        
        stkViewTop.addArrangedSubview(lblTitle)
        stkViewVLeft.addArrangedSubview(viewPoster)
        stkViewVRigth.addArrangedSubview(lblReleaseDate)
        stkViewVRigth.addArrangedSubview(lblAverageVote)
        
        stkViewHMiddle.addArrangedSubview(stkViewVRigth)
        stkViewHMiddle.addArrangedSubview(stkViewVLeft)
        
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
        
        self.stkViewVMain.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        self.stkViewVMain.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        
        
        
    }
    
    
    
    
    
    

}


/*
 
 func downloadImage(from url: URL) {
     print("Download Started")
     getData(from: url) { data, response, error in
         guard let data = data, error == nil else { return }
         print(response?.suggestedFilename ?? url.lastPathComponent)
         print("Download Finished")
         DispatchQueue.main.async() {
             self.imageView.image = UIImage(data: data)
         }
     }
 }
 
 */
