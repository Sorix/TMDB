//
//  SectionHeaderFooterView.swift
//  TMDB
//
//  Created by Vasily Ulianov on 12/09/2017.
//  Copyright © 2017 Vasily Ulianov. All rights reserved.
//

import UIKit

class SectionHeaderFooterView: UITableViewHeaderFooterView {
	
	static var nib: UINib {
		return UINib(nibName: "SectionHeaderFooterView", bundle: nil)
	}

	@IBOutlet weak var sectionTitleLabel: UILabel!
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
