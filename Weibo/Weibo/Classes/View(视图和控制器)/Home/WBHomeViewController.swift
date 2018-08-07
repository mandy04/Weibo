//
//  WBHomeViewController.swift
//  Weibo
//
//  Created by Smile on 2018/3/5.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

//定义全局cell
private let cellId = "cellID"

class WBHomeViewController: WBBaseViewController {

    
  private lazy var listViewModel = WBStatusListViewModel()
    
    // MARK: - 设置表格假数据
    ///模拟 '延迟' 加载数据
    override func loadData() {
        listViewModel.loadStatus(pullUp: isPullUp) { (isSuccess , shouldRefresh:Bool) in
            print("结束数据")
            self.refreshControl?.endRefreshing()
            //恢复上拉标志
            self.isPullUp = false
            
            //刷新表格
            if shouldRefresh {
                self.tableView?.reloadData()
            }
        }
    }
    
    // MARK: - 显示好友
    @objc private func showFriends(){
        //        print(#function)
        let vc = WBTestViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

// MARK: - 实现代理
extension WBHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1. 取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        //2.设置cell
        cell.textLabel?.text = listViewModel.statusList[indexPath.row].text
        //3.返回cell
        return cell
    }
    //上拉刷新的条件判断：加载到最后一行indexPath.row.section（最大）、indexPath.row（最后一行）上拉刷新
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //1> row
        let row = indexPath.row
        //2> section
        let section = tableView.numberOfSections - 1
        if  section < 0 || row < 0{
            return
        }
       //3>行数
        let count = tableView.numberOfRows(inSection: section)
        
        if row == (count - 1) && !isPullUp {
            print("上拉刷新")
            isPullUp = true
            //加载数据
            loadData()
        }
    }
    
}
// MARK: - 设置界面
extension WBHomeViewController {
    //重写父类的方法
    override func setupTableView() {
       
        super.setupTableView()
        
        //1. 设置导航栏按钮
//        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "好友", style: .plain, target: self, action: #selector(showFriends))
        
        //2. 使用自定义视图设置导航按钮
//        let btn : UIButton = UIButton.cz_textButton("好友", fontSize: 14, normalColor: UIColor.lightGray, highlightedColor: UIColor.orange)
//        btn.addTarget(self, action: #selector(showFriends), for: .touchUpInside)
//        navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: btn)
        
        //3. 抽取
            navItem.leftBarButtonItem = UIBarButtonItem.init(title: "好友", target: self, action: #selector(showFriends))

        //注册cell
        tableView?.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
}
