//
//  ViewController.swift
//  FoodTinder
//
//  Created by Aditi Gnanasekar on 7/5/17.
//  Copyright © 2017 The Girl Code. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let veggieNames: [String] = [
        "carrot",
        "cabbage",
        "egg",
        "peas",
        "potato",
        "cauliflower",
        "broccoli"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "veggieSegue"){
            let ivc = segue.destination as! InfoViewController
            if let cell = sender as? UICollectionViewCell, let indexPath = self.collectionView.indexPath(for: cell){
                let veggieName = veggieNames[indexPath.row]
                ivc.veggieName = veggieName
            }
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VeggieCell", for: indexPath) as! VeggieCell
        
        let veggieImages: [UIImage] = [
            UIImage(named: "carrot")!,
            UIImage(named: "cabbage")!,
            UIImage(named: "egg")!,
            UIImage(named: "peas")!,
            UIImage(named: "potato")!,
            UIImage(named: "cauliflower")!,
            UIImage(named: "broccoli")!
            ]
        
       // let image = UIImage(named: veggieImages[indexPath.row])
        let image = veggieImages[indexPath.row]
        cell.veggieImageView.image = image
        return cell
    }

}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let columns: CGFloat = 3
        let spacing: CGFloat = 1.5
        let totalHorizontalSpacing = (columns - 1) * spacing
        
        let itemWidth = (collectionView.bounds.width - totalHorizontalSpacing) / columns
        let itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        return itemSize
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1.5
    }
}
