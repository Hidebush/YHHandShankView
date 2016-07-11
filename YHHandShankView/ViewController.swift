//
//  ViewController.swift
//  YHHandShankView
//
//  Created by admin on 16/7/5.
//  Copyright © 2016年 Theshy. All rights reserved.
//

import UIKit

class ViewController: UIViewController, YHHandShankViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        handShankView.bounds.size = CGSize(width: 250, height: 250)
        handShankView.center = view.center
        view.addSubview(handShankView)
        handShankView.handShankDelegate = self
    }
    
    func handShankChangePosition(handShankView: YHHandShankView) {
        print("---------\(handShankView.xValue)------\(handShankView.yValue)")
    }
    
    private lazy var handShankView: YHHandShankView = YHHandShankView.handShankView()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

