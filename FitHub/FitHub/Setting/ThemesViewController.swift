//
//  ThemesViewController.swift
//  FitHub
//
//  Created by cyrill on 2018/2/23.
//  Copyright © 2018年 cyrill.win. All rights reserved.
//

import UIKit

class ThemesViewController: BaseViewController, StoryboardLoadable {

    @IBOutlet weak var collectionView: UICollectionView!
    
    static var images: [UIImage] {
        get {
            return [#imageLiteral(resourceName: "BlackbgIcon"), #imageLiteral(resourceName: "WhitebgIcon")]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.title = "更换图标"
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "themeCell")
        
        guard let _ = UserDefaults.standard.value(forKey: "FitHubTheme") else {
            UserDefaults.standard.set(0, forKey: "FitHubTheme")
            return
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ThemesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "themeCell", for: indexPath)

        cell.contentView.layer.borderWidth = 1
        
        let image = ThemesViewController.images[indexPath.row]
            
        cell.contentView.layer.contents = image.cgImage
        
        let value = UserDefaults.standard.value(forKey: "FitHubTheme") as! Int
        if indexPath.item == value {
            cell.contentView.layer.borderColor = UIColor.red.cgColor
        } else {
            cell.contentView.layer.borderColor = UIColor.black.cgColor
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        let width = self.view.bounds.size.width
        let margin = (width-240-10 - 1) * 0.5
        return UIEdgeInsets(top: 20, left: margin, bottom: 100, right: margin)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            IconManager.changeIcon(iconName: nil)
        } else {
            IconManager.changeIcon(iconName: "WhitebgIcon")
        }
        
        UserDefaults.standard.set(indexPath.item, forKey: "FitHubTheme")
        self.collectionView.reloadData()
    }
    
}
