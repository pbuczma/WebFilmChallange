//
//  FilmListView.swift
//  WebFilmChallange
//
//  Created by Zespół ds Środowiska Pracy IT on 18/12/2019.
//  Copyright © 2019 Piotr Buczma. All rights reserved.
//

import UIKit

class FilmListView: UIView {

    let lblTitle = UILabel()
    let tblList = UITableView()
    
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
        lblTitle.text = NSLocalizedString("FILM_LIST_LBL_TITLE", comment: "List of films")
        
        
        tblList.translatesAutoresizingMaskIntoConstraints = false
    
        
        
    }
    
    
    private func addToView(){
        
        self.addSubview(lblTitle)
        self.addSubview(tblList)
        
    }
    
    
    override func updateConstraints() {
        
        super.updateConstraints()
        
        if #available(iOS 11.0, *) {
            self.lblTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        } else {
            self.lblTitle.topAnchor.constraint(equalTo: self.layoutMarginsGuide.topAnchor, constant: 20).isActive = true
        }
        
        self.lblTitle.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        
        
        self.tblList.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 15).isActive = true
        self.tblList.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        self.tblList.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
        self.tblList.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        
        
    }
    
    

}
