//
//  GameView.swift
//  Game
//
//  Created by Gavin Andrews on 3/19/20.
//  Copyright © 2020 Gavin Andrews. All rights reserved.
//

import UIKit

class GameView: UIView {
    private let gravity = UIGravityBehavior()
        
        private lazy var animator: UIDynamicAnimator = UIDynamicAnimator(referenceView: self)
        
        var animating: Bool = false {
            didSet {
                if animating {
                    animator.addBehavior(gravity)
                } else {
                    animator.removeBehavior(gravity)
                }
            }
        }
        
        private let dropsPerRow = 10

        private var dropSize: CGSize {
            let size = bounds.size.width / CGFloat(dropsPerRow)
            return CGSize(width: size, height: size)
        }

        func addDrop() {
            var frame = CGRect(origin: CGPoint.zero, size: dropSize)
            frame.origin.x = CGFloat.random(max: dropsPerRow) * dropSize.width
            
            let drop = UIView(frame: frame)
            drop.backgroundColor = UIColor.random
            
            addSubview(drop)
            gravity.addItem(drop)
        }
    }
