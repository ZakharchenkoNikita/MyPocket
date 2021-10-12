//
//  NewTransactionViewController.swift
//  MyPocket
//
//  Created by Nikita on 03.09.21.
//

import UIKit

class NewTransactionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension NewTransactionViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        15
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! NumpadCollectionViewCell

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let leftPadding = view.frame.width * 0.15
//        let rightPadding = leftPadding
        let insertSpacing = view.frame.width * 0.1
        
        let cellWidth = (view.frame.width - 2 * leftPadding - 2 * insertSpacing) / 3
        
        return CGSize(width: cellWidth, height: cellWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let leftPadding = view.frame.width * 0.15
        let rightPadding = leftPadding
//        let insertSpacing = view.frame.width * 0.1
        
        return .init(top: 10, left: leftPadding, bottom: 10, right: rightPadding)
    }
}
