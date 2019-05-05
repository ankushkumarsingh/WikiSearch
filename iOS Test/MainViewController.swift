//
//  MainViewController.swift
//  iOS Test
//
//  Created by Deniz Aydemir on 8/22/16.
//  Copyright © 2016 Castle. All rights reserved.
//

import UIKit
import ObjectMapper
import Kingfisher

class MainViewController: UIViewController {
    
    @IBOutlet weak var resultTableView: UITableView!
    
    //let searchField = UISearchBar()
    lazy var searchField = UISearchBar(frame: CGRect(x:CGFloat(SEARCH_BAR_X_POSITION), y:CGFloat(SEARCH_BAR_Y_POSITION), width:UIScreen.main.bounds.size.width - CGFloat(SEARCH_BAR_PADDING), height:CGFloat(SEARCH_BAR_HEIGHT)))

    var searchResults = [Page]()
    var searchActive = false
    var searchQuery = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.addSubview(self.searchField)
//        self.searchField.translatesAutoresizingMaskIntoConstraints = false
//        self.view.addConstraints([
//            NSLayoutConstraint(item: self.searchField, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1, constant: 0),
//            NSLayoutConstraint(item: self.searchField, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0),
//            NSLayoutConstraint(item: self.searchField, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1, constant: 20),
//            NSLayoutConstraint(item: self.searchField, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 44)
//        ])
        searchField.placeholder = PLACEHOLDER_TEXT
        searchField.searchBarStyle = .minimal
        searchField.delegate = self
        //searchField.showsCancelButton = true

        let leftNavBarButton = UIBarButtonItem(customView:searchField)
        self.navigationItem.leftBarButtonItem = leftNavBarButton
//        resultTableView.estimatedRowHeight = 75.0
//        resultTableView.rowHeight = UITableViewAutomaticDimension
    }

    override func viewWillAppear(_ animated: Bool) {

        UIApplication.shared.statusBarStyle = UIStatusBarStyle.lightContent

    }

    deinit {
        print("MainViewController view deallocated")
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateSearch(query:String){
        let searchService = WikiSearchService()
        searchService.delegate = self
        searchService.getSearchResults(searchText: query)
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SEAGUE_IDENTIFIER,
            let controller = segue.destination as? SearchDetailsViewController,
            let tableViewCell = sender as? WikiPediaResultTableViewCell,
            let selectedIndex = resultTableView.indexPath(for: tableViewCell)?.row {
            let data = searchResults[selectedIndex]
            controller.data = data
        }
    }
}

extension MainViewController : UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }



    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let resultCell = tableView.dequeueReusableCell(withIdentifier: CELL_IDENTIFIER, for: indexPath as IndexPath) as? WikiPediaResultTableViewCell else {
            return UITableViewCell()
        }

        let data = searchResults[indexPath.row]

        if let thumbnail = data.thumbnail {

            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 0, animations: {
                resultCell.imageHeight.constant = CGFloat(thumbnail.height)
                resultCell.imageWidth.constant = CGFloat(thumbnail.width)
                self.view.layoutIfNeeded()
            })

            let imageUrl = URL(string: thumbnail.source)
            resultCell.resultImage.kf.setImage(with: imageUrl,
                                               placeholder:UIImage(named: PLACEHOLDER_LOADING ),
                                               options: [.transition(.fade(1))],
                                               progressBlock: nil,
                                               completionHandler: nil)
        }

        resultCell.resultTitle.text = data.title
        resultCell.resultSubTitle.text = data.extract


        return resultCell

    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let resultCell = resultTableView.cellForRow(at: indexPath) as! WikiPediaResultTableViewCell
        performSegue(withIdentifier: SEAGUE_IDENTIFIER, sender: resultCell)
    }
}

extension MainViewController : UITableViewDelegate {
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat{
        return CGFloat(MINIMUM_HEIGHT)
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        let data = searchResults[indexPath.row]

        guard let height = data.thumbnail?.height else {
            return CGFloat(MINIMUM_HEIGHT)
        }

        if height <= MINIMUM_HEIGHT {
            return CGFloat(MINIMUM_HEIGHT)
        }

      return UITableView.automaticDimension
    }
}

extension MainViewController : UISearchBarDelegate {
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchActive = true
        return true
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {

        searchActive = true
    }

    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        dismiss(animated: true, completion: nil)
        searchActive = false
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        searchQuery = searchText
        updateSearch(query:searchQuery)
    }
}

extension MainViewController : WikiResponseDelegate {
    func search(sender: WikiSearchService ,searchResults response: WikiResponseModel?){
        guard let response = response else {
            return
        }

        guard let results = response.query?.pages else {
            return
        }

        self.searchResults = Array(results.values)
        print(searchResults)

        DispatchQueue.main.async {
            self.resultTableView.reloadData()
        }

    }
}
