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

   private lazy var statusList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    // MARK: - 显示好友
    @objc private func showFriends(){
//        print(#function)
        let vc = WBTestViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - 设置表格假数据
    override func loadData() {
        for i in 0..<20 {
            //将数据插入数组的顶部
            statusList.insert(i.description, at: 0)
//            print(statusList)
        }
    }
}

// MARK: - 实现代理
extension WBHomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return statusList.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //1. 取cell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        //2.设置cell
        cell.textLabel?.text = statusList[indexPath.row]
        //3.返回cell
        return cell
    }
}
// MARK: - 设置界面
extension WBHomeViewController {
    //重写父类的方法
    override func setupUI() {
        super.setupUI()
        
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
