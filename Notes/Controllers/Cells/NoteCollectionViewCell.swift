//
//  NoteCollectionViewCell.swift
//  Notes
//
//  Created by Дмитрий Старков on 09.03.2022.
//

import UIKit

class NoteCollectionViewCell: UICollectionViewCell {
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 25, weight: .medium)
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .light)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemIndigo
        contentView.addSubview(nameLabel)
        contentView.addSubview(descriptionLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.cornerRadius = 7.0
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.clear.cgColor
        layer.masksToBounds = true
        
        nameLabel.anchor(top: contentView.topAnchor,
                         leading: contentView.leadingAnchor,
                         bottom: nil,
                         trailing: contentView.trailingAnchor,
                         padding: .init(top: 0, left: 10, bottom: 0, right: 10),
                         size: CGSize(width: contentView.frame.width, height: contentView.frame.height/3))
        
        descriptionLabel.anchor(top: nameLabel.bottomAnchor,
                                leading: contentView.leadingAnchor,
                                bottom: contentView.bottomAnchor,
                                trailing: contentView.trailingAnchor,
                                padding: .init(top: 0, left: 10, bottom: 0, right: -10))
    }
    
    public func configure(with model: NoteModel){
        nameLabel.text = model.name
        descriptionLabel.text = model.textOfNote
    }
    
}
