//
//  MushroomDetailView.swift
//  MushroomSeller
//
//  Created by Pia on 15/10/2017.
//  Copyright © 2017 Pia. All rights reserved.
//

import Foundation
import UIKit
import Cartography

class MushroomDetailView: UIView {
    
    //MARK: - Stored properties
    var image: UIImageView = UIImageView()
    let detailStack: MushroomListDetailStack = MushroomListDetailStack()
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Public API
    public func configure(model: MushroomInfoViewModel) {
        image.image = UIImage.fromURL(model.imageUrl) ??
                        (model.type == .growing ?
                        UIImage(named: Style.MTypes.imageGrowing) :
                        UIImage(named: Style.MTypes.imageWild))
        
        detailStack.configure(
            name: model.name,
            numberBoxes: "\(model.boxesNumber)",
            boxFormat: model.boxFormat,
            price: "\(model.priceKg)€")
    }
    
    //MARK: - Private API
    private func layout() {
        self.addSubview(image)
        self.addSubview(detailStack)
        
        image.contentMode = .scaleAspectFit
        
        constrain(image, detailStack){ image, detail in
            let parent = image.superview!
            
            image.leading == parent.leading
            image.width == parent.width * Style.MList.DetailView.widthPerc
            image.centerY == parent.centerY
            
            detail.leading == image.trailing + Style.MList.DetailView.leading
            detail.trailing == parent.trailing
            detail.top == parent.top
            detail.bottom == parent.bottom
        }
    }
}

class MushroomListDetailStack: UIStackView {

    //MARK: - Stored properties
    let nameLabel = UILabel.mushroomLabel
    let numberBoxesLabel = UILabel.mushroomLabel
    let boxFormatLabel = UILabel.mushroomLabel
    let priceLabel = UILabel.mushroomLabel
    
    //MARK - Initializers
    init() {
        super.init(frame: CGRect.zero)
        
        self.axis = .vertical
        self.alignment = .fill
        self.distribution = .fill
        self.spacing = 5
        
        setup()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Private API
    private func setup() {
        let titleLabelsArray: [(String, UILabel)] = [
            (Style.MList.nameDetail, nameLabel),
            (Style.MList.numberBoxesDetail, numberBoxesLabel),
            (Style.MList.boxFormatDetail, boxFormatLabel),
            (Style.MList.priceDetail, priceLabel)
        ]
        
        titleLabelsArray.forEach { (title, label) in
            
            let lineView: UIView = {
                let view = UIView()
                constrain(view) { $0.height == 1 }
                view.backgroundColor = UIColor.BrandBG()
                return view
            }()
            
            let contentStackView = textLineStackView(withTitle: title, andLabel: label)
            
            let margins = UIEdgeInsets(
                top: 0,
                left: Style.MList.DetailView.stackLeadingTrailing,
                bottom: 0,
                right: Style.MList.DetailView.stackLeadingTrailing)
            
            addArrangedSubview(lineView)
            addArrangedSubview(contentStackView, layoutMargins: margins)
        }
    }
    
    private func textLineStackView(withTitle title: String, andLabel descriptionLabel: UILabel) -> UIStackView {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        
        let titleLabel: UILabel = UILabel(fromString: title)
        titleLabel.textAlignment = .left
        
        descriptionLabel.textAlignment = .right
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(descriptionLabel)
        
        addArrangedSubview(stack)
        
        return stack
    }
    
    //MARK: - Public API
    func configure(name: String, numberBoxes: String, boxFormat: String, price: String) {
        nameLabel.text = name
        numberBoxesLabel.text = numberBoxes
        boxFormatLabel.text = boxFormat
        priceLabel.text = price
    }
}

extension UILabel {
    static var mushroomLabel: UILabel {
        return UILabel(fromString: nil)
    }
    
    convenience init(fromString string: String?) {
        self.init()
        text = string
        textColor = UIColor.MetalicSilver()
        font = UIFont.mushroomFont()
    }
}
