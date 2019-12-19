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
    var tableHeigh: CGFloat = 200
    var maxTableHeigh: CGFloat = 500
    var tableHeighConstraint: NSLayoutConstraint!
    
    
    
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
        
        tableHeighConstraint = tblList.heightAnchor.constraint(equalToConstant: tableHeigh)
        
        
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
        
        
        setTableConstraint()
        
    }
    
    
    func setTableConstraint(){
        
        NSLayoutConstraint.deactivate([tableHeighConstraint!])
        tableHeighConstraint.constant = tableHeigh
        NSLayoutConstraint.activate([tableHeighConstraint!])
        
        
    }
    
    
    func calculateTableHeight(time: Double, navBarHeigth: CGFloat?, _ completion: @escaping () ->Void  ){
        
        var tableMaxHeigth: CGFloat = self.frame.height - self.convert(tblList.frame, from: self).minY
        
        //frame inset adjust
        if #available(iOS 11.0, *) {
            let bottomInset = self.safeAreaInsets.bottom
            tableMaxHeigth -= bottomInset
        }
        
        
        UIView.animate(withDuration: time, animations: {
            
            self.tblList.reloadData()
            
            Timer.scheduledTimer(withTimeInterval: time + 0.1, repeats: false, block: { [weak self] (timer) in
                if  self != nil {
                    
                    let height = self!.tblList.contentSize.height
                    
                    if height < tableMaxHeigth {
                        self!.tableHeigh = height
                    }else{
                        self!.tableHeigh = tableMaxHeigth
                    }
                    self!.setTableConstraint()
                }
                completion()
            })
        })
    }
    
    

}
