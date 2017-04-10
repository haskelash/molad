//
//  Year.swift
//  Molad
//
//  Created by Haskel Ash on 4/10/17.
//  Copyright © 2017 HaskelAsh. All rights reserved.
//

import Foundation

struct Year {
    var tishrei: Molad
    var positionInCycle: RelationToLeapYear

    var kviah: (day: Int, length: Int, isLeapYear: Bool) {
        var firstTwoValues: (day: Int, length: Int)!
        switch positionInCycle {
        case .leapYear:
            firstTwoValues = kviahAsLeapYear()
        case .after:
            firstTwoValues = kviahAsAfterLeapYear()
        case .between:
            firstTwoValues = kviahAsBetweenLeapYears()
        case .before:
            firstTwoValues = kviahAsBeforeLeapYear()
        }

        return (day: firstTwoValues.day,
                length: firstTwoValues.length,
                isLeapYear: positionInCycle == .leapYear)
    }

    private func kviahAsLeapYear() -> (day: Int, length: Int) {
        if        tishrei >= Molad(0, 18, 000) && tishrei < Molad(1, 20, 491) {
            return (day: 2, length: 383)
        } else if tishrei >= Molad(1, 20, 491) && tishrei < Molad(2, 18, 000) {
            return (day: 2, length: 385)
        } else if tishrei >= Molad(2, 18, 000) && tishrei < Molad(3, 18, 000) {
            return (day: 3, length: 384)
        } else if tishrei >= Molad(3, 18, 000) && tishrei < Molad(4, 11, 695) {
            return (day: 5, length: 383)
        } else if tishrei >= Molad(4, 01, 695) && tishrei < Molad(5, 18, 000) {
            return (day: 5, length: 385)
        } else if tishrei >= Molad(5, 18, 000) && tishrei < Molad(6, 20, 491) {
            return (day: 0, length: 383)
        } else if tishrei >= Molad(6, 20, 491) || tishrei < Molad(0, 18, 000) {
            return (day: 0, length: 385)
        }
        return (day: -1, length: -1)
    }

    private func kviahAsAfterLeapYear() -> (day: Int, length: Int) {
        if        tishrei >= Molad(0, 18, 000) && tishrei < Molad(1, 09, 204) {
            return (day: 2, length: 353)
        } else if tishrei >= Molad(1, 09, 204) && tishrei < Molad(2, 15, 589) {
            return (day: 2, length: 355)
        } else if tishrei >= Molad(2, 15, 589) && tishrei < Molad(3, 09, 204) {
            return (day: 3, length: 354)
        } else if tishrei >= Molad(3, 09, 204) && tishrei < Molad(5, 09, 204) {
            return (day: 5, length: 354)
        } else if tishrei >= Molad(5, 09, 204) && tishrei < Molad(5, 18, 000) {
            return (day: 5, length: 355)
        } else if tishrei >= Molad(5, 18, 000) && tishrei < Molad(6, 00, 408) {
            return (day: 0, length: 353)
        } else if tishrei >= Molad(6, 00, 408) || tishrei < Molad(0, 18, 000) {
            return (day: 0, length: 355)
        }
        return (day: -1, length: -1)
    }

    private func kviahAsBeforeLeapYear() -> (day: Int, length: Int) {
        if        tishrei >= Molad(0, 18, 000) && tishrei < Molad(1, 09, 204) {
            return (day: 2, length: 353)
        } else if tishrei >= Molad(1, 09, 204) && tishrei < Molad(2, 18, 000) {
            return (day: 2, length: 355)
        } else if tishrei >= Molad(2, 18, 000) && tishrei < Molad(3, 09, 204) {
            return (day: 3, length: 354)
        } else if tishrei >= Molad(3, 09, 204) && tishrei < Molad(5, 09, 204) {
            return (day: 5, length: 354)
        } else if tishrei >= Molad(5, 09, 204) && tishrei < Molad(5, 18, 000) {
            return (day: 5, length: 355)
        } else if tishrei >= Molad(5, 18, 000) && tishrei < Molad(6, 09, 204) {
            return (day: 0, length: 353)
        } else if tishrei >= Molad(6, 09, 204) || tishrei < Molad(0, 18, 000) {
            return (day: 0, length: 355)
        }
        return (day: -1, length: -1)
    }

    private func kviahAsBetweenLeapYears() -> (day: Int, length: Int) {
        if        tishrei >= Molad(0, 18, 000) && tishrei < Molad(1, 09, 204) {
            return (day: 2, length: 353)
        } else if tishrei >= Molad(1, 09, 204) && tishrei < Molad(2, 15, 589) {
            return (day: 2, length: 355)
        } else if tishrei >= Molad(2, 15, 589) && tishrei < Molad(3, 09, 204) {
            return (day: 3, length: 354)
        } else if tishrei >= Molad(3, 09, 204) && tishrei < Molad(5, 09, 204) {
            return (day: 5, length: 354)
        } else if tishrei >= Molad(5, 09, 204) && tishrei < Molad(5, 18, 000) {
            return (day: 5, length: 355)
        } else if tishrei >= Molad(5, 18, 000) && tishrei < Molad(6, 09, 204) {
            return (day: 0, length: 353)
        } else if tishrei >= Molad(6, 09, 204) || tishrei < Molad(0, 18, 000) {
            return (day: 0, length: 355)
        }
        return (day: -1, length: -1)
    }
}

enum RelationToLeapYear {
    case before, between, after, leapYear
}
