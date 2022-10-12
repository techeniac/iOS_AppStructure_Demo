//
//  DateUtilities.swift
//  CommonBase
//
//  Created by Romil Dhanani on 18/07/22.
//  Copyright © 2022 Romil's MACMini. All rights reserved.
//

import UIKit

class DateUtilities: NSObject {
    
    //MARK: Constant
    
    static var formatter: DateFormatter { return DateFormatter() }
    
    struct DateFormates {
        static let kLongDate = "dd MMM yyyy h:mm a"
        static let kLong24Date = "dd MMM yyyy H:mm"
        static let kTime  = "H:mm"
        static let kGetDate  = "dd MMM"
        static let kSourceFormat  = "yyyy-MM-dd'T'HH:mm:ssZ"
        static let kRegulardate   = "dd MMM yyyy"
        static let kGetAmPm   = "a"
        static let kTimeFormat   = "hh:mm a"
        static let kHourMinure  = "hh:mm"
        static let kHourMinuteFormate  = "h:mm"
        static let kDateFormatter   = "yyyy-MM-dd"
        static let kSalesFormat   = "yyyy/MM/dd"
        static let kNotificationDateFormat   = "dd/MM/yyyy"

        static let kCustomDate = "dd'th "
        static let kSavedSearch = "dd/MM/yyyy 'At' h:mm a"
        static let kDate = "dd/MM/yyyy"
        static let kMainSourceFormat  = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        static let kCreatedAt  = "MMM dd, yyyy"
        static let KOrderCreateAt = "MMM dd, yyyy h:mm a"

    }
    
    static func dateFromTimeStamp(timestamp:Double) -> Date?{
        
        if timestamp > 0.0{
            
            return Date(timeIntervalSince1970: timestamp / 1000)
        }
        return nil
    }
    
    static func convertToDate(dateStr: String) -> Date{
        let dateFormatter = DateFormatter()
        let date = dateFormatter.date(from: dateStr)
        return date ?? Date()
    }
    
    static func convertDateFromServerString(dateStr: String,sourceFormate : String? = "yyyy-MM-dd'T'HH:mm:ssZ") -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = sourceFormate//this your string date format
        let date = dateFormatter.date(from: dateStr)
        return date ?? Date()
    }
    
    static func convertDateFromStringWithFromat(dateStr: String, format : String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format //this your string date format
        let date = dateFormatter.date(from: dateStr)
        return date ?? Date()
    }
    
    static func convertStringFromDate(date: Date, format:String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: date)
    }
    
    static func convertdateSourceStringFromDate(dateStr: String, format:String) -> Date{
        let dat = self.convertDateFromServerString(dateStr: dateStr)
        let str = self.convertStringFromDate(date: dat, format: self.DateFormates.kRegulardate)
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = self.DateFormates.kRegulardate
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        let date = dateFormatter.date(from: str)!
        return date
    }
    
    static func convertStringDateintoStringWithFormat(dateStr : String,sourceFormat : String = "yyyy-MM-dd'T'HH:mm:ssZ", destinationFormat : String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = sourceFormat
        let myDate = dateFormatter.date(from: dateStr)
        
        dateFormatter.dateFormat = destinationFormat
        
        if myDate == nil {
            return ""
        }
        
        let somedateString = dateFormatter.string(from: myDate!)
        return somedateString
    }
    
    static func convertStringDateintoStringWithFormat(dateStr : String, format : String) -> String{
        
        if dateStr.count > 0 {
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
            let myDate = dateFormatter.date(from: dateStr)
            
            dateFormatter.dateFormat = format
            let somedateString = dateFormatter.string(from: myDate!)
            return somedateString
        }
        return ""
    }
    
    static func convertToISOFormat(dateStr: Date) -> String {
        let dateFormatter = DateFormatter()
        let calendar = Calendar.init(identifier: .gregorian)
        dateFormatter.calendar = calendar
        let locale: NSLocale? = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.locale = locale! as Locale
        let timeZone = NSTimeZone(forSecondsFromGMT: 0)
        dateFormatter.timeZone = timeZone as TimeZone
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"
        let myDateString: String = dateFormatter.string(from: dateStr)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.Z"
        return myDateString
    }
    
    static func startOfTheDaySecondsFromDate(date: Date) -> Int {
        
        let truncated = Calendar.current.startOfDay(for: date)
    
        let seconds = truncated.timeIntervalSince1970
        return Int(seconds)
    }
    
    static func startOfTheDayDate(date: Date) -> Date {
        let truncated = Calendar.current.startOfDay(for: date)
        
        return truncated
        /*
        var comp: DateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let calendar = Calendar.init(identifier: .gregorian)
        comp.calendar = calendar
        let timeZone = NSTimeZone(forSecondsFromGMT: 0)
        comp.timeZone = timeZone as TimeZone
        return Calendar.current.date(from: comp)!*/
    }
    
    static func endOfTheDayDate(startOfDate: Date) -> Date {
        let calendar = Calendar.current
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return calendar.date(byAdding: components, to: startOfDate) ?? Date()
    }
    
    static func timeStampFromDate(date: Date) -> Int {
        
        //Convert to timestamp
        let seconds = date.timeIntervalSince1970
        return Int(seconds)
    }
    
    static func getFomattedDate(date:Date) -> String{
        var dateStr = ""
        
        let date1 = date.startOfDay
        let currentDate = Date().startOfDay
        
        let diffInDays = Calendar.current.dateComponents([.day], from: date1, to: currentDate).day
        if diffInDays == 0{
            
            dateStr = "Today"
            
        }else if diffInDays == 1{
            
            dateStr = "Yesterday"
            
        }else if diffInDays! >= 2 && diffInDays! <= 6{
            
            //same week
            
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE"
            let d1 = formatter.string(from: date)
            dateStr = d1
            
        }else if diffInDays! > 365{
            
            //diff year
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            let d1 = formatter.string(from: date)
            dateStr = d1
            
        }else{
            
            //same year show
            let formatter = DateFormatter()
            formatter.dateFormat = "dd MMM yyyy"
            let d1 = formatter.string(from: date)
            dateStr = d1
        }
        
        return dateStr
    }
    
    //Iso Format Current Date
    static func getIsoFormateCurrentDate() -> String? {
        let myDate = Date()
        let dateFormatter = DateFormatter()
        let calendar = Calendar(identifier: .gregorian)
        dateFormatter.calendar = calendar
        let locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.locale = locale as Locale
        let timeZone = NSTimeZone(forSecondsFromGMT: 0)
        dateFormatter.timeZone = timeZone as TimeZone
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"
        let myDateString = dateFormatter.string(from: myDate)
        return myDateString
    }
    
    static func getDateFromTimeStamp(timestamp:Double, dateFromate:String) -> String {
        let date = Date(timeIntervalSince1970: timestamp)
        let dateFormatter = DateFormatter()
        let timeZone = NSTimeZone(forSecondsFromGMT: 0)
        dateFormatter.timeZone = timeZone as TimeZone //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = dateFromate //Specify your format that you want
        return dateFormatter.string(from: date)
    }
    
    //TimeStamp
    static func getCurrentTimeStamp() -> Double {
        
        return Date().timeIntervalSince1970 * 1000
    }
    
    static func getDayFromDate(_ date : Date) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        let dayInWeek = dateFormatter.string(from: date)
        return dayInWeek
    }
    
    static func timeGapBetweenDates(date1 : Date,date2 : Date) -> String{

        let str1 = DateUtilities.convertStringFromDate(date: date1, format: DateUtilities.DateFormates.kTimeFormat)
        let str2 = DateUtilities.convertStringFromDate(date: date2, format: DateUtilities.DateFormates.kTimeFormat)

        let dte1 = DateUtilities.convertDateFromStringWithFromat(dateStr: str1, format: DateUtilities.DateFormates.kTimeFormat)

        let dte2 = DateUtilities.convertDateFromStringWithFromat(dateStr: str2, format: DateUtilities.DateFormates.kTimeFormat)

        let distanceBetweenDates: TimeInterval? = dte1.timeIntervalSince(dte2)

        let minBetweenDates = Int(distanceBetweenDates!)
       
        let hour = Int(minBetweenDates / 3600)
        let minute = Int((minBetweenDates / 60) % 60)
        
        var str : String = ""
        if hour > 0{
            str.append("\(hour) hours ")
        }
        
        if minute > 0{
            str.append("\(minute) minutes ")
        }
        
        str.append("left")
        return str
    }
    
    func convertCustomDateFormate(date : Date) -> String {
        // Day
        let calendar = Calendar.current
        let anchorComponents = calendar.dateComponents([.day, .month, .year], from: date)
        
        // Formate
        let dateFormate = DateFormatter()
        dateFormate.dateFormat = "MMM yyyy"
        let newDate = dateFormate.string(from: date)
        
        var day  = "\(anchorComponents.day!)"
        switch (day) {
        case "1" , "21" , "31":
            day.append("st")
        case "2" , "22":
            day.append("nd")
        case "3" ,"23":
            day.append("rd")
        default:
            day.append("th")
        }
        return day + " " + newDate
    }
    
    class func getDayAndHours(startDate: Date?,endDate: Date?, isDay: Bool, isFromCancellation: Bool = false) -> String? {
        
        let dateRangeStart = DateUtilities.convertStringFromDate(date: startDate!, format: DateUtilities.DateFormates.kLongDate)
         let dateRangeEnd = DateUtilities.convertStringFromDate(date: endDate!, format: DateUtilities.DateFormates.kLongDate)

         
         let start = DateUtilities.convertDateFromStringWithFromat(dateStr: dateRangeStart, format: DateUtilities.DateFormates.kLongDate)
         let end = DateUtilities.convertDateFromStringWithFromat(dateStr: dateRangeEnd, format: DateUtilities.DateFormates.kLongDate)
        
        var components: DateComponents?
        var days: Int
        var hour: Int
        var minutes: Int
        var durationString: String?
        
        components = Calendar.current.dateComponents([.day, .hour, .minute], from: start, to: end)
        
        days = components?.day ?? 0
        hour = components?.hour ?? 0
        minutes = components?.minute ?? 0
        
        if isDay {
            if days > 0 {
                
                if days > 1 {
                    durationString = "\(days) days"
                } else {
                    durationString = "\(days) day"
                }
                return durationString
            }
        } else {
            if hour > 0 {
                
                if hour > 1 {
                    if isFromCancellation {
                        durationString = "\(hour) Hrs"
                    } else {
                        durationString = "\(hour) hours"
                    }
                } else {
                    if isFromCancellation {
                        durationString = "\(hour) Hr"
                    } else {
                        durationString = "\(hour) hour"
                    }
                }
                return durationString
            }
            
            if minutes > 0 {
                
                if minutes > 1 {
                    durationString = "\(minutes) minutes"
                } else {
                    durationString = "\(minutes) minute"
                }
                return durationString
            }
        }
        return ""
    }
}

extension Date {
    
    // date with add number of days
    func dateBeforeOrAfterFromToday(numberOfDays :Int) -> Date {
        
        let resultDate = Calendar.current.date(byAdding: .day, value: numberOfDays, to: Date())!
        return resultDate
    }
    
    func addMonth(noOfMonth :Int) -> Date {
        
        let resultDate = Calendar.current.date(byAdding: .month, value: noOfMonth, to: Date())!
        return resultDate
    }
    
    func addHours(noOfHours :Int) -> Date {
        
        let resultDate = Calendar.current.date(byAdding: .hour, value: noOfHours, to: Date())!
        return resultDate
    }
    
    var startOfDay: Date {
        return Calendar.current.startOfDay(for: self)
    }
    
    var endOfDay: Date? {
        var components = DateComponents()
        components.day = 1
        components.second = -1
        return Calendar.current.date(byAdding: components, to: startOfDay)
    }
    
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    
    var dayOfWeek: String {
        let calendar = Calendar.autoupdatingCurrent
        return calendar.weekdaySymbols[calendar.component(.weekday, from: self) - 1]
    }
    
    func isFutureDate(toDate: Date) -> Bool {
        return (self <= toDate)
    }
    
    func isPreviousDate(toDate: Date) -> Bool {
        return (self >= toDate)
    }
    
    func getDayName() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EE"
        return dateFormatter.string(from: self)
    }
}

extension TimeZone {

    //Get Current Time Offset In Minutes
    func offsetFromUTC() -> String {
        
        return "\(self.secondsFromGMT() / 60)"
       
    }
}
