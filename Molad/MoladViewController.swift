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
    @IBOutlet private var dayLabel: UILabel!
    @IBOutlet private var hoursLabel: UILabel!
    @IBOutlet private var chalakimLabel: UILabel!

    @IBOutlet private var secularDayLabel: UILabel!
    @IBOutlet private var secularHoursLabel: UILabel!
    @IBOutlet private var minutesLabel: UILabel!
    @IBOutlet private var secondsLabel: UILabel!
    @IBOutlet private var amOrPmLabel: UILabel!
    @IBOutlet private var thirdsOfSecondsLabel: UILabel!

    //this is really ascending, though it looks descending
    private let hebrewDays = ["ז", "א", "ב", "ג", "ד", "ה", "ו"]

    private var molad = Molad(day: 0, hours: 0, chalakim: 0)

    override func viewDidLoad() {
        super.viewDidLoad()

        clockView.addTarget(self, action: #selector(valueChanged(clock:)), for: .valueChanged)
        clockView.addTarget(self, action: #selector(crossLeftToRight(clock:)), for: .crossLeftToRight)
        clockView.addTarget(self, action: #selector(crossRightToLeft(clock:)), for: .crossRightToLeft)

        molad.day = 1
        molad.hours = clockView.hours
        molad.chalakim = clockView.chalakim

        hoursLabel.text = String(format: "%02i", clockView.hours)
        chalakimLabel.text = String(format: "%0004i", clockView.chalakim)
        dayLabel.text = hebrewDays[day]
        updateSecularLabels()
    }

    internal func valueChanged(clock: ClockView) {
        molad.hours = clockView.hours
        molad.chalakim = clockView.chalakim

        hoursLabel.text = String(format: "%02i", clock.hours)
        chalakimLabel.text = String(format: "%0004i", clock.chalakim)
        updateSecularLabels()
    }

    internal func crossLeftToRight(clock: ClockView) {
        day += 1
        day %= 7
        dayLabel.text = hebrewDays[day]
    }

    internal func crossRightToLeft(clock: ClockView) {
        day -= 1
        if day < 0 { day += 7 }
        dayLabel.text = hebrewDays[day]
    }

    private func updateSecularLabels() {

    }
}

