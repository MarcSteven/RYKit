//
//  NSDate+CalendarView.swift
//  MCCalendarView
//
//  Created by Marc Steven on 2019/6/16.
//  Copyright © 2019 Marc Steven. All rights reserved.
//



import Foundation


public extension NSDate {
    
    /// day in calendar view
    /// - Parameter calendar: calendar
    /// - Returns: return date components
    func mcCalendarView_dayWithCalendar(calendar:NSCalendar)->NSDateComponents {
        return calendar.components([.year,.month,.day,.weekday,.calendar], from: self as Date) as NSDateComponents
    }
    
    /// month in calendar view
    /// - Parameter calendar: calendar
    /// - Returns: date components
    func mcCalendarView_mothWithCalendar(calendar:NSCalendar) ->NSDateComponents {
        return calendar.components([.calendar, .year, .month], from: self as Date) as NSDateComponents
        
    }
    
    /// day in past
    /// - Returns: if return true ,day is past, or false 
    func mcCalendarView_dayIsInPast() ->Bool {
        return self.timeIntervalSinceNow <= TimeInterval(-86400)
        
    }
}
