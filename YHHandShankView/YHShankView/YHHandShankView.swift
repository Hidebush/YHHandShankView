//
//  YHHandShankView.swift
//  YHHandShankView
//
//  Created by 郭月辉 on 16/7/5.
//  Copyright © 2016年 Theshy. All rights reserved.
//

import UIKit

protocol YHHandShankViewDelegate: NSObjectProtocol {
    
    func handShankChangePosition(handShankView: YHHandShankView)
}

class YHHandShankView: UIView {

    @IBOutlet weak var topView: UIImageView!
    @IBOutlet weak var leftView: UIImageView!
    @IBOutlet weak var bottomView: UIImageView!
    @IBOutlet weak var rightView: UIImageView!
    @IBOutlet weak var centerView: UIImageView!
    @IBOutlet weak var backView: UIImageView!
    
    
    var topImageStr: String?
    var leftImageStr: String?
    var bottomImageStr: String?
    var rightImageStr: String?

    var xValue: CGFloat {
        return _xValue
    }
    var yValue: CGFloat {
        return _yValue
    }
    private var _xValue: CGFloat = 0.0
    private var _yValue: CGFloat = 0.0
    private var RADIUS: CGFloat = 0.0    //视图圆环半径
//    private var TRACKRADIUS: CGFloat = 0.0 //最大位移半径
    private let MARGIN: CGFloat = 50 // 移动最大值与边界边距 取代 TRACKRADIUS
    
    weak var handShankDelegate: YHHandShankViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        topView.image = UIImage(named: "arrow_199px_1199161_easyicon.net")
        leftView.image = UIImage(named: "arrow_153px_1199163_easyicon.net")
        bottomView.image = UIImage(named: "arrow_197px_1199162_easyicon.net")
        rightView.image = UIImage(named: "arrow_151px_1199164_easyicon.net")
        centerView.image = UIImage(named: "analogue_bg")
        backView.image = UIImage(named: "Circle_244px_1198167_easyicon.net")
        
        RADIUS = (bounds.size.width - 2 * MARGIN) * 0.5
//        TRACKRADIUS = 0.8 * RADIUS
        
        handShankInit()
    }
    
    class func handShankView() -> YHHandShankView {
        
        let view = NSBundle.mainBundle().loadNibNamed("YHHandShankView", owner: nil, options: nil).first as! YHHandShankView
        return view
    }
    
    // MARK: - 初始化
    private func handShankInit() {
        centerView.frame = CGRect(x: (bounds.size.width - centerView.bounds.size.width) * 0.5, y: (bounds.size.height - centerView.bounds.size.height) * 0.5, width: 70.0, height: 70.0)
        _xValue = 0.0
        _yValue = 0.0
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        fingerMoveEvent(touches)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        fingerMoveEvent(touches)
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        handShankInit()
        handShankDelegate?.handShankChangePosition(self)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        handShankInit()
        handShankDelegate?.handShankChangePosition(self)
    }
    
    private func fingerMoveEvent(touches: Set<UITouch>) {
        var location: CGPoint = CGPointZero
        if let touch: UITouch = touches.first {
            location = touch.locationInView(self)
            _xValue = (location.x - MARGIN) / RADIUS - 1.0;
            _yValue = 1.0 - (location.y - MARGIN) / RADIUS
            
            let r: CGFloat = sqrt(_xValue * _xValue + _yValue * _yValue) * RADIUS
            if r >= RADIUS {
                _xValue = RADIUS * (xValue / r)
                _yValue = RADIUS * (yValue / r)
                
                location.x = (_xValue + 1) * RADIUS + MARGIN
                location.y = (-_yValue + 1) * RADIUS + MARGIN
            }
            
            let centerFrame: CGRect = centerView.frame
            let newX: CGFloat = location.x - centerView.bounds.size.width * 0.5
            let newY: CGFloat = location.y - centerView.bounds.size.height * 0.5
            let newCenter: CGPoint = CGPoint(x:newX, y: newY)
            centerView.frame = CGRect(origin: newCenter, size: centerFrame.size)
            
            handShankDelegate?.handShankChangePosition(self)
        }
    }

    

}
