//
//  WBBaseViewController.swift
//  Weibo
//
//  Created by Smile on 2018/3/5.
//  Copyright © 2018年 llbt. All rights reserved.
//
/*基类：1.所有主控制器的基类
 *     2.设置界面  设置新的导航条+navItem  、 重写title属性，保证外部设置title的代码不需要任何的变化
 *     3.设置表格视图
 *     4.封住刷新逻辑 上拉+下拉
 *     5.访客试图  用户没有登录的界面显示
 */

//注意：swift中利用extension可以把函数按照功能进行分类，便于阅读和维护！
//1. extension 不能有属性
//2. extension不能重写父类‘本类’方法！即父类在extension，子类也在extension中。重写父类的方法是子类的职责，扩展是类的扩展 
import UIKit

///所有控制器的基类
class WBBaseViewController: UIViewController {
    
    //设置底层视图
    let navBarView = UIView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.cz_screenWidth(), height: 64))
    //设置导航条
    lazy var navigationBar = UINavigationBar.init(frame: CGRect(x: 0, y: 20, width: UIScreen.cz_screenWidth(), height: 44))
    //设置导航条目
    lazy var navItem = UINavigationItem()
    //设置tableView表格，用户登录之后才创建
    var tableView: UITableView?
    //刷新控件
    var refreshControl: UIRefreshControl?
    //上拉刷新标记
    var isPullUp:Bool = false
    //访客视图信息字典
    var visitorInfoDict:[String:String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //判断用户登录加载数据，否则不加载
        WBNetWorkManager.shared.userLogon ? loadData() : ()
        
        //注册通知
        NotificationCenter.default.addObserver(self,
                                               selector:#selector(loginSuccess),
                                               name: NSNotification.Name(rawValue: WBUserLoginSuccessedNotification),
                                               object: nil)
    }
    deinit {
        //注销通知
        NotificationCenter.default.removeObserver(self)
    }
    //基类设置加载数据
    @objc func loadData() {
        //如何子类不识闲任何方法，默认关闭刷新控件
        refreshControl?.endRefreshing()
    }
    //重写title setter方法，设置标题
    override var title: String? {
        didSet {
            navItem.title = title
        }
    }
}

extension WBBaseViewController {
    //登录成功处理
    @objc private func loginSuccess(n: Notification) {
        print("登录成功")
        //登录前左右两边的barbutton按钮置空
        navItem.leftBarButtonItem = nil
        navItem.rightBarButtonItem = nil
        //更新UI，将访客视图->表格视图
        //需要重新设置view
        //在访问view的getter方法时，当view = nil，会调用loadView -> viewdidLoad
        view = nil
        
        //注销通知，避免通知会重复注册
        NotificationCenter.default.removeObserver(self)
        
    }
    
    @objc func login() {
        print("登录")
        //发送通知
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: WBUserShouldLoginNotification), object: nil)
    }
    @objc func register() {
        print("注册")
    }
}

///设置视图
extension WBBaseViewController {
    
    //MARK： 设置界面
    //注：swift4.0 子类要重写父类的extension方法，需要加@objc，否则报错"Declarations in extensions cannot override yet"
   @objc private func setupUI() {
    
    //取消自动缩进 如果隐藏了导航栏，会缩进20个点
        automaticallyAdjustsScrollViewInsets = false
        setupNavigaitonBar()
        WBNetWorkManager.shared.userLogon ? setupTableView() : setupVisitorView()
    }
    
    //MArk: 设置访客试图
    @objc func setupVisitorView(){
        
        let visitorView = WBVisitorView.init(frame: view.bounds)
        view.insertSubview(visitorView, belowSubview: navBarView)
        //1.设置访客视图字典
        visitorView.visitorInfo = visitorInfoDict
        
        //2. 设置访客视图监听方法
        visitorView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        visitorView.registerButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        
        //3.设置导航按钮
        navItem.leftBarButtonItem = UIBarButtonItem.init(title: "注册", style: .plain, target: self, action: #selector(register))
        navItem.rightBarButtonItem = UIBarButtonItem.init(title: "登录",style: .plain, target: self, action: #selector(login))
    }
    
    //MARK： 设置表格视图  --用户登录之后进行
    //子类重写此方法，用户不需要关心登录之前的逻辑
    @objc func setupTableView() {
    tableView = UITableView.init(frame: view.bounds, style: .plain)
    view.insertSubview(tableView!, belowSubview: navBarView)
    //设置数据源代理及方法，目的:子类实现数据源方法
    tableView?.delegate = self
    tableView?.dataSource = self
    //设置内容缩进
    tableView?.contentInset = UIEdgeInsets(top: navigationBar.bounds.height,
                                           left: 0,
                                           bottom: 0,//tabBarController?.tabBar.bounds.height ?? 49
                                           right: 0)
        
    //修改指示器的缩进 -强行解包是为了有一个必有的inset
    tableView?.scrollIndicatorInsets = tableView!.contentInset
    //添加刷新控件
      // 1>实例化控件
    refreshControl = UIRefreshControl.init()
      // 2>添加到表格视图
    tableView?.addSubview(refreshControl!)
      // 3>添加监听方法
    refreshControl?.addTarget(self, action: #selector(loadData), for: .valueChanged)
    }
    
    //MARK： 设置导航条视图
    
   private func setupNavigaitonBar() {
        //FIXME: 添加一个底层视图，矫正title显示位置
        navBarView.backgroundColor = UIColor.cz_color(withHex: 0xF6F6F6)
        view.addSubview(navBarView)
        
        //添加navigationBar
        navBarView.addSubview(navigationBar)
        //将item设置给bar
        navigationBar.items = [navItem]
        //1. 设置navigationBar 条子渲染颜色
        navigationBar.barTintColor = UIColor.cz_color(withHex: 0xF6F6F6)
        //2. 设置navigationBar 标题颜色
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.darkGray]
        //3. 设置字体颜色
        navigationBar.tintColor = UIColor.orange
    }
}

///设置协议UITableViewDelegate,UITableViewDataSource
//基类只负责准备方法，子类负责实现，子类的数据源方法不需要super
extension WBBaseViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
