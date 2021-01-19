//
//  LoadingView.swift
//  Currency
//
//  Created by Dhananjay Kumar Dubey on 19/1/21.
//  Copyright © 2020 Dhananjay. All rights reserved.
//

import UIKit

final class LoadingView: UIView {
        
    @IBOutlet private(set) weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet private(set) weak var labelLoading: UILabel!

    private var contentView: UIView!
    
    /**
     `LoadingView` initializer
     - return: Returns an instance of LoadingView
     */
    func instantiateXIB() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = (nib.instantiate(withOwner: self, options: nil).first as? UIView) else {
            fatalError("Error instantiating \(String(describing: type(of: self)))")
        }

        return view
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        self.contentView = self.instantiateXIB()
        
        self.contentView.frame = bounds
        self.contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        addSubview(self.contentView)
    }
}
