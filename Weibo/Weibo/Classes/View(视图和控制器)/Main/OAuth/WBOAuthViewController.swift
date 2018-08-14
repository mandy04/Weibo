//
//  WBOAuthViewController.swift
//  Weibo
//
//  Created by Smile on 2018/8/14.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit

//通过 WebView加载新浪微博授权页面控制器
class WBOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        view.backgroundColor = UIColor.white
        //设置代理
        webView.delegate = self
        //设置导航栏
        title = "登录新浪微博"
        navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "返回", target: self, action: #selector(close), isBack: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "自动填充", target: self, action: #selector(autoFill))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //加载授权页面
        let urlString = "https://api.weibo.com/oauth2/authorize?client_id=\(WBAppKey)&redirect_uri=\(WBRedirectURL)"
        
        //1. 确认访问资源
        guard let url = URL.init(string: urlString) else{
          return
        }
        //2. 建立请求
        let request = URLRequest.init(url: url)
        
        //3. 访问请求
        webView.loadRequest(request)
    }
    
    
    ///自动填充--webview的注入，直接通过 js 修改
    @objc private func autoFill() {
        
        //1. 准备js
        let js = "document.getElementById('userId').value='798422962@qq.com' ;" + "document.getElementById('passwd').value='machunhui1226' ;"
        //2.webView加载js
        webView.stringByEvaluatingJavaScript(from: js)
        
    }
    //返回
    @objc private func close() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK --遵守协议
extension WBOAuthViewController : UIWebViewDelegate {
    ///webView将要加载请求
    ///
    /// - Parameters:
    ///   - webView: webView
    ///   - request: 要加载的请求
    ///   - navigationType: 导航类型
    /// - Returns: 是否加载request
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
        //确定思路：
        //1. 如果请求地址中包含http://baidu.com不加载页面，否则加载页面
        print("加载请求-----\(String(describing: request.url?.absoluteString))")
        //2. 从http://baidu.com地址中查看是否包含 ‘code=’
        //如果有，授权成功；否则，授权失败
        return true
    }
}
