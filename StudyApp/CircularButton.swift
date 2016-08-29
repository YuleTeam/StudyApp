//
//  CircularButton.swift
//  StudyApp
//
//  Created by 濱崎 裕太 on 2016/08/29.
//  Copyright © 2016年 YuleTeam. All rights reserved.
//

import UIKit

class CircularButton: UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()

        let radius: CGFloat = 0.5 * self.bounds.size.width

        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
