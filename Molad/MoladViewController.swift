//
//  ViewController.swift
//  Molad
//
//  Created by Haskel Ash on 4/2/17.
//  Copyright © 2017 HaskelAsh. All rights reserved.
//

import UIKit

class MoladViewController: UIViewController {

    @IBOutlet private var clockView: ClockView!
    @IBOutlet private var hoursLabel: UILabel!
    @IBOutlet private var chalakimLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        clockView.addTarget(self, action: #selector(valueChanged(clock:)), for: .valueChanged)
        clockView.addTarget(self, action: #selector(crossLeftToRight(clock:)), for: .crossLeftToRight)
        clockView.addTarget(self, action: #selector(crossRightToLeft(clock:)), for: .crossRightToLeft)
    }

    internal func valueChanged(clock: ClockView) {
        hoursLabel.text = String(format: "%02i", clock.hours)
        chalakimLabel.text = String(format: "%0004i", clock.chalakim)
    }

    internal func crossLeftToRight(clock: ClockView) {
    }

    internal func crossRightToLeft(clock: ClockView) {
    }
}

