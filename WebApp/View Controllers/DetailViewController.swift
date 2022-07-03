//
//  DetailViewController.swift
//  WebApp
//
//  Created by Aida Moldaly on 02.07.2022.
//

import UIKit
import WebKit

class DetailViewController: UIViewController  {
    
    @IBOutlet var webView: WKWebView!
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    var urlString: String = "https://www.apple.com"
    
    static func makeDetailViewController(title: String, urlString: String) -> DetailViewController {
        let newViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        
        newViewController.title = title
        newViewController.urlString = urlString
        
        return newViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadWebSite()
        doubleTap()
        
        activityIndicator.startAnimating()
        webView.navigationDelegate = self
        activityIndicator.hidesWhenStopped = true
        webView.allowsLinkPreview = false
        
        view.backgroundColor = .orange
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func loadWebSite() {
        
        guard let siteUrl = URL(string: urlString) else { return }
        let request = URLRequest(url: siteUrl)
        webView.load(request)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func doubleTap() {
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGestureRecognizer.delegate = self
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        view.addGestureRecognizer(doubleTapGestureRecognizer)
    
    }
    
    @objc
    func handleDoubleTap(gestureReconizer: UITapGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.ended {
        let touchLocation = gestureReconizer.location(in: webView)
        print("HI \(touchLocation)")
            
        return
      }
        if gestureReconizer.state != UIGestureRecognizer.State.began { return }
    }
    

}

extension DetailViewController: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        activityIndicator.stopAnimating()
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        activityIndicator.stopAnimating()
    }
}

extension DetailViewController: UIGestureRecognizerDelegate {

    func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith:UIGestureRecognizer) -> Bool {
        return true
    }
    func gestureRecognizer(_: UIGestureRecognizer, shouldReceive:UITouch) -> Bool {
        return true
    }
}

