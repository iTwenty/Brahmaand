//
//  SettingsViewController.swift
//  Brahmaand
//
//  Created by jaydeep on 08/05/21.
//

import UIKit
import Kingfisher

class SettingsViewController: UIViewController {

    @IBOutlet weak var settingsTableView: UITableView!

    private var imageCacheSizeString = "-" {
        didSet {
            self.settingsTableView.reloadRows(at: [IndexPath(row: 0, section: 0)], with: .none)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        settingsTableView.dataSource = self
        settingsTableView.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        calculateImageDiskCacheSize()
    }

    private func calculateImageDiskCacheSize() {
        imageCacheSizeString = "-"
        KingfisherManager.shared.cache.calculateDiskStorageSize { [weak self] (result) in
            switch result {
            case .success(let sizeBytes):
                self?.imageCacheSizeString = ByteCountFormatter.string(fromByteCount: Int64(sizeBytes), countStyle: .binary)
            case .failure(let error):
                print("Failed to get image cache disk size : \(error.localizedDescription)")
            }
        }
    }
}

extension SettingsViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        2
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingsCell.reuseId, for: indexPath) as! SettingsCell
        switch indexPath.row {
        case 0:
            cell.title = "Clear image cache"
            cell.subtitle = imageCacheSizeString
        case 1:
            cell.title = "Clear all data"
            cell.subtitle = nil
        default:
            fatalError("No settings cell to dequeue for row index : \(indexPath.row)!")
        }
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
         case 0:
            KingfisherManager.shared.cache.clearDiskCache { [weak self] in
                self?.calculateImageDiskCacheSize()
            }
        case 1:
            print("Did click clear all data")
        default:
            fatalError("No settings cell to dequeue for row index : \(indexPath.row)!")
        }
    }
}
