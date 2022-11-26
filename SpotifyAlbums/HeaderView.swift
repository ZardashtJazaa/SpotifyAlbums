//
//  HeaderView.swift
//  SpotifyAlbums
//
//  Created by Zardasht on 11/26/22.
//

import UIKit

struct Track {
    let imageName: String
}

class HeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "header-supplementary-reuse-idnetifier"
    var imageView =  UIImageView()
    
    var widthConstraints: NSLayoutConstraint?
    var heightConstraints: NSLayoutConstraint?
    
    var isFloating = false
    
    var track: Track? {
        didSet {
            guard let track = track else { return }
            let image = UIImage(named: track.imageName) ?? UIImage(named: "placeHolder")
            imageView.image = image
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func layout() {
                         
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        widthConstraints = imageView.widthAnchor.constraint(equalToConstant: 300)
        heightConstraints = imageView.heightAnchor.constraint(equalToConstant: 300)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            widthConstraints!,
            heightConstraints!,
        ])
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width: 300, height: 300)
    }
}

//MARK: - ScrollViewDidScroll
extension HeaderView {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let y = scrollView.contentOffset.y
        guard let widthConstraints = widthConstraints,
                let heightConstraints = heightConstraints else { return }
        
        //Scroll
        let normalizedScroll = y / 2
        widthConstraints.constant = 300 - normalizedScroll
        heightConstraints.constant = 300 - normalizedScroll
        
        //Alpha
        let normalizedAlpha = y / 200
        alpha = 1.0 - normalizedAlpha
        
        if isFloating {
            isHidden = y > 180
        }
    }
}
