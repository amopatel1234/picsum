//
//  ViewController.swift
//  picsum
//
//  Created by Freelance on 19/06/2018.
//  Copyright © 2018 Freelance. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    @IBOutlet var statusLabel: UILabel!
    
    let viewModel = ViewModel()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(updateStatusLabel), name: NSNotification.Name(rawValue: "viewStateChanged"), object: nil)
    }

    deinit {
        stopTimer()
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name("viewStateChanged"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startTimer()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func hideStatusLabel() {
        self.statusLabel.isHidden = true
        
    }
    
    func showStatusLabel() {
        self.statusLabel.isHidden = false
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true, block: { (_) in
            self.viewModel.getImage {[weak self] (image) in
                self?.imageView.image = image
            }
        })
    }
    
    func stopTimer() {
        timer.invalidate()
    }
    
    @objc func updateStatusLabel() {
        DispatchQueue.main.async {
            switch self.viewModel.viewState {
            case .loading:
                self.showStatusLabel()
                self.statusLabel.text = self.viewModel.loadingString
            case .error:
                self.showStatusLabel()
                self.statusLabel.text = self.viewModel.errorString
            case .none:
                self.hideStatusLabel()
            }
        }
    }
}

