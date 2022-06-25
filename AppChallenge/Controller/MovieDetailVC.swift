//
//  MovieDetailVC.swift
//  Assignment
//
//  Created by Nitin on 22/06/22.
//

import UIKit

class MovieDetailVC: UIViewController {
    
    @IBOutlet var movieDetailTableView: UITableView!
    @IBOutlet var posterImgView: UIImageView!
    
    private var movieDetailVM = MovieDetailVM()
    private var movieDetailObj: MoviesDetail?
    
    var movieId = ""
    var posterImg: UIImage?
    
    @IBOutlet var titleLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchMovieDetail()
        if let img = posterImg {
            self.posterImgView.image = img
            self.posterImgView.contentMode = .scaleAspectFit
        }
    }
    
    func fetchMovieDetail() {
        if ConnectionManager.sharedInstance.isReachable {
            showLoader()
            movieDetailVM.callFuncToGetMoviewDetail(getMovieDetailUrl(movieId)) { movieDetailObj, error in
                self.removeLoader()
                if error == nil {
                    self.titleLbl.text = movieDetailObj?.title
                    self.movieDetailObj = movieDetailObj!
                    if let posterUrl = movieDetailObj?.poster {
                        if self.posterImg == nil {
                            self.posterImgView.imageFromServerURL(posterUrl, placeHolder: nil,contMode: .scaleAspectFit)
                        }
                    }
                    self.movieDetailTableView.reloadData()
                } else {
                    self.removeLoader()
                    AlertController.alert(target:self,title: "Error", message: error?.localizedDescription ?? "", buttons: ["Ok","Retry"]) { alert, selectedIndex in
                        if selectedIndex == 1 {
                            self.fetchMovieDetail()
                        }
                    }
                }
            }
        } else {
            AlertController.alert(target:self,title: "Assignment", message: NO_INTERNET_CONNECTION,buttons: ["Ok","Retry"]) { alert, selectedIndex in
                if selectedIndex == 1 {
                    self.fetchMovieDetail()
                }
            }
        }
    }
}

extension MovieDetailVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieDetailTableCell", for: indexPath) as! MovieDetailTableCell
        
        getCellData(indexPath, cell)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    fileprivate func getCellData(_ indexPath: IndexPath, _ cell: MovieDetailTableCell) {
        switch indexPath.row {
        case 0:
            cell.movieProperty.attibutedString("Genre ", self.movieDetailObj?.genre ?? "N/A")
        case 1:
            cell.movieProperty.attibutedString("Plot ", self.movieDetailObj?.plot ?? "N/A")
        case 2:
            cell.movieProperty.attibutedString("Language ", self.movieDetailObj?.language ?? "N/A")
        case 3:
            cell.movieProperty.attibutedString("Year ", self.movieDetailObj?.year ?? "N/A")
        case 4:
            cell.movieProperty.attibutedString("Stars ", self.movieDetailObj?.actors ?? "N/A")
        case 5:
            if let rating = self.movieDetailObj?.ratings,
               rating.count > 0 {
                cell.movieProperty.attibutedString("OMDB Rating ", (self.movieDetailObj?.ratings[0].value ?? "N/A")+"\n" + (self.movieDetailObj?.ratings[0].source ?? ""))
            } else {
                cell.movieProperty.attibutedString("OMDB Rating ","N/A")
            }
        case 6:
            if self.movieDetailObj?.type == "movie" {
                cell.movieProperty.attibutedString("Type ", self.movieDetailObj?.type ?? "N/A")
            } else {
                cell.movieProperty.attibutedString("Type ", (self.movieDetailObj?.type ?? "N/A")+"\n" + "Seasons "+(self.movieDetailObj?.totalSeasons ?? ""))
            }
        case 7:
            cell.movieProperty.attibutedString("Writters ", self.movieDetailObj?.writer ?? "N/A")
        case 8:
            cell.movieProperty.attibutedString("Director ", self.movieDetailObj?.director ?? "N/A")
        case 9:
            cell.movieProperty.attibutedString("Awards ", self.movieDetailObj?.awards ?? "N/A")
        default:
            print("")
        }
    }
}
