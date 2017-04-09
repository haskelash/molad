//
//  Molad.swift
//  Molad
//
//  Created by Haskel Ash on 4/9/17.
//  Copyright © 2017 HaskelAsh. All rights reserved.
//

import Foundation

struct Molad {
    var day: Int
    var hours: Int
    var chalakim: Int

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
