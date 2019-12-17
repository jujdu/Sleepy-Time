//
//  supportfile.swift
//  Sleepy-time
//
//  Created by Michael Sidoruk on 11.12.2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//
//
//import Foundation
//
////MARK: - Добавление данных в CoreDate длинным путем
//let entity = NSEntityDescription.entity(forEntityName: "ManagedSettings", in: context)
//let taskObject = NSManagedObject(entity: entity!, insertInto: context) as! ManagedSettings
//taskObject.snoozeTime = 15
//taskObject.fallAsleepTime = 24
//taskObject.ringtone = Data()
//taskObject.isVibrated = false
//taskObject.alarmVolume = 1
//
//do {
//    try context.save()
//    settings = taskObject
//    print(settings)
//} catch {
//    print(error.localizedDescription)
//}
//
//
//
//        let myMutableString = NSMutableAttributedString(string: "ZZZ",
//                                                        attributes: [NSAttributedString.Key.font: UIFont(name: AppFonts.avenirBook, size: 12)!,
//                                                                     NSAttributedString.Key.foregroundColor: UIColor.black])
//        myMutableString.addAttributes([NSAttributedString.Key.font: UIFont(name: AppFonts.avenirBook, size: 15)!],
//                                      range: NSRange(location: 1, length: 1))
//        myMutableString.addAttributes([NSAttributedString.Key.font: UIFont(name: AppFonts.avenirBook, size: 18)!],
//                                      range: NSRange(location: 2, length: 1))
//        button.setAttributedTitle(myMutableString, for: .normal)
