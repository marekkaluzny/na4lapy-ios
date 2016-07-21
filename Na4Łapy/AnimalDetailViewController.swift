//
//  AnimalDetailViewController.swift
//  Na4Łapy
//
//  Created by mac on 09/07/2016.
//  Copyright © 2016 Koduj dla Polski. All rights reserved.
//

import UIKit

class AnimalDetailViewController: UIViewController {

    var animal: Animal!
    private var animalPhotos: [Photo]!
    private var footer:AnimalDetailPhotosCollectionFooter!
    private var collapsing = false

    @IBOutlet weak var animalCenterCircularPhoto: UIImageView!
    @IBOutlet weak var animalBackgroundPhoto: UIImageView!
    
    @IBOutlet weak var animalPhotoCollection: UICollectionView!
    

    @IBAction func toggleMoreDescription(sender: AnyObject) {

        collapsing = !collapsing
        
        animalPhotoCollection.reloadData()

    }

    private struct Storyboard {
        static let CellIdentifier = "AnimalPhotoCell"
        static let FooterIdentifier = "AnimalDetailsCollectionFooter"
    }
    
    override func viewDidLoad() {
        animalPhotoCollection.dataSource = self
        super.viewDidLoad()

        }
    
    override func viewDidLayoutSubviews() {
        animalPhotos = animal.getAllImages()
        updateUI()
    }
    
    func updateUI() {
        self.navigationItem.title = animal.getAgeName()
    
        animalPhotoCollection.reloadData()
        
        animalCenterCircularPhoto.image = animalPhotos.first?.image?.circle
        animalCenterCircularPhoto.clipsToBounds = true
        animalBackgroundPhoto.image = animalPhotos.first?.image
        
    }
}


extension AnimalDetailViewController: UICollectionViewDataSource {
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return animalPhotos.count
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {

        if let cell = collectionView.dequeueReusableCellWithReuseIdentifier(Storyboard.CellIdentifier,
                forIndexPath: indexPath) as? AnimalPhotoCell {
                    cell.animalImage.image = animalPhotos[indexPath.item].image

                return cell
            }
        return UICollectionViewCell()
    }

    func collectionView(collectionView: UICollectionView,
                        viewForSupplementaryElementOfKind kind: String,
                        atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {

        if kind == UICollectionElementKindSectionFooter {

            if let footer =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: Storyboard.FooterIdentifier, forIndexPath: indexPath) as? AnimalDetailPhotosCollectionFooter {
                        footer.animalFullDescriptionLabel.text = animal.description

                        return footer
            }
        }
        assert(false, "Unexpected element kind")
    }

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {

        if !collapsing {
            return CGSize(width: UIScreen.mainScreen().bounds.size.width, height: 400)
        }

        let height = animal.description?.heightWithConstrainedWidth(UIScreen.mainScreen().bounds.size.width, font: footer.animalFullDescriptionLabel.font)

        footer.animalLabelContainer.frame = CGRect(x:0, y:0, width:UIScreen.mainScreen().bounds.size.width, height:height!)
        log.debug(height!.description)
        let tableHeight = footer.animalFeaturesTableView.frame.height
        let size = CGSize(width:UIScreen.mainScreen().bounds.size.width, height:height! + 175 + tableHeight)
        return size
    }
}


extension AnimalDetailViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {

        let screenWidth = UIScreen.mainScreen().bounds.size.width

        let cellWidth: CGFloat = screenWidth / 3 - 10

        return CGSize(width: ceil(cellWidth), height: ceil(cellWidth))

    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsZero
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 8
    }
    

}
