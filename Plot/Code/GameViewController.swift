//
//  GameViewController.swift
//  Game
//
//  Created by Gavin Andrews on 3/19/20.
//  Copyright © 2020 Gavin Andrews. All rights reserved.
//

import UIKit
import CoreMotion

class GameViewController: UIViewController, UIDynamicAnimatorDelegate {
    
    @IBOutlet weak var gameView: UIView!
    
    let gravity = UIGravityBehavior()
    
    lazy var animator: UIDynamicAnimator = {
        let createdDynamicAnimator = UIDynamicAnimator(referenceView: self.gameView)
        createdDynamicAnimator.delegate = self
        updateRealGravity()
        return createdDynamicAnimator
    }()
    
    let splashBehavior = GameBehavior()
    
    var attachment: UIAttachmentBehavior? {
        willSet {
            if newValue == nil && attachment != nil {
                animator.removeBehavior(attachment!)
            }
        }
        didSet {
            if attachment != nil {
                animator.addBehavior(attachment!)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        animator.addBehavior(splashBehavior)
        
    }
    
    //    func dynamicAnimatorDidPause(_ animator: UIDynamicAnimator) {
    //        removeCompletedRow()
    //    }
    
    var realGravity: Bool = true {
        didSet {
            updateRealGravity()
        }
    }
    
    private let motionManager = CMMotionManager()
    
    
    private func updateRealGravity() {
        if realGravity {
            if motionManager.isAccelerometerAvailable && !motionManager.isAccelerometerActive {
                motionManager.accelerometerUpdateInterval = 0.25
                motionManager.startAccelerometerUpdates(to: OperationQueue.main)
                { [unowned self] (data, error) in
                    if self.splashBehavior.dynamicAnimator != nil {
                        if var dx = data?.acceleration.x, var dy = data?.acceleration.y {
                            switch UIDevice.current.orientation {
                            case .portrait: dy = -dy
                            case .portraitUpsideDown: break
                            case .landscapeRight: swap(&dx, &dy)
                            case .landscapeLeft: swap(&dx, &dy); dy = -dy
                            default: dx = 0; dy = 0
                            }
                            self.splashBehavior.gravity.gravityDirection = CGVector(dx: dx, dy: dy)
                        }
                    }
                    else {
                        self.motionManager.stopAccelerometerUpdates()
                    }
                }
            }
        }
        else {
        self.motionManager.stopAccelerometerUpdates()
        }
        
    }
    
    var dropsPerRow = 10
    
//    var dropSize: CGSize {
//        let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
//        return CGSize(width: size, height: size)
//
//    }
    
        var dropSize: CGRect {
    //        let size = gameView.bounds.size.width / CGFloat(dropsPerRow)
            let rect1 = CGRect(x: 20, y: 20, width: 50, height: 50)
            let rect2 = rect1.offsetBy(dx: 50, dy: 100)
            
            
            
            return rect2
            //        return CGSize(width: 1, height: size)
    }
    
    @IBAction func drop(_ sender: UITapGestureRecognizer) {
        drop()
    }
  

    @IBAction func grabSplash(_ sender: UIPanGestureRecognizer) {
        let gesturePoint = sender.location(in: gameView)
        switch sender.state {
        case .began:
            if let viewToAttachedTo = lastDroppedView {
                attachment = UIAttachmentBehavior(item: viewToAttachedTo, attachedToAnchor: gesturePoint)
            }
        case .changed:
            attachment?.anchorPoint = gesturePoint
        case .ended:
            attachment = nil
        default: break
        }
    }
    
    var lastDroppedView: UIView?
    
//    func intersection(_ r2: CGRect) -> CGRect {
//
//    }
    
    func drop() {
        var frame = CGRect(origin: .zero, size: dropSize.size)
        frame.origin.x = CGFloat.rdm(max: dropsPerRow) * dropSize.width
        
        let dropView = UIView(frame: frame)
        dropView.backgroundColor = UIColor.white
        
        lastDroppedView = dropView
        
        splashBehavior.addSplash(drop: dropView)
    }
    
    //    func removeCompletedRow()
    //    {
    //        var dropsToRemove = [UIView]()
    //        var dropFrame = CGRect(x: 0, y: gameView.frame.maxY, width: dropSize.width, height: dropSize.height)
    //
    //        repeat {
    //            dropFrame.origin.y -= dropSize.height
    //            dropFrame.origin.x = 0
    //            var dropsFound = [UIView]()
    //            var rowIsComplete = true
    //            for _ in 0 ..< dropsPerRow {
    //                if let hitView = gameView.hitTest(CGPoint(x: dropFrame.midX, y: dropFrame.midY), with: nil) {
    //                    if hitView.superview == gameView {
    //                        dropsFound.append(hitView)
    //                    } else {
    //                        rowIsComplete = false
    //                    }
    //                }
    //                dropFrame.origin.x += dropSize.width
    //            }
    //            if rowIsComplete {
    //                dropsToRemove += dropsFound
    //            }
    //        } while dropsToRemove.count == 0 && dropFrame.origin.y > 0
    //
    //        for drop in dropsToRemove {
    //            splashBehavior.removeSplash(drop: drop)        }
    //    }
    
}

private extension CGFloat {
    static func rdm(max: Int) -> CGFloat {
        return CGFloat(arc4random() % UInt32(max))
    }
}

//private extension UIColor {
//    class var rdm: UIColor{
//        switch arc4random()%5 {
//        case 0: return UIColor.green
//        case 1: return UIColor.blue
//        case 2: return UIColor.orange
//        case 3: return UIColor.red
//        case 4: return UIColor.purple
//        default: return UIColor.black
//        }
//    }
//}
