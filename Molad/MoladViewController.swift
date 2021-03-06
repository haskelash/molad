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
    @IBOutlet private var rightClockView: ClockView!
    @IBOutlet private var leapYearControl: UISegmentedControl!

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

    private var molad: Molad!
    private var year: Year!

    private var relationToLeapYear: RelationToLeapYear {
        return RelationToLeapYear(rawValue: leapYearControl.selectedSegmentIndex)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        clockView.addTarget(self, action: #selector(valueChanged(clock:)), for: .valueChanged)
        clockView.addTarget(self, action: #selector(crossLeftToRight(clock:)), for: .crossLeftToRight)
        clockView.addTarget(self, action: #selector(crossRightToLeft(clock:)), for: .crossRightToLeft)

        rightClockView.addTarget(self, action: #selector(valueChanged(clock:)), for: .valueChanged)
        rightClockView.addTarget(self, action: #selector(crossLeftToRight(clock:)), for: .crossLeftToRight)
        rightClockView.addTarget(self, action: #selector(crossRightToLeft(clock:)), for: .crossRightToLeft)

        molad = Molad(1, clockView.hours, clockView.chalakim)
        year = Year(tishrei: molad, positionInCycle: relationToLeapYear)

        hoursLabel.text = String(format: "%02i", clockView.hours)
        chalakimLabel.text = String(format: "%0004i", clockView.chalakim)
        dayLabel.text = hebrewDays[molad.day]

        updateSecularLabels()
    }

    internal func valueChanged(clock: ClockView) {
        if clock === clockView {
            rightClockView.hoursAngle = clockView.hoursAngle + 1
            rightClockView.chalakimAngle = clockView.chalakimAngle - 1
        } else if clock === rightClockView {
            clockView.hoursAngle = rightClockView.hoursAngle - 1
            clockView.chalakimAngle = rightClockView.chalakimAngle + 1
        }

        molad.hours = clockView.hours
        molad.chalakim = clockView.chalakim

        hoursLabel.text = String(format: "%02i", clock.hours)
        chalakimLabel.text = String(format: "%0004i", clock.chalakim)

        updateSecularLabels()
    }

    internal func crossLeftToRight(clock: ClockView) {
        molad.day += 1
        molad.day %= 7
        dayLabel.text = hebrewDays[molad.day]

        valueChanged(clock: clock)
    }

    internal func crossRightToLeft(clock: ClockView) {
        molad.day -= 1
        if molad.day < 0 { molad.day += 7 }
        dayLabel.text = hebrewDays[molad.day]

        valueChanged(clock: clock)
    }

    @IBAction private func toggleLeapYear(control: UISegmentedControl) {
        year.positionInCycle = relationToLeapYear
    }

    private func updateSecularLabels() {
        secularDayLabel.text = molad.secularWeekday + ","
        secularHoursLabel.text = String(format: "%02i", molad.secularHours)
        minutesLabel.text = String(format: "%02i", molad.minutes)
        secondsLabel.text = String(format: "%02i", molad.seconds)
        amOrPmLabel.text = molad.pm ? "PM" : "AM"
        thirdsOfSecondsLabel.text = "\(molad.thirdsOfSeconds)"
    }
}

