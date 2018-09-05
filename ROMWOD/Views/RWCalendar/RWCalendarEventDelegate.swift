//
//  RWCalendarDelegate.swift
//  ROMWOD
//
//  Created by Tim Ludikar on 2018-09-05.
//  Copyright © 2018 Tim Ludikar. All rights reserved.
//

import Foundation

protocol RWCalendarEventDelegate: class {
    func calendarEvent(_ calendarEvent: RWCalendar, didSelectItemAt indexPath: Int)
}
