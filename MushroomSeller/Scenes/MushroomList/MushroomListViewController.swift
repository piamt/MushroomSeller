//
//  MushroomListViewController.swift
//  MushroomSeller
//
//  Created by Pia on 13/10/2017.
//  Copyright (c) 2017 Pia. All rights reserved.
//

import UIKit
import Cartography

class MushroomListViewController: UIViewController {

    //MARK: - Stored properties
    var presenter: MushroomListPresenterProtocol!
    
    var collectionView: UICollectionView!
    var items: [MushroomInfoViewModel] = []

    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        presenter.viewDidLoad()
    }

    //MARK: - Private API
    private func layout() {
        view.backgroundColor = UIColor.BrandBG()
    }
    
    private func collectionSetup() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.itemSize = CGSize(width: self.view.frame.width - 20, height: 135)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(MushroomDetailCell.self, forCellWithReuseIdentifier: "MushroomDetailCell")
        collectionView.backgroundColor = Style.MTypes.collectionBGColor
        self.view.addSubview(collectionView)
    }
}

extension MushroomListViewController: MushroomListUserInterfaceProtocol {
    func configureFor(viewModel: [MushroomInfoViewModel]) {
        self.items = viewModel
        collectionSetup()
    }
}

extension MushroomListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MushroomDetailCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MushroomDetailCell", for: indexPath) as! MushroomDetailCell
        cell.configureDetail(model: self.items[indexPath.item])
        return cell
    }
}

extension MushroomListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //Action when item clicked
    }
}

//TODO: Change size dynamically
//extension MushroomListViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView,
//                        layout collectionViewLayout: UICollectionViewLayout,
//                        sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//        return CGSize(width: self.view.frame.width, height: 135)
//    }
//}

class MushroomDetailCell: UICollectionViewCell {
    
    //MARK: - Stored properties
    let detail = MushroomDetailView() 
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = Style.MList.detailCellColor
        self.addSubview(detail)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Lyfecicle
    override func layoutSubviews() {
        constrain(detail) { detail in
            let parent = detail.superview!
            
            detail.top == parent.top + 5.0
            detail.leading == parent.leading + 10
            detail.trailing == parent.trailing
        }
    }
    
    //MARK: - Public API
    func configureDetail(model: MushroomInfoViewModel) {
        detail.configure(model: model)
    }
}
