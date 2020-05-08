//
//  ViewController.swift
//  WebView
//
//  Created by 심재현 on 07/05/2020.
//  Copyright © 2020 xim. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    
    
    func loadWebPage(_ url: String) {
        let escapeString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        let myUrl = URL(string: escapeString!)
        let myRequest = URLRequest(url: myUrl!)
        webView.loadRequest(myRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        webView.delegate = self
        loadWebPage("https://moonibot.tistory.com")
    }
    
    func webViewDidStartLoad(_ webView: UIWebView) {
        myActivityIndicator.startAnimating()
    }
    func webViewDidFinishLoad(_ webView: UIWebView) {
        myActivityIndicator.stopAnimating()
    }
    
    func checkUrl(_ url: String) -> String {
        var strUrl = url
        let flag = strUrl.hasPrefix("http://")
        if !flag {
            strUrl = "http://" + strUrl
        }
        return strUrl
    }
    
    @IBAction func btnGoHandler(_ sender: UIButton) {
        let myUrl = checkUrl(textField.text!)
        textField.text = ""
        loadWebPage(myUrl)
    }
    
    @IBAction func btnSite1Handler(_ sender: UIButton) {
        loadWebPage("https://moonibot.tistory.com/category/IT/swift")
    }
    
    @IBAction func btnSite2Handler(_ sender: UIButton) {
        loadWebPage("https://moonibot.tistory.com/category/IT/database")
    }
    
    @IBAction func btnHtmlHandler(_ sender: UIButton) {
        let htmlString = "<h1> HTML String </h1><p> String var</p> <p>Move To <a href=\"https://moonibot.tistory.com\"></a></p>"
        webView.loadHTMLString(htmlString, baseURL: nil)
    }
    
    @IBAction func btnFileHandler(_ sender: UIButton) {
        let myHtmlBundle = Bundle.main
        let filePath = myHtmlBundle.path(forResource: "html", ofType: "html")
        loadWebPage(filePath!)
    }
    
    @IBAction func btnStopHandler(_ sender: UIBarButtonItem) {
        webView.stopLoading()
    }
    
    @IBAction func btnRefreshHandler(_ sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func btnRewindHandler(_ sender: UIBarButtonItem) {
        webView.goBack()
    }
   
    @IBAction func btnNextHandler(_ sender: UIBarButtonItem) {
        webView.goForward()
    }
}

