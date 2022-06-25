//
//  ViewController.swift
//  Assignment
//
//  Created by Nitin on 22/06/22.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var moviesCollectionView: UICollectionView!
    @IBOutlet var noMovieLbl: UILabel!
    private var pageNo = 1
    private var searchText = ""
    
    private var movieListVM = MoviewListVM()
    private var searchResults = [Search]()
    private var sortType = Sort.descending
    private let noOfCells:CGFloat = 2
    private var totalRecords = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moviesCollectionView.isHidden = false
        setupBarButtonItem()
        
        self.setCollectionViewLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    private func callApiToGetMovies(_ searchStr:String,page:Int) {
        if appDel.isReachable {
            if searchStr.count > 0,
               page == self.pageNo {
                addLoader("Fetching Movies",self)
                movieListVM.callFuncToGetMoviewList(getSearchUrl(searchStr, page)) { movies, error in
                    if error == nil,
                       let movieList = movies {
                        self.getDataAndReload(movieList)
                    } else {
                        self.performError(error: error)
                    }
                }
            }
        } else {
            AlertController.alert(target:self,title: "Assignment", message: NO_INTERNET_CONNECTION,buttons: ["Ok","Retry"]) { alert, selectedIndex in
                if selectedIndex == 1 {
                    self.callApiToGetMovies(self.searchText, page: self.pageNo)
                }
            }
        }
    }
        
    private func performError(error: Error?) {
        hideLoader(self)
        AlertController.alert(target:self,title: "Error", message: error?.localizedDescription ?? "", buttons: ["Ok","Retry"]) { alert, selectedIndex in
            if selectedIndex == 1 {
                self.callApiToGetMovies(self.searchText, page: self.pageNo)
            }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchedText = searchBar.text else { return }
        if searchedText.count >= 3,
           searchedText != searchText {
            self.pageNo = 1
            self.searchResults.removeAll()
            self.view.endEditing(true)
            self.callApiToGetMovies(searchedText, page: pageNo)
            self.pageNo += 1
            searchText = searchedText
        } else {
            if searchedText.count < 3 {
                AlertController.alert(message: "Please type atleast 3 characters of movie.")
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.searchText = searchText
            }
        }
    }
        
    private func setupBarButtonItem() {
        
        let sortBtn = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(didTapSortButton(sender:)))
        navigationItem.rightBarButtonItems = [sortBtn]
    }
    
    @objc
    private func didTapSortButton(sender: AnyObject) {
        AlertController.actionSheet(title: "Assignment",
                                    message: "Sort Movies by",
                                    sourceView: self.view,
                                    buttons: ["Year Old-Recent",
                                              "Year Recent-Old",
                                              "Cancel"]) { alert, selectedIndex in
            self.sortType = selectedIndex
            self.sortData(sort: selectedIndex)
        }
    }
    
    
    private func sortData(sort:Int) {
        if sort == Sort.ascending {
            let sortedMovies = self.searchResults.sorted { $0.year < $1.year}
            self.searchResults = sortedMovies
            self.moviesCollectionView.reloadData()
        } else if sort == Sort.descending {
            let sortedMovies = self.searchResults.sorted { $0.year > $1.year}
            self.searchResults = sortedMovies
            self.moviesCollectionView.reloadData()
        }
    }
    
    private func sortWithKeys(_ dict: [String: Any]) -> [String: Any] {
        let sorted = dict.sorted(by: { $0.key < $1.key })
        var newDict: [String: Any] = [:]
        for sortedDict in sorted {
            newDict[sortedDict.key] = sortedDict.value
        }
        return newDict
    }
}

extension ViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func setCollectionViewLayout() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let screenSize = UIScreen.main.bounds
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        let width = (screenSize.width/noOfCells) - 30
        let height = 230.0
        
        layout.itemSize = CGSize(width: width, height: height)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 20
        moviesCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchResults.count
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCollectionViewCell", for: indexPath) as! MovieCollectionViewCell
        self.view.endEditing(true)
        cell.configureCell(searchResults[indexPath.row])
        fetchMoreMovies(indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.view.endEditing(true)
        let movieId = searchResults[indexPath.row].imdbID
        if let mId = movieId {
            let movieDetail = StoryBoards.main.instantiateViewController(identifier: StoryBoardId.movieDetail) as MovieDetailVC
            movieDetail.movieId = mId
            movieDetail.posterImg = (collectionView.cellForItem(at: indexPath) as! MovieCollectionViewCell).posterImgVw.image
            self.navigationController?.pushViewController(movieDetail, animated: true)
        }
    }
}

extension ViewController {
    func getDataAndReload(_ movieListModel:MoviesList) {
        hideLoader(self)
        searchResults.append(contentsOf: movieListModel.search)
        
        if let rec = movieListModel.totalResults {
            totalRecords = Int(rec) ?? 0
        }
                
        if movieListModel.search.count == 0,
           searchResults.count == 0 {
            noMovieLbl.isHidden = false
        } else {
            noMovieLbl.isHidden = true
        }
        
        
        self.sortData(sort: sortType)
        moviesCollectionView.reloadData()
    }

    fileprivate func fetchMoreMovies(_ indexPath: IndexPath) {
        if indexPath.row == searchResults.count - 1 {
            if totalRecords > searchResults.count {
                self.callApiToGetMovies(searchText, page: pageNo)
                self.pageNo += 1
            }
        }
    }
}
