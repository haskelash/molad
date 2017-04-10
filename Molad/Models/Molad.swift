//
//  Molad.swift
//  Molad
//
//  Created by Haskel Ash on 4/9/17.
//  Copyright © 2017 HaskelAsh. All rights reserved.
//

import Foundation

class Molad {
    var day: Int
    var hours: Int
    var chalakim: Int

    init(_ day: Int, _ hours: Int, _ chalakim: Int) {
        self.day = day
        self.hours = hours
        self.chalakim = chalakim
    }

    static func > (left: Molad, right: Molad) -> Bool {
        if left.day > right.day { return true}
        else if right.day > left.day { return false }
        else {
            if left.hours > right.hours { return true }
            else if right.hours > left.hours { return false }
            else {
                if left.chalakim > right.chalakim { return true }
                else { return false }
            }
        }
    }

    static func == (left: Molad, right: Molad) -> Bool {
        return left.day == right.day
            && left.hours == right.hours
            && left.chalakim == right.chalakim ? true : false
    }

    static func >= (left: Molad, right: Molad) -> Bool {
        return left > right || left == right ? true : false
    }

    static func < (left: Molad, right: Molad) -> Bool {
        return right > left ? true : false
    }

    static func <= (left: Molad, right: Molad) -> Bool {
        return right >= left ? true : false
    }

    private let secularDays = ["Sat", "Sun", "Mon", "Tue", "Wed", "Thu", "Fri"]

    var secularWeekday: String {
        return hours >= 6 ? secularDays[day] : secularDays[(day+6)%7]
    }

    var secularHours: Int {
        let secularHours = (hours + 18) % 12 // hour 0 = secular hour 18
        return secularHours == 0 ? 12 : secularHours
    }

    var minutes: Int {
        return chalakim/18 // 18 chalakim = 1 minute
    }

    var seconds: Int {
        return chalakim % 18 * 10 / 3 // 3 chalakim = 10 seconds
    }

    var thirdsOfSeconds: Int {
        return chalakim%18*10 % 3 // 10/3 seconds = 1 chelek
    }

    var pm: Bool {
        return (hours + 18) % 24 >= 12 // hour 0 = secular hour 18
    }
}
