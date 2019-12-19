//
//  FilmDetailsViewController.swift
//  WebFilmChallange
//
//  Created by Zespół ds Środowiska Pracy IT on 19/12/2019.
//  Copyright © 2019 Piotr Buczma. All rights reserved.
//

import UIKit

class FilmDetailsViewController: UIViewController {

    var filmDetails: FilmDetailsView!
    
    var webFilm: WebFilm?


    
    override func viewDidLoad() {
        super.viewDidLoad()

        filmDetails = FilmDetailsView()
        self.title = NSLocalizedString("FILM_DETAILS_WINDOW_TITLE", comment: "W")
        filmDetails.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(filmDetails)
        updateViewConstraints(myView: filmDetails)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if webFilm != nil {
            setFilm(webFilm: self.webFilm!)
        }
    }
    

    func updateViewConstraints(myView: UIView) {
       
       myView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
       myView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       myView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
       myView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
       
    }
   
    
    func setFilm( webFilm: WebFilm ){
        
        filmDetails.lblTitle.text    = webFilm.title
        filmDetails.lblOverview.text = webFilm.overview
        filmDetails.lblReleaseDate.text = "\(webFilm.releaseDate)"
        filmDetails.lblAverageVote.text = "\(webFilm.averageVote)"
        
    }
    

    
}
