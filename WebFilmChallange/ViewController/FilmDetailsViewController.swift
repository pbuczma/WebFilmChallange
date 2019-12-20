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
    var delegate: FilmWebProtocol?

    var dateFormatter = { () -> DateFormatter in
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        
        return dateFormatter
    }()
    
    var numberFormatter = NumberFormatter()
    var btnBarFavourite: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filmDetails = FilmDetailsView()
        self.title = NSLocalizedString("FILM_DETAILS_WINDOW_TITLE", comment: "Window title")
        filmDetails.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(filmDetails)
        updateViewConstraints(myView: filmDetails)
        
        btnBarFavourite = createBarButton()
        
        self.navigationItem.rightBarButtonItem = btnBarFavourite
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
   
    func createBarButton() -> UIBarButtonItem {
        
        let barButton = UIBarButtonItem(image: UIImage(named: "star-empty"), style: .plain, target: self, action: #selector(favouriteButtonPressed(_:)))
        barButton.tintColor = .black
        
        return barButton
    }
    
    
    func setFavouriteIcon(selected: Bool){
        
        let image: UIImage!
        
        if selected {
            image = UIImage(named: "star-filled")
        }else{
            image = UIImage(named: "star-empty")
        }
        
        self.btnBarFavourite.setBackgroundImage(image, for: .normal, barMetrics: .default)
    }
    
    
    
    @objc func favouriteButtonPressed( _ sender: UIBarButtonItem ){
        
        if webFilm != nil {
            webFilm!.favourie = !webFilm!.favourie
            delegate?.setFavourite(aWebFilm: webFilm!)
            setFavouriteIcon(selected: webFilm!.favourie)
        }
        
    }
    
    
    func setFilm( webFilm: WebFilm ){
        
        let releaseDatePrefix = NSLocalizedString("FILM_DETAILS_WINDOW_RELEASE", comment: "Release date")
        let averageVotePrefix = NSLocalizedString("FILM_DETAILS_WINDOW_VOTE", comment: "Score")
        
        filmDetails.lblTitle.text    = webFilm.title
        filmDetails.lblOverview.text = webFilm.overview
        
        if webFilm.releaseDate != nil{
            let releaseDate = dateFormatter.string(from: webFilm.releaseDate!)
            filmDetails.lblReleaseDate.text = "\(releaseDatePrefix) \(releaseDate)"
            
        }
        
        if webFilm.averageVote != nil {
            let averageVote = numberFormatter.string(from: NSNumber(value: webFilm.averageVote!))
            if averageVote != nil{
                filmDetails.lblAverageVote.text = "\(averageVotePrefix) \(averageVote!)"
            }
        }
        
        if webFilm.posterPath != nil {
            getPoster(posterSuffix: webFilm.posterPath!)
        }
        
        setFavouriteIcon(selected: webFilm.favourie)
        
    }
    

    func getPoster( posterSuffix: String ) {
        
        guard let urlString = URLHelper.posterURL(posterSuffix: posterSuffix) else { return }
        
        guard let url = URL(string: urlString) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else { return }
            
            print("Download Finished")
            DispatchQueue.main.async() {
                self.filmDetails.viewPoster.image = UIImage(data: data)
            }
        }
        task.resume()
    }
    
    
    
}


