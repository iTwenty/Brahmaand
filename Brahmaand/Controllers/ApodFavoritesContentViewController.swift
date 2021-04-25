//
//  ApodFavoritesViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 24/04/21.
//

import UIKit

class ApodFavoritesContentViewController: UIViewController {

    @IBOutlet weak var apodFavoritesCollectionView: UICollectionView!
    var favoriteApods: [Apod] = [] {
        didSet {
            apodFavoritesCollectionView.reloadData()
        }
    }

    static func fromStoryBoard(apods: [Apod]) -> ApodFavoritesContentViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        let vc: ApodFavoritesContentViewController = sb.instantiateViewController(identifier: "ApodFavoritesContentViewController")
        vc.favoriteApods = apods
        return vc
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let apodCellNib = UINib(nibName: "ApodCell", bundle: nil)
        apodFavoritesCollectionView.register(apodCellNib, forCellWithReuseIdentifier: ApodCell.reuseIdentifier)
        apodFavoritesCollectionView.dataSource = self
    }
}


extension ApodFavoritesContentViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteApods.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApodCell.reuseIdentifier, for: indexPath) as! ApodCell
        let apod = favoriteApods[indexPath.row]
        cell.apodTitle = apod.title
        cell.apodDate = apod.date
        if apod.mediaType == .image {
            cell.apodImageUrl = apod.url
        }
        return cell
    }
}
