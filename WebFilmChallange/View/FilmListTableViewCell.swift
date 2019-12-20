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
                lblTitle.text = webFilm!.title
                btnFavourite.isSelected = webFilm!.favourie
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
        
        btnFavourite.addTarget(self, action: #selector(favouriteButtonPressed(_:)), for: .touchUpInside)
        
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
        btnFavourite.setImage(UIImage(named: "star-filled"), for: .selected)
        
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
    
    
    @objc func favouriteButtonPressed(_ sender: UIButton){
    
        if webFilm != nil {
            webFilm!.favourie = !webFilm!.favourie
            delegate?.setFavourite(aWebFilm: webFilm!)
        }
    }
    
    
    
    
}



/*
 
 
     
         self.stkStack.alignment = .center
         self.stkStack.distribution = .fillEqually
         self.stkStack.spacing = AppConstants.LIST_ARCHIVE_DETAILS_CELL_SPAN
         
 var spinnerView: UIActivityIndicatorView?
 
 
   
 func setSpinnerStatus( active: Bool){
     
     if active {
         UIView.animate(withDuration: 0, animations: {
             DispatchQueue.main.async {
                 self.spinnerView?.isHidden = false
                 self.spinnerView?.startAnimating()
                 self.setNeedsLayout()
             }
         })
         //print( "starting: \(self.spinnerView?.frame) \(self.spinnerView?.isHidden)" )
     }else{
         DispatchQueue.main.async {
             self.spinnerView?.stopAnimating()
             self.spinnerView?.isHidden = true
             self.setNeedsLayout()
         }
         //print( "stopping \(self.spinnerView?.frame) \(self.spinnerView?.isHidden)" )
     }
     
 
 }
 
 
 
 private func setSpinnerProperties(){
     
     spinnerView?.hidesWhenStopped = true
     spinnerView?.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
     spinnerView?.isHidden = true
     spinnerView?.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
     spinnerView?.translatesAutoresizingMaskIntoConstraints = false

 }
 
 
 */
