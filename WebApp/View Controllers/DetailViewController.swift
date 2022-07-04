//
//  DetailViewController.swift
//  WebApp
//
//  Created by Aida Moldaly on 02.07.2022.
//

import UIKit
import WebKit

protocol AddFavWebsiteDelegate: AnyObject {
    func addFavWeb(favWebsite: Website)
}

class DetailViewController: UIViewController  {

    weak var addFavDelegate: AddFavWebsiteDelegate?
    
    @IBOutlet var webView: WKWebView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    private var timer: Timer!
    private var urlString: String = "https://www.apple.com"
    private var favWebsites: [Website] = []
    
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
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func loadWebSite() {
        
        guard let siteUrl = URL(string: urlString) else { return }
        let request = URLRequest(url: siteUrl)
        webView.load(request)
    }
    
    func doubleTap() {
        
        let doubleTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTap))
        doubleTapGestureRecognizer.delegate = self
        doubleTapGestureRecognizer.numberOfTapsRequired = 2
        webView.addGestureRecognizer(doubleTapGestureRecognizer)
        
        timer = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(self.setBackgroundColor), userInfo: nil, repeats: true)
    }
    
    @objc
    func handleDoubleTap(gestureReconizer: UITapGestureRecognizer) {
        view.backgroundColor = .systemOrange
        
        guard let title = title else { return }
        let favWebsite = Website(title: title, siteUrl: urlString)
        addFavDelegate?.addFavWeb(favWebsite: favWebsite)

        return
    }
    
    @objc
    func setBackgroundColor() {
        self.view.backgroundColor = .white
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

    func gestureRecognizer(_: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith: UIGestureRecognizer) -> Bool {
        return true
    }
    func gestureRecognizer(_: UIGestureRecognizer, shouldReceive:UITouch) -> Bool {
        return true
    }
}

