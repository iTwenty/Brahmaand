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
            apodFavoritesCollectionView?.reloadData()
        }
    }

    private var itemsPerRow = 1 {
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
        apodFavoritesCollectionView.delegate = self
        updateItemsPerRow()
    }

    override func didMove(toParent parent: UIViewController?) {
        super.didMove(toParent: parent)
        // Need to access navigation item via parent since this VC is embedded inside fav container VC
        parent?.navigationItem.title = "Favorites"
        // parent?.navigationItem.rightBarButtonItem = editButtonItem
    }

    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        // TODO : set collection view editing mode
    }

    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        updateItemsPerRow()
    }

    private func updateItemsPerRow() {
        if traitCollection.horizontalSizeClass == .compact {
            itemsPerRow = 1
        } else {
            itemsPerRow = 2
        }
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

extension ApodFavoritesContentViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedApod = favoriteApods[indexPath.row]
        ApodNavigator.shared.pushApodContentViewController(apod: selectedApod, presenter: self)
    }
}

extension ApodFavoritesContentViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = 8
        let totalSpacing = (2 * spacing) + ((itemsPerRow - 1) * spacing)
        let width = (Int(collectionView.bounds.width) - totalSpacing) / itemsPerRow
        return CGSize(width: width, height: width)
    }
}
