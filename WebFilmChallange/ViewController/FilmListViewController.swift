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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .red
        
        filmList = FilmListView()
        self.title = NSLocalizedString("FILM_LIST_WINDOW_TITLE", comment: "Lism list")
        filmList.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(filmList)
        updateViewConstraints(myView: filmList)
        self.filmList.tblList.register(FilmListTableViewCell.self, forCellReuseIdentifier: FilmListTableViewCell.CELLID)
        
        
        // Do any additional setup after loading the view.
    }
    

   func updateViewConstraints(myView: UIView) {
       
       myView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
       myView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
       myView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
       myView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
       
   }
    
    
    

}


/*
 class ListViewController: UIViewController {

     var listView: ListView!
     var shoppingList: [ShoppingList] = []
     var store: PersistentGroceryStore?
     let transition = PopAnimator()
     var showAnimation = false
     
     
     
     
     override func viewDidLoad() {
         super.viewDidLoad()
         
         store = PersistentGroceryStore.shared
         
         listView = ListView()
         
         self.title = NSLocalizedString("LIST_TITLE", comment: "")
         listView.translatesAutoresizingMaskIntoConstraints = false
         
         self.view.addSubview(listView!)
         updateViewConstraints(view: self.view)
         self.listView.tblList.register(ListTableViewCell.self, forCellReuseIdentifier: ListTableViewCell.CELLID)
         self.listView.tblList.dataSource = self
         self.listView.tblList.delegate = self
         self.listView.tblList.isHidden = true
         
         
         self.listView.btnAddList.addTarget(self, action: #selector(addButtonPressed(_:)), for: .touchUpInside)
         self.listView.btnShowHistory.addTarget(self, action: #selector(showHistoryButtonPressed(_:)), for: .touchUpInside)
         
         transition.dismissCompletion = { [weak self] in
             guard
                 let selectedIndexPathCell = self?.listView.tblList.indexPathForSelectedRow,
                 let selectedCell = self?.listView.tblList.cellForRow(at: selectedIndexPathCell) as? ListTableViewCell
                 else {
                     return
             }
             
             //selectedCell.shadowView.isHidden = false
         }
         
         setupGesturRecognizer()
         
     }
     
     override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
     
         //hide buttons before animation only when list is empty
         if self.shoppingList.count == 0 {
             self.listView.btnShowHistory.isHidden = true
             self.listView.btnAddList.isHidden = true
         }
         
         self.tabBarController?.tabBar.isHidden = false
         loadData(){
             UIView.transition(with: self.listView.tblList, duration: AppConstants.LIST_ARCHIVE_DETAILS_OPTION_ANIMATION_TIME, options: .transitionCrossDissolve, animations: {
                 self.listView.tblList.isHidden = false
             }, completion: { (_) in
                 
             })
             
         }
         
     }
     
     override func viewDidAppear(_ animated: Bool) {
         super.viewDidAppear(animated)
         
         
         listView.calculateTableHeight(time: 0, navBarHeigth: calculateTabBarHeigth() ) { [weak self] in
             guard let self = self else {return}
             if self.shoppingList.count == 0{
                 self.listView.initiateAnimation(duration: 0.7, shift: 0.35, fade: 0.3, historyCompletion: { [weak self] in
                     self?.listView.btnShowHistory.isHidden = false
                 }) { [weak self] in
                     self?.listView.btnAddList.isHidden = false
                     self?.listView.lblWelcome.isHidden = false
                 }
             }else{
                 self.listView.btnShowHistory.isHidden = false
                 self.listView.btnAddList.isHidden = false
             }
             
         }
         refreshListPercentage()
         
         self.showAnimation = true
         
         
     }
     
     override func viewDidDisappear(_ animated: Bool) {
         super.viewDidDisappear(animated)
         
         if let cells = self.listView?.tblList?.visibleCells as? [ListTableViewCell] {
             for cell in cells {
                 cell.btnSummary.isHidden = true
                 
             }
         }
     }
     
     override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
         super.traitCollectionDidChange(previousTraitCollection)
         
         if #available(iOS 13.0, *) {
             guard UIApplication.shared.applicationState == .inactive else {
                 return
             }
             if let delegate = UIApplication.shared.delegate as? AppDelegate{
                 delegate.createMenu()
                 delegate.tabBarController!.selectedIndex = 0
                 //print("traitCollectionDidChange prev \(previousTraitCollection?.userInterfaceStyle.rawValue) current  \(traitCollection.userInterfaceStyle.rawValue) ")
             }
         }
         
     }
     
     func setupGesturRecognizer(){
         
         let gesture = UITapGestureRecognizer(target: self, action: #selector(repondToTapGesture(_:)))
         gesture.cancelsTouchesInView = false
         gesture.delegate = self
         self.view.addGestureRecognizer(gesture)
         
     }
     
     
     func refreshListPercentage(){
         
         if let cells = self.listView.tblList.visibleCells as? [ListTableViewCell] {
             for cell in cells {
                 cell.btnSummary.isHidden = false
                 cell.setListPercentage()
             }
         }
         
     }
     
     
     func calculateTabBarHeigth() -> CGFloat{
         
         
         if self.navigationController?.navigationBar != nil {
             AppVariables.shared.navBarHeight = self.navigationController!.navigationBar.frame.size.height
             if !(UIDevice.current.orientation == .landscapeLeft) && !(UIDevice.current.orientation == .landscapeRight) {
                 AppVariables.shared.navBarHeight += 20
             }
             //print("app Variable navBarHeight: \(AppVariables.shared.navBarHeight)")
         }
         
         return AppVariables.shared.navBarHeight
     }
     
     
     
     func updateViewConstraints(view: UIView) {
         
         listView?.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
         listView?.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
         listView?.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
         listView?.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
         
     }
     
     
     
     
     @objc func addButtonPressed(_ button: UIButton?){
         
         let newList = AddListViewController()
         newList.listOperation = self
         newList.transitioningDelegate = self
         
         /*guard let presentation = self.navigationController?.presentationController else { return }
         
         presentation.delegate = newList
         */
         self.present(newList, animated: true, completion: {} )

         
     }
     
     @objc func showHistoryButtonPressed(_ button: UIButton?){
         
         let archiveList = ListArchiveViewController()
         self.navigationController?.pushViewController(archiveList, animated: self.showAnimation)
         
     }
     
     
     
     public func loadData( _ completion: @escaping () -> Void ){
         
         do {
             
             if store != nil {
                 shoppingList = try store!.getActiveList()
             }
         }catch let error as NSError {
             print("Problem load data: \(error.userInfo)")
         }
         
         
         listView.lblWelcome.isHidden = !(shoppingList.count == 0)
         listView.calculateTableHeight(time: 0, navBarHeigth: calculateTabBarHeigth() ) {
             completion()
         }
         
     }
     
     @objc func repondToTapGesture(_ gesture: UITapGestureRecognizer){
         
        
         if let cells = self.listView.tblList.visibleCells as? [ListTableViewCell] {
             for cell in cells{
                 if cell.lastXPosition != 0 {
                     cell.setLabelsConstraint(moveBy: 0, time: AppConstants.LIST_DETAILS_ANIMATION_TIME, isEditHidden: false)
                     cell.lastXPosition = 0
                 }
             }
             
             
             var wasEditMode = false
             for cell in cells{
                 if cell.isEditModeEnabled {
                     cell.isEditMode(false)
                     wasEditMode = true
                 }
             }
             if wasEditMode {
                 loadData {}
             }
         }
     }
     
     
 }

 extension ListViewController: UIGestureRecognizerDelegate {
         
     func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
         if touch.view!.isDescendant(of: self.listView.tblList) {
             return false
         }
         return true
     }
     
     
 }


 extension ListViewController: UITableViewDataSource {
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return shoppingList.count
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
         guard let cell = tableView.dequeueReusableCell(withIdentifier: ListTableViewCell.CELLID, for: indexPath) as? ListTableViewCell else {
             fatalError("cell \(ListTableViewCell.CELLID) is not ListTableViewCell")
         }
         
         let element = shoppingList[(indexPath as NSIndexPath).row]
         cell.aList = element
         do{
             cell.aShoppingListProduct = try store?.findShoppingListProductFor(shoppingList: element)
         }catch let error as NSError {
             print( "ListViewController.tableView: Cannto load shoppingListProduct: \(error)" )
         }
     
         cell.listOperation = self
         cell.setupCell()
         cell.setListPercentage()

         return cell
         
     }
     
     
     func removeElement(element: ShoppingList){
         
         var idx = 0
         
         for elem in self.shoppingList {
             
             if elem.id == element.id{
                 self.shoppingList.remove(at: idx)
             }
             
             idx += 1
             
         }
         
     }
     
     func getIndex(_ of: ShoppingList) -> Int{
         
         
         var idx = 0
         
         for elem in self.shoppingList {
             
             if elem.id == of.id{
                 return idx
             }
             
             idx += 1
             
         }
         //print("ListViewController.getIndex: index: \(idx)")
         return idx
     }
     
     
 }

 extension ListViewController: UITableViewDelegate {
     
     
     func scrollViewDidScroll(_ scrollView: UIScrollView) {
             
         let offset = listView.tblList.contentOffset.y
         
         if offset > 10 {
             let newOffset = (offset - 10) / 1.5
             let transform = CGAffineTransform(translationX: 0, y: newOffset)
             listView.btnAddList.transform = transform
             listView.btnShowHistory.transform = transform
             
         }else{
             listView.btnAddList.transform = .identity
             listView.btnShowHistory.transform = .identity
         }
     }
     
     
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         
         
         var isEditing = false
         var isMoved = false
         var cells: [ListTableViewCell] = []
         
         if let _cells = tableView.visibleCells as? [ListTableViewCell] {
             cells.append(contentsOf: _cells)
             
             for cell in cells{
                 if cell.isEditModeEnabled {
                     isEditing = true
                 }else if cell.lastXPosition != 0 {
                     isMoved = true
                 }
             }
         }
         
         if isEditing {
             for cell in cells{
                 cell.isEditMode(false)
             }
             loadData {}
             return
         }
         
         if isMoved {
             for cell in cells{
                 if cell.lastXPosition != 0 {
                     cell.setLabelsConstraint(moveBy: 0, time: AppConstants.LIST_DETAILS_ANIMATION_TIME, isEditHidden: false)
                     cell.lastXPosition = 0
                 }
             }
             return
         }
         
         
         //if !cell.restoreCentralPosition() {
         print( "ListViewController.didSelectRowAt" )
         let listDetails = ListDetailsViewController()
         listDetails.store = self.store
         listDetails.shoppingList = self.shoppingList[ indexPath.row ]
         listDetails.navigateToScannerProtocol = self
         listDetails.listOperation = self
             
         self.navigationController?.pushViewController(listDetails, animated: self.showAnimation)
         //}
     }
     
     
 }


 extension ListViewController: ListOperationProtocol {
     
     
     func setReadMode(listElement: ShoppingList) {
         
     }
     
     
     func addShoppingList() {
         
         loadData(){ [weak self] in
             self?.refreshListPercentage()
         }
         
     }
     
     func setEditMode(listElement: ShoppingList) {
         
         let currentIndex = getIndex(listElement)
         let currentIndexPath = IndexPath(row: currentIndex, section: 0)
         
         let selected = self.listView.tblList.indexPathsForSelectedRows
         
         if selected != nil {
             
             for row in selected! {
                 self.listView.tblList.deselectRow(at: row, animated: false)
             }
         }
         
         self.listView.tblList.selectRow(at: currentIndexPath, animated: false, scrollPosition: .none)
         
         //disable endit mode if is present in others
         if let idxForCells = self.listView.tblList.indexPathsForVisibleRows{
         
             for indexPath in idxForCells {
                 
                 if let listCell = self.listView.tblList.cellForRow(at: indexPath) as? ListTableViewCell {
                 
                     if !(indexPath.row == currentIndexPath.row && indexPath.section == currentIndexPath.section) {
                         listCell.isEditMode(false)
                         listCell.setListPercentage()
                     }
                 }
             }
         }
         
     }
     
     func deleteElement(_ element: ShoppingList, delay: Double) {
         
         do {
             
             _ = try store?.archiveList(listId: [ element.id ] )
             
             let currentIndex = getIndex(element)
             let currentIndexPath = IndexPath(row: currentIndex, section: 0)
             
             guard let currentCell = self.listView.tblList.cellForRow(at: currentIndexPath) as? ListTableViewCell else { return }
             
             let cellHeight = currentCell.cellHeigthConstraint.constant
             
             guard var visibleCellIndex = self.listView.tblList.indexPathsForVisibleRows else{ return }
             let maxIndex = visibleCellIndex.max()?.row
             
             if !visibleCellIndex.isEmpty  && maxIndex != nil {
                 visibleCellIndex.append(IndexPath(row: maxIndex! + 1, section: 0))
                 visibleCellIndex.removeFirst(currentIndex)
             }
             
             currentCell.cellHeigthConstraint.constant = 0
             UIView.animate(withDuration: 0.3){ [unowned self] in
                 self.listView.tblList.layoutIfNeeded()
                 self.view.layoutIfNeeded()
                 
             }
             
             Timer.scheduledTimer(withTimeInterval: delay, repeats: false){ [unowned self] _ in
             
                 for indexPath in visibleCellIndex {
                     
                     let cell = self.listView.tblList.cellForRow(at: indexPath)
                     
                     if cell != nil {
                     
                         UIView.animate(withDuration: 0.3){
                             cell!.transform = CGAffineTransform(translationX: 0, y: -cellHeight)
                             
                         }
                     }
                     
                 }
                 
             }
         
             Timer.scheduledTimer(withTimeInterval: 0.3 + delay, repeats: false) { [unowned self] _ in
                 currentCell.setLabelsConstraint(moveBy: 0)
                 
                 self.removeElement(element: element)
                 self.listView.calculateTableHeight(time: 0, navBarHeigth: self.calculateTabBarHeigth() ) {}
                 self.listView.lblWelcome.isHidden = !(self.shoppingList.count == 0)
                 
             }
             
             
             
         }catch let error as NSError {
             print( "ListViewController.deleteElement: \(error)" )
         }
         
         
     }
     
     func saveShoppingList(listElement: ShoppingList){
         
         do {
             try store?.save()
         }catch let error as NSError {
             print( "ListViewController.saveShoppingList: \(error)" )
         }
         
     }
     
     func cellInMovedPosition(listElement: ShoppingList) {
         
         let currentIndex = getIndex(listElement)
         let currentIndexPath = IndexPath(row: currentIndex, section: 0)
         
         guard let allCells = self.listView.tblList.visibleCells as? [ListTableViewCell] else { return }
         
         for cell in allCells {
             //print( cell.aList?.name )
             
             guard let indexPath = self.listView.tblList.indexPath(for: cell) else{ return }
             
             if indexPath.row != currentIndexPath.row {
                 cell.setLabelsConstraint(moveBy: 0, time: AppConstants.LIST_DETAILS_ANIMATION_TIME, isEditHidden: false)
                 cell.lastXPosition = 0
             }
             
         }
         
     }
     
 }


 extension ListViewController: NavigateToScannerProtocol{
     
     func showScanner() {
         self.navigationController?.popToRootViewController(animated: false)
         self.tabBarController?.selectedIndex = 1
     }
     
 }

 extension ListViewController: UIViewControllerTransitioningDelegate {
     
     
     func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
         
         
         
         guard let lblDummy = self.listView.lblDumyForPopapOnly,
             let lblDummySuperview = lblDummy.superview
             else {
                 return nil
         }
         
         transition.originFrame = lblDummySuperview.convert(lblDummy.frame, to: nil)
         
         /*transition.originFrame = CGRect(
             x: transition.originFrame.origin.x,
             y: transition.originFrame.origin.y,
             width: transition.originFrame.size.width,
             height: transition.originFrame.size.height
         )*/
         
         
         transition.presenting = true
         
         return transition
     }
     
     func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
         transition.presenting = false
         return transition
     }
 }


 */
