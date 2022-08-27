//
//  messagesController.swift
//  tastyApp
//
//  Created by Rahul Patil on 09/08/22.
//

import UIKit
import WebKit


class DashBoardController: UIViewController,WKUIDelegate,WKNavigationDelegate {
    
    @IBOutlet weak var webView: WKWebView!
    
    @IBOutlet weak var tabView: UIView!
    
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var home: UIImageView!
    
    @IBOutlet weak var promotion: UIImageView!
    
    @IBOutlet weak var message: UIImageView!
    
    @IBOutlet weak var feedback: UIImageView!
    
    
    @IBOutlet weak var selectedView: UIView!
    
    @IBOutlet weak var promotionView: UIView!
    
    @IBOutlet weak var messageView: UIView!
    
    @IBOutlet weak var feedbackView: UIView!
    
    
    
    var tabBarImages:[UIImageView]!
    
    var selectedButton = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.selectedView.layer.cornerRadius = 15
        self.promotionView.layer.cornerRadius = 15
        self.messageView.layer.cornerRadius = 15
        self.feedbackView.layer.cornerRadius = 15
        
        let myUrl = URL(string: "https://tastee.inspeero.com/home")!
        let myRequest = URLRequest(url: myUrl)
        webView.load(myRequest)
        webView.allowsBackForwardNavigationGestures = true
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
    
        self.tabBarImages = [home , promotion , message , feedback]
        
        self.setSelectedState(selectedImg: self.home)
    
//        self.mainView.isHidden = false
        loadingIndicator.style = .large
//        self.tabView.isHidden = false
        self.selectedView.isHidden = false
        self.promotionView.isHidden = true
        self.messageView.isHidden = true
        self.feedbackView.isHidden = true
        
        webView.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
      
        
    }
    
    private func setSelectedState(selectedImg:UIImageView){
        for each in self.tabBarImages{
            each.tintColor = .white
        }
        selectedImg.tintColor = .black
        self.animateBtn(view: selectedImg)
    }
    
    
    
    @IBAction func btnAction(_ sender: UIButton) {
        let tag = sender.tag
        selectedButton = tag
        
        self.selectedView.isHidden = false
        if selectedButton == 0 {
            let myUrl = URL(string: "https://tastee.inspeero.com/home")!
            let myRequest = URLRequest(url: myUrl)
            self.webView.load(myRequest)
            
            self.selectedView.isHidden = false
            self.promotionView.isHidden = true
            self.messageView.isHidden = true
            self.feedbackView.isHidden = true
            
            self.setSelectedState(selectedImg: self.home)
        } else if selectedButton == 1 {
            
            let myUrl = URL(string: "https://tastee.inspeero.com/followedbyme")!
            let myRequest = URLRequest(url: myUrl)
            tabView.isHidden = false
            webView.load(myRequest)
         
            self.selectedView.isHidden = true
            self.promotionView.isHidden = false
            self.messageView.isHidden = true
            self.feedbackView.isHidden = true
            
            self.setSelectedState(selectedImg: self.promotion)
            
            
        } else if selectedButton == 2 {
            
            let myUrl = URL(string: "https://tastee.inspeero.com/messages/null")!
            let myRequest = URLRequest(url: myUrl)
            tabView.isHidden = false
            webView.load(myRequest)
            
            self.selectedView.isHidden = true
            self.promotionView.isHidden = true
            self.messageView.isHidden = false
            self.feedbackView.isHidden = true
            
            self.setSelectedState(selectedImg: self.message)
            
            
        } else if selectedButton == 3 {
            
            let myUrl = URL(string: "https://tastee.inspeero.com/feedback")!
            let myRequest = URLRequest(url: myUrl)
            webView.load(myRequest)
            
            self.selectedView.isHidden = true
            self.promotionView.isHidden = true
            self.messageView.isHidden = true
            self.feedbackView.isHidden = false
            
            self.setSelectedState(selectedImg: self.feedback)
           
            
            
        }
        
    }
    
    
    
    func showActivityIndicator(show: Bool) {
        if show {
            loadingIndicator.startAnimating()
        } else {
            loadingIndicator.stopAnimating()
            loadingIndicator.hidesWhenStopped = true
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showActivityIndicator(show: true)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showActivityIndicator(show: false)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showActivityIndicator(show: false)
    }
    
}


extension DashBoardController {
    
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        
        
        if keyPath == #keyPath(WKWebView.url) {
            
            let url = webView.url
       
            if url!.absoluteString == "https://tastee.inspeero.com/" {
    
                //Show Login View Controller
                tabView.isHidden = true
//                mainView.isHidden = true
                tabView.frame.size.height = 0
                
                let myUrl = URL(string: "https://tastee.inspeero.com/login")!
                let myRequest = URLRequest(url: myUrl)
                webView.load(myRequest)
                
                
                
                
            } else if url!.absoluteString == "https://tastee.inspeero.com/choose" {
                
                self.tabView.isHidden = true
               
                
                
            } else if url!.absoluteString == "https://tastee.inspeero.com/home" {
                
                self.setSelectedState(selectedImg: self.home)
                
                self.selectedView.isHidden = false
                self.promotionView.isHidden = true
                self.messageView.isHidden = true
                self.feedbackView.isHidden = true
                
                tabView.isHidden = false
                
            } else if url!.absoluteString == "https://tastee.inspeero.com/followedbyme" {
                
                self.setSelectedState(selectedImg: self.promotion)
                
                self.selectedView.isHidden = true
                self.promotionView.isHidden = false
                self.messageView.isHidden = true
                self.feedbackView.isHidden = true
                
                tabView.isHidden = false
                
            } else if url!.absoluteString == "https://tastee.inspeero.com/messages/null" {
                
                self.setSelectedState(selectedImg: self.message)
                
                self.selectedView.isHidden = true
                self.promotionView.isHidden = true
                self.messageView.isHidden = false
                self.feedbackView.isHidden = true
                
                tabView.isHidden = false
                
            } else if url!.absoluteString == "https://tastee.inspeero.com/feedback" {
                
                self.setSelectedState(selectedImg: self.feedback)
                
                self.selectedView.isHidden = true
                self.promotionView.isHidden = true
                self.messageView.isHidden = true
                self.feedbackView.isHidden = false
                
                tabView.isHidden = false
                
                
            } else if url!.absoluteString == "https://tastee.inspeero.com/login" {
//                tabView.isHidden = true
//                tabView.frame.size.height = 0
            }
        }
    }
}

extension DashBoardController {
    
    func animateBtn(view: UIView) {
        
        UIView.animate(withDuration: 1, delay: 0, options: .curveEaseInOut) {
            self.selectedView.center = view.center
            self.promotionView.center = view.center
            self.messageView.center = view.center
            self.feedbackView.center = view.center
        } completion: { _ in}
    }
    
    
}

