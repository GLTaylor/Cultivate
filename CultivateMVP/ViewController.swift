//
//  ViewController.swift
//  CultivateMVP
//
//  Created by Taylor Lindsay on 3/23/20.
//  Copyright © 2020 Taylor Lindsay. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Hello Taylor")
        _ = Observable.of("Hello RxSwift")
    }


}

