//
//  MushroomTypesViewController.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import UIKit
import Cartography

class MushroomTypesViewController: UIViewController {

    //MARK: - Stored properties
    var presenter: MushroomTypesPresenterProtocol!
    
    var collectionView: UICollectionView {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        layout.itemSize = CGSize(width: self.view.frame.width - 40, height: (self.view.frame.height/3))
        
        let collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MushroomTypesCell.self, forCellWithReuseIdentifier: "MushroomCell")
        collectionView.backgroundColor = Style.MTypes.collectionBGColor
        
        return collectionView
    }
    
    var items: [MushroomTypeViewModel]!

    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter.viewDidLoad()
    }

    //MARK: - Private API
    private func layout() {
        title = Style.MTypes.title
    }
    
    private func collectionSetup() {
        self.view.addSubview(collectionView)
    }
}

extension MushroomTypesViewController: MushroomTypesUserInterfaceProtocol {
    func configureFor(viewModel: [MushroomTypeViewModel]) {
        self.items = viewModel
        collectionSetup()
    }
}

extension MushroomTypesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MushroomTypesCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MushroomCell", for: indexPath) as! MushroomTypesCell
        cell.configure(model: self.items[indexPath.item])
        return cell
    }
}

extension MushroomTypesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didClickOnType(type: self.items[indexPath.item].type)
    }
}

class MushroomTypesCell: UICollectionViewCell {
    
    //MARK: - Stored properties
    let imageView: UIImageView
    let titleLabel: UILabel
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        imageView = {
            let imageView: UIImageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        titleLabel = {
            let label: UILabel = UILabel()
            label.textColor = Style.MTypes.titleColor
            label.font = UIFont.mushroomTitleFont()
            label.textAlignment = .center
            label.sizeToFit()
            return label
        }()
        
        super.init(frame: frame)
        self.backgroundColor = Style.MTypes.collectionCellColor
        
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private API
    private func layout() {
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)
        
        constrain(imageView, titleLabel) { image, title in
            let parent = image.superview!
            
            image.top == parent.top + 10
            image.centerX == parent.centerX
            image.height == parent.height * 0.8
            
            title.top == image.bottom
            title.bottom == parent.bottom - 10
            title.centerX == parent.centerX
        }
    }
    
    //MARK: - Public API
    public func configure(model: MushroomTypeViewModel) {
        imageView.image = model.type == .growing ?
                            UIImage(named: Style.MTypes.imageGrowing) :
                            UIImage(named: Style.MTypes.imageWild)
        titleLabel.text = model.type.rawValue
    }
}
