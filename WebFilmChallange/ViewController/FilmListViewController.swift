//
//  FilmListViewController.swift
//  WebFilmChallange
//
//  Created by Zespół ds Środowiska Pracy IT on 18/12/2019.
//  Copyright © 2019 Piotr Buczma. All rights reserved.
//

import UIKit

class FilmListViewController: UIViewController {

    var filmList: FilmListView!
    var isFilmQuery = false
    var webFilmProxy: WebFilmProxy!
    var webFilm: [WebFilm] = []
    var hasNextPage = true
    var lastPageLoadTime: Date?
    var searchView: UISearchController!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        
        filmList = FilmListView()
        self.title = NSLocalizedString("FILM_LIST_WINDOW_TITLE", comment: "Lism list")
        filmList.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(filmList)
        updateViewConstraints(myView: filmList)
        self.filmList.tblList.register(FilmListTableViewCell.self, forCellReuseIdentifier: FilmListTableViewCell.CELLID)
        
        filmList.tblList.dataSource = self
        filmList.tblList.delegate = self
        
        let urlSession = URLSession(configuration: .default)
        webFilmProxy = WebFilmProxy(urlSession: urlSession)
        
        loadNowPlayingFilm()
        
        addSearchBar()
        
    }
    
    
    func addSearchBar(){
        
        searchView = UISearchController(searchResultsController: nil)
        
        searchView.view.translatesAutoresizingMaskIntoConstraints = false
        
        searchView.searchResultsUpdater = self
        searchView.obscuresBackgroundDuringPresentation = false
        searchView.searchBar.placeholder = NSLocalizedString("FILM_LIST_SEARCH_PLACEHOLDER", comment: "enter film name")
        
        searchView.dimsBackgroundDuringPresentation = false // The default is true.
        searchView.searchBar.delegate = self // Monitor when the search button is tapped.
        searchView.searchBar.setValue(NSLocalizedString("FILM_LIST_SEARCH_BUTTON", comment: "Cancel"), forKey: "cancelButtonText")
        
        
        if #available(iOS 11.0, *) {
            // For iOS 11 and later, place the search bar in the navigation bar.
            navigationItem.searchController = searchView
            
            // Make the search bar always visible.
            navigationItem.hidesSearchBarWhenScrolling = false
        } else {
            // For iOS 10 and earlier, place the search controller's search bar in the table view's header.
            filmList.tblList.tableHeaderView = searchView.searchBar
        }
        
    }
    
    
    func loadNowPlayingFilm(){
        
        
        webFilmProxy.nextNowPlayingFilm { [weak self] ( _webFilm, _error) in
            
            self?.webFilm.append(contentsOf: _webFilm)
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.hasNextPage = self.webFilmProxy.hasNextNowPlayingFilm()
                self.reloadTable()
            }
            
        }
        
    }

    func loadSearchMovie(query: String){
        
        if webFilmProxy.searchMovieQuery != query {
            webFilm.removeAll()
        }
        
        webFilmProxy.nextSearchMovieFilm(query: query) { [weak self] ( _webFilm, _error) in
            
            self?.webFilm.append(contentsOf: _webFilm)
            DispatchQueue.main.async { [weak self] in
                print("number of records: \(_webFilm.count)")
                guard let self = self else { return }
                self.hasNextPage = self.webFilmProxy.hasNextSearchMovie()
                self.reloadTable()
            }
            
        }
        
    }
    
    
    func reloadTable(){
        
        self.filmList.tblList.reloadData()
        self.filmList.calculateTableHeight(time: 0, navBarHeigth: nil) {}
        
    }
    
    
    
    
   func updateViewConstraints(myView: UIView) {
       
       myView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
       myView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       myView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
       myView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
       
   }
   
    
    func backToNowPlayingFilm(){
        
        isFilmQuery = false
        webFilm.removeAll()
        webFilm.append(contentsOf: webFilmProxy.nowPlayingWebFilm)
        loadNowPlayingFilm()
        
        guard let visibleRows = filmList.tblList.indexPathsForVisibleRows, let row = visibleRows.first else{
            return
        }
        
        filmList.tblList.scrollToRow(at: row, at: .top, animated: true)
        
    }
    
}

    

extension FilmListViewController: FilmWebProtocol {
    
    
    
    func emptyValueAppeared() {
        
        if !isFilmQuery{
            loadNowPlayingFilm()
        }else{
            loadSearchMovie(query: webFilmProxy.searchMovieQuery)
        }
    }
    
    
    func setFavourite(aWebFilm: WebFilm) {
        
        guard let index = webFilm.firstIndex(of: aWebFilm) else {return}
        
        webFilm[index].favourie = aWebFilm.favourie
        
        filmList.tblList.reloadData()
        
        
        webFilmProxy.modifyFavouriteFilm(aFilm: webFilm[index] )
        
    }
    
}




extension FilmListViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var rowCount = webFilm.count
        
        
        if webFilm.count > 0 && self.hasNextPage {
            rowCount += 1
        }
        
        return rowCount
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FilmListTableViewCell.CELLID) as? FilmListTableViewCell else{
            fatalError("Cell is not FilmListTableViewCell type")
        }
        
        cell.delegate = self
        
        let row = indexPath.row
        
        if row < webFilm.count {
            cell.webFilm = self.webFilm[row]
        }else{
            cell.webFilm = nil
        }
        
        return cell
    }
    
    
}


extension FilmListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let filmDetails = FilmDetailsViewController()
        
        filmDetails.webFilm = self.webFilm[ indexPath.row ]
        filmDetails.delegate = self
        
        self.navigationController?.pushViewController(filmDetails, animated: true)
        
        
    }
    
    
    
    
}

extension FilmListViewController: UISearchResultsUpdating{
    

    func updateSearchResults(for searchController: UISearchController) {
        
        // Strip out all the leading and trailing spaces.
        let whitespaceCharacterSet = CharacterSet.whitespaces
        let strippedString = searchController.searchBar.text!.trimmingCharacters(in: whitespaceCharacterSet)
        
        let query = strippedString
        
        print("query: \(query)")
        
        if query.count > 0 {
            isFilmQuery = true
            loadSearchMovie(query: query)
            
        }else{
            backToNowPlayingFilm()
        }
        
    }
    
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        print("editing")
        
        let visibleRow = filmList.tblList.indexPathsForVisibleRows
            
        if visibleRow != nil &&  visibleRow!.count > 0 {
            
            filmList.tblList.scrollToRow(at: visibleRow![0], at: .top, animated: true)
        }
        
        return true
    }
    
    
    
}


extension FilmListViewController: UISearchBarDelegate {
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        print("cancel button clicked")
        //self.close()
        
        backToNowPlayingFilm()
        
    }
    
    
    
}
