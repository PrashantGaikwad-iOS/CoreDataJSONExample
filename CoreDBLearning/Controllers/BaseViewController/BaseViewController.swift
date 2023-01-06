//
//  BaseViewController.swift
//  CoreDBLearning
//
//  Created by prashant on 02/01/23.
//

import UIKit

class BaseViewController: UIViewController {

    let reachability = try! Reachability()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reachability.whenReachable = { reachability in
            if reachability.connection == .wifi {
                print("Reachable via WiFi")
            } else {
                print("Reachable via Cellular")
            }
        }
        reachability.whenUnreachable = { _ in
            print("Not reachable")
        }

        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated )
        reachability.stopNotifier()
    }

}
