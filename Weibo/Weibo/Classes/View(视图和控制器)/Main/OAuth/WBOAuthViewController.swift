//
//  WBOAuthViewController.swift
//  Weibo
//
//  Created by Smile on 2018/8/14.
//  Copyright © 2018年 llbt. All rights reserved.
//

import UIKit
import SVProgressHUD

//通过 WebView加载新浪微博授权页面控制器
class WBOAuthViewController: UIViewController {

    private lazy var webView = UIWebView()
    
    override func loadView() {
        view = webView
        view.backgroundColor = UIColor.white
        //取消滚动视图  --新浪微博的服务器，返回的授权页面默认就是手机全屏
        webView.scrollView.isScrollEnabled = false
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
        //关闭指示器
        SVProgressHUD.dismiss()
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
    /// - Returns: 是否加载request   返回YES允许加载，返回NO不允许加载
    func webView(_ webView: UIWebView, shouldStartLoadWith request: URLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
//        print("-----\(request.url)")
        /**知识补充：meituan:///showP1:P2:P3:P4:/大西瓜/红牛/小樱桃/小肥羊
         **  request.url?.scheme 协议头  meituan
         **  request.url?.host  主机头 nil,如果没有///
         **  request.url?.pathComponents  返回数组，URL中所有路径的数组【showP1:P2:P3:P4 ，大西瓜， 红牛， 小樱桃， 小肥羊 】
         **  request.url?.query  查询字符串，URL中？后面的内容
         **/
        
        //确定思路：
        //1. 如果请求地址中包含http://baidu.com不加载页面，否则加载页面
        print("加载请求-----\(String(describing: request.url?.absoluteString))")
        // request.url?.absoluteString.hasPrefix(WBRedirectURL) 返回的是可选项  true/false/nil
        if request.url?.absoluteString.hasPrefix(WBRedirectURL) ==  false {
            return true
        }
        //2. 从http://baidu.com地址中查看是否包含 ‘code=’
        //如果有，授权成功；否则，授权失败
        if request.url?.query?.hasPrefix("code=") == false {
            print("取消授权")
            close()
            return false
        }
        //3. 从query字符串中取得授权码
        //代码走到此处，url 中一定有 查询字符串，并且包含“code=”
        let code  = request.url?.query?.substring(from: "code=".endIndex) ?? ""
        print("授权码 - \(code)")

        return false
    }

    func webViewDidStartLoad(_ webView: UIWebView) {
        SVProgressHUD.show()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        SVProgressHUD.dismiss()
    }
}
