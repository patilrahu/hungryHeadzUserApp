//
//  ViewController.swift
//  tastyApp
//
//  Created by Rahul Patil on 01/08/22.
//

import UIKit
import WebKit


class ViewController: UIViewController {
    
    
    var webViewOutlet: WKWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        //        MARK: - default url load
        
        let myUrl = URL(string: "https://tastee.inspeero.com/login")!
        let myRequest = URLRequest(url: myUrl)
        
        self.webViewOutlet = WKWebView.init(frame: .zero)
        self.webViewOutlet.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(self.webViewOutlet)
        NSLayoutConstraint.activate([
            self.webViewOutlet.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            self.webViewOutlet.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.webViewOutlet.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.webViewOutlet.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        webViewOutlet.allowsBackForwardNavigationGestures = true
        webViewOutlet.tintColor = .blue
        
        webViewOutlet.load(myRequest)
        
        //        MARK: - observer for fetching url
        
        webViewOutlet.addObserver(self, forKeyPath: "URL", options: .new, context: nil)
        
        
        //        MARK: - dismiss keyboard
        
//        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
//
//        view.addGestureRecognizer(tap)
        
//        checkMode()
        
    }
    
    //    MARK: - method for dismiss keyboard
//
//    @objc func dismissKeyboard() {
//
//        view.endEditing(true)
//
//    }
    
    func checkMode() {
        let userInterfaceStyle = traitCollection.userInterfaceStyle // Either .unspecified, .light, or .dark
        
        switch userInterfaceStyle {
        case .light,.unspecified:
            print("light")
                case .dark:
            print("dark")
        @unknown default:
            fatalError("error")
        }
    }
    
    

    
}



extension ViewController {
    
    //    MARK: - fetch webview url method
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == #keyPath(WKWebView.url) {
            let url = webViewOutlet.url
            
            if url!.absoluteString == "https://tastee.inspeero.com/home" {
                
                self.performSegue(withIdentifier: "show", sender: nil)
                
            }

        }
    }
}



