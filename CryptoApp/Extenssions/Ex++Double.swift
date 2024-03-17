//
//  Ex++Double.swift
//  CryptoApp
//
//  Created by Mohamed Ali on 04/11/2023.
//

import Foundation

extension Double{
    
    /// Convert a Double into a Currency wiht 2 decimal places
    ///```
    /// Convert 1234.56 to $1,234.56
    ///```
   
    private var currencyFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.locale = .current  // current language
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        
        return formatter
       // return "\(formatter)$"
    }
    
    /// Convert a Double into a Currency as String wiht 2 decimal places
    ///```
    /// Convert 1234.56 to "$1,234.56"
    ///```
   
    
    func asAcurrencyWith2Decimal()-> String{
        let number = NSNumber(value: self)
        
        return currencyFormatter.string(from: number) ?? "$0.00"
    }
    ///````
    /// Convert 1.23456 to "1.23"
    ///```
    func asNumberString()-> String{
        return String(format: "%.2f", self)
    }
    
    // add percent symbol (%) to string number
    func asPercentString()->String{
        return asNumberString() + "%"
    }

    
    
}



/*
 
 NumberFormatter في Swift

 NumberFormatter هو أداة قوية في Swift لتنسيق الأرقام وعرضها بطرق مختلفة.

 ما الذي يفعله NumberFormatter؟

 يقوم بتحويل الأرقام من نوع NSNumber إلى تمثيل نصي.
 يقوم بتحويل التمثيلات النصية للأرقام إلى كائنات NSNumber.
 يوفر تنسيقات مختلفة للأرقام، مثل:
 الأعداد الصحيحة (مثال: 123)
 الأعداد العشرية (مثال: 123.45)
 النسب المئوية (مثال: 12%)
 الأرقام العلمية (مثال: 1.2345e+02)
 الكلمات (مثال: مائة وثلاثة وعشرون)
 استخدام NumberFormatter:

 Swift
 let numberFormatter = NumberFormatter()

 // تعيين تنسيق محدد
 numberFormatter.numberStyle = .decimal

 // تحويل رقم إلى نص
 let number = 12345.678
 let formattedNumber = numberFormatter.string(from: number as NSNumber)!

 // طباعة النص
 print(formattedNumber) // 12,345.68

 // تحويل نص إلى رقم
 let numberString = "12,345.68"
 let numberObject = numberFormatter.number(from: numberString)

 // طباعة الرقم
 print(numberObject!) // 12345.678
 يُرجى استخدام الرمز البرمجي بحذر.

 خصائص NumberFormatter:

 numberStyle: يحدد تنسيق الرقم (integer, decimal, percent, scientific, spellOut, ordinal).
 locale: يحدد لغة التنسيق (العربية، الإنجليزية، ...).
 maximumFractionDigits: يحدد أقصى عدد من الأرقام بعد الفاصلة العشرية.
 minimumFractionDigits: يحدد أدنى عدد من الأرقام بعد الفاصلة العشرية.
 groupingSeparator: يحدد فاصل المجموعات (مثل الفاصلة في 1,000,000).
 usesGroupingSeparator: يحدد ما إذا كان سيتم استخدام فاصل المجموعات.
 ملاحظة:

 تأكد من تعيين خصائص NumberFormatter بشكل صحيح قبل استخدامه.
 يمكنك استخدام NumberFormatter لتسهيل عرض الأرقام بطرق مختلفة في تطبيقك.
 
 */
