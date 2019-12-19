//
//  ListFilmTableViewCell.swift
//  WebFilmChallange
//
//  Created by Zespół ds Środowiska Pracy IT on 18/12/2019.
//  Copyright © 2019 Piotr Buczma. All rights reserved.
//

import UIKit

class FilmListTableViewCell: UITableViewCell {

    static let CELLID = "ListFilmTableViewCell"
    
    
    var lblTitle: UILabel!
    var btnFavourite: UIButton!
    var stkView: UIStackView!
    var delegate: FilmWebProtocol?
    
    var webFilm: WebFilm?{
        didSet{
            
            if webFilm != nil {
                lblTitle.text = webFilm?.title
            }else{
                lblTitle.text = nil
                delegate?.emptyValueAppeared()
            }
        }
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUIProperties()
        addUIControlsToView()
        
        setUIConstraint()
         
        selectionStyle = .none
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    
    private func setUIProperties(){
        
        
        self.lblTitle      = UILabel()
        self.btnFavourite  = UIButton()
        self.stkView       = UIStackView()
        
        
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        btnFavourite.translatesAutoresizingMaskIntoConstraints = false
        stkView.translatesAutoresizingMaskIntoConstraints = false
        
        
        lblTitle.adjustsFontSizeToFitWidth = true
        lblTitle.minimumScaleFactor = 0.5
        
        btnFavourite.setImage(UIImage(named: "star-empty"), for: .normal)
        btnFavourite.setImage(UIImage(named: "start-filled"), for: .selected)
        
        stkView.alignment = .center
        stkView.distribution = .fill
        stkView.spacing = 0
        
        
        self.preservesSuperviewLayoutMargins = false
        self.separatorInset = UIEdgeInsets.zero
        self.layoutMargins = UIEdgeInsets.zero

        
    }
    
    
    private func addUIControlsToView() {
        
        stkView.addArrangedSubview(lblTitle)
        stkView.addArrangedSubview(btnFavourite)
        
        self.contentView.addSubview(stkView)
    }
    
    
    private func setUIConstraint(){
        
        
        contentView.heightAnchor.constraint(greaterThanOrEqualToConstant: AppConstants.LIST_FILM_CELL_HEIGTH).isActive = true
        
        stkView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 0).isActive = true
        stkView.leftAnchor.constraint(equalTo: self.contentView.leftAnchor, constant: 10).isActive = true
        stkView.rightAnchor.constraint(equalTo: self.contentView.rightAnchor, constant: -10).isActive = true
        stkView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: 0).isActive = true
        
        
        btnFavourite.widthAnchor.constraint(equalToConstant: btnFavourite.intrinsicContentSize.width).isActive = true
        btnFavourite.heightAnchor.constraint(equalToConstant: btnFavourite.intrinsicContentSize.height).isActive = true
        
    }
    
    
    
    
    
    
}



/*
 
 //
 //  ListArchiveViewCell.swift
 //  Smart Shopping List
 //
 //  Created by Zespół ds Środowiska Pracy IT on 24/09/2019.
 //  Copyright © 2019 Piotr Buczma. All rights reserved.
 //

 import UIKit
 import CoreData

 class ListArchiveTableViewCell: UITableViewCell {

     static let CELLID = "ListArchiveViewCell"
     
     var lblListName: UILabel!
     var lblDate: UILabel!
     var btnDelete: UIButton!
     var btnRestore: UIButton!
     var stkStack: UIStackView!
     
     var listOperation: ListOperationProtocol?
     
     
     var aList: ShoppingList? {
         
         didSet{
             
             guard let aList = aList else { return }
             
             self.lblListName.text = aList.name
             if aList.created != nil {
                 self.lblDate.text = AppVariables.shared.dateFormatter.string(from: aList.created! )
             }
             
         }
         
     }
     
     override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
         super.init(style: style, reuseIdentifier: reuseIdentifier)
         
         setUIProperties()
         addUIControlsToView()
        
         setUIConstraint()
         
         selectionStyle = .none
         
     }
     
     
     
     required init?(coder aDecoder: NSCoder) {
         fatalError("init(coder:) has not been implemented")
     }
     
     override func setSelected(_ selected: Bool, animated: Bool) {
         super.setSelected(selected, animated: animated)
         
         //self.isSelected = selected
         // Configure the view for the selected state
     }
     

     fileprivate func setUIProperties(){
         
         self.lblListName = UILabel()
         self.lblDate     = UILabel()
         self.btnDelete   = UIButton()
         self.btnRestore  = UIButton()
         self.stkStack    = UIStackView()
         
         self.lblListName.translatesAutoresizingMaskIntoConstraints = false
         self.lblDate.translatesAutoresizingMaskIntoConstraints = false
         self.btnDelete.translatesAutoresizingMaskIntoConstraints = false
         self.btnRestore.translatesAutoresizingMaskIntoConstraints = false
         self.stkStack.translatesAutoresizingMaskIntoConstraints = false
         
         self.lblListName.adjustsFontSizeToFitWidth = true
         self.lblListName.minimumScaleFactor = 0.5
         self.lblListName.textColor = LayoutColors.getColorsFor(listViewElement: .ListArchiveListName, trait: self.traitCollection)
         
         self.lblDate.textColor = LayoutColors.getColorsFor(listViewElement: .ListArchiveDate, trait: self.traitCollection)
         self.lblDate.font = UIFont.systemFont(ofSize: 12)
         
         self.btnDelete.setImage(UIImage(named: "delete_s")?.overlayImage(color: AppConstants.LIST_ARCHIVE_DETAILS_DELETE_COLOR), for: .normal)
         self.btnRestore.setImage(UIImage(named: "undo")?.overlayImage(color: AppConstants.LIST_ARCHIVE_DETAILS_RESTORE_COLOR), for: .normal)
         
         self.stkStack.alignment = .center
         self.stkStack.distribution = .fillEqually
         self.stkStack.spacing = AppConstants.LIST_ARCHIVE_DETAILS_CELL_SPAN
         
         self.btnRestore.addTarget(self, action: #selector(restoreButtonPressed(_:)), for: .touchUpInside)
         self.btnDelete.addTarget(self, action: #selector(deleteButtonPressed(_:)), for: .touchUpInside)
         
         //self.contentView.backgroundColor = AppConstants.LIST_ARCHIVE_DETAILS_CELL_COLOR
     }
     
     
     private func addUIControlsToView(){
         
         self.contentView.addSubview(lblListName)
         self.contentView.addSubview(lblDate)
         
         self.stkStack.addArrangedSubview(btnRestore)
         self.stkStack.addArrangedSubview(btnDelete)
         
         self.contentView.addSubview(stkStack)
         
     }
     
     private func setUIConstraint(){
         
         self.contentView.heightAnchor.constraint(equalToConstant: AppConstants.LIST_ARCHIVE_DETAILS_CELL_HEIGTH).isActive = true
         
         lblListName.topAnchor.constraint(equalTo: self.self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
         lblListName.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
         lblListName.rightAnchor.constraint(equalTo: btnRestore.leftAnchor, constant: -5).isActive = true
         
         lblDate.topAnchor.constraint(equalTo: lblListName.bottomAnchor, constant: 5).isActive = true
         lblDate.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
         lblDate.rightAnchor.constraint(equalTo: btnRestore.leftAnchor, constant: -5).isActive = true
         
         
         stkStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
         stkStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
         stkStack.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5).isActive = true
         
         btnRestore.widthAnchor.constraint(equalToConstant: AppConstants.LIST_ARCHIVE_DETAILS_BUTTON_SIZE).isActive = true
         btnRestore.heightAnchor.constraint(equalToConstant: AppConstants.LIST_ARCHIVE_DETAILS_BUTTON_SIZE).isActive = true
         btnDelete.widthAnchor.constraint(equalToConstant: AppConstants.LIST_ARCHIVE_DETAILS_BUTTON_SIZE).isActive = true
         btnDelete.heightAnchor.constraint(equalToConstant: AppConstants.LIST_ARCHIVE_DETAILS_BUTTON_SIZE).isActive = true
         
     }
     
     
     @objc func deleteButtonPressed(_ sender: UIButton) {
        
         if self.aList != nil {
             self.listOperation?.deleteElement(self.aList!, delay: 0)
         }
     }
     
     @objc func restoreButtonPressed(_ sender: UIButton) {
         if self.aList != nil {
             self.listOperation?.saveShoppingList(listElement: aList!)
         }
     }
     
 }

 
 */
