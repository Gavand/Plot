//
//  GameBehavior.swift
//  Game
//
//  Created by Gavin Andrews on 3/19/20.
//  Copyright © 2020 Gavin Andrews. All rights reserved.
//

import UIKit

class GameBehavior: UIDynamicBehavior {
    
    let gravity = UIGravityBehavior()

    lazy var collider: UICollisionBehavior = {
        let createdCollider = UICollisionBehavior()
        createdCollider.translatesReferenceBoundsIntoBoundary = true
        return createdCollider
    }()
    
    lazy var gameBehavior: UIDynamicItemBehavior = {
        let createdGameBehavior = UIDynamicItemBehavior()
        createdGameBehavior.elasticity = 0.75
        return createdGameBehavior
    }()
    
    func barrier(path: UIBezierPath, named name: String) {
        collider.removeBoundary(withIdentifier: name as NSCopying)
        collider.addBoundary(withIdentifier: name as NSCopying, for: path)
    }

    override init() {
        super.init()
        addChildBehavior(gravity)
        addChildBehavior(collider)
        addChildBehavior(gameBehavior)
    }

    func addSplash(drop: UIView) {
        dynamicAnimator?.referenceView?.addSubview(drop)
        gravity.addItem(drop)
        collider.addItem(drop)
        gameBehavior.addItem(drop)

    }

    func removeSplash(drop: UIView) {
        gravity.removeItem(drop)
        collider.removeItem(drop)
        gameBehavior.removeItem(drop)
        drop.removeFromSuperview()
    }
}
