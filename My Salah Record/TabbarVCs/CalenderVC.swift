//
//  CalenderVC.swift
//  My Salah Record
//
//  Created by Nasir Khan on 14/11/2018.
//  Copyright © 2018 Techwisely. All rights reserved.
//

import UIKit

class HomeVC : UIViewController {
    
}




@objc protocol KDCalendarViewDataSource {
    func startDate() -> NSDate?
    func endDate() -> NSDate?
}
//@objc protocol KDCalendarViewDelegate {
//    optional func calendar(calendar : KDCalendarView, canSelectDate date : NSDate) -> Bool
//    func calendar(calendar : KDCalendarView, didScrollToMonth date : NSDate)
//    func calendar(calendar : KDCalendarView, didSelectDate date : NSDate)
//}
