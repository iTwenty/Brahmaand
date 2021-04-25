//
//  ApodFavoritesViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 24/04/21.
//

import UIKit

class ApodFavoritesContentViewController: UIViewController {

    @IBOutlet weak var apodFavoritesCollectionView: UICollectionView!

    static func fromStoryBoard() -> ApodFavoritesContentViewController {
        let sb = UIStoryboard(name: "Main", bundle: .main)
        let vc: ApodFavoritesContentViewController = sb.instantiateViewController(identifier: "ApodFavoritesContentViewController")
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
        return 5
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ApodCell.reuseIdentifier, for: indexPath) as! ApodCell
        cell.apodTitle = "First you look so strong. Then you fade away"
        cell.apodDate = Date()
        cell.apodImageUrl = URL(string: "https://apod.nasa.gov/apod/image/2104/ant_hubble_1072.jpg")
        return cell
    }
}
