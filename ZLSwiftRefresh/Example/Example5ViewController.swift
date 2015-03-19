//
//  Example5ViewController.swift
//  ZLSwiftRefresh
//
//  Created by 张磊 on 15-3-16.
//  Copyright (c) 2015年 com.zixue101.www. All rights reserved.
//

import UIKit

class Example5ViewController: UITableViewController {
    
    // default datas
    var datas:Int = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weak var weakSelf = self as Example5ViewController
        
        // 下拉刷新
        self.tableView.toRefreshAction(.ArrowAnimation, action: { () -> Void in
            weakSelf?.delay(0.0, closure: { () -> () in})
            weakSelf?.delay(2.0, closure: { () -> () in
                println("toRefreshAction success")
                weakSelf?.datas += 20
                weakSelf?.tableView.reloadData()
                weakSelf?.tableView.doneRefresh()
            })
        })
        
        // 上啦加载更多
        self.tableView.toLoadMoreAction({ () -> () in
            println("toLoadMoreAction success")
            if (weakSelf?.datas < 60){
                weakSelf?.datas += 20
                weakSelf?.tableView.reloadData()
                weakSelf?.tableView.doneRefresh()
            }else{
                weakSelf?.tableView.endLoadMoreData()
            }
        })
        
        // 及时上拉刷新
        self.tableView.nowRefresh(.ArrowAnimation, action: { () -> Void in
            weakSelf?.delay(2.0, closure: { () -> () in})
            weakSelf?.delay(2.0, closure: { () -> () in
                println("nowRefresh success")
                weakSelf?.datas += 20
                weakSelf?.tableView.reloadData()
                weakSelf?.tableView.doneRefresh()
            })
        })
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.datas;
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell! = tableView.dequeueReusableCellWithIdentifier("cell") as UITableViewCell
        
        if cell != nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
        }
        
        cell.textLabel?.text = "测试数据 - \(indexPath.row)"
        
        return cell
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
}
