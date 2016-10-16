//
//  BRDSettings.h
//  BirthdayReminder
//
//  Created by Nick Kuh on 13/08/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

typedef enum : int {
    BRDaysBeforeTypeOnBirthday = 0,
    BRDaysBeforeTypeOneDay,
    BRDaysBeforeTypeTwoDays,
    BRDaysBeforeTypeThreeDays,
    BRDaysBeforeTypeFiveDays,
    BRDaysBeforeTypeOneWeek,
    BRDaysBeforeTypeTwoWeeks,
    BRDaysBeforeTypeThreeWeeks
}BRDaysBeforeType;

#import <Foundation/Foundation.h>

@class BRDBirthday;

@interface BRDSettings : NSObject

+ (BRDSettings*)sharedInstance;

@property (nonatomic) int notificationHour;
@property (nonatomic) int notificationMinute;
@property (nonatomic) BRDaysBeforeType daysBefore;

-(NSString *) titleForNotificationTime;
-(NSString *) titleForDaysBefore:(BRDaysBeforeType)daysBefore;

-(NSDate *) reminderDateForNextBirthday:(NSDate *)nextBirthday;
-(NSString *) reminderTextForNextBirthday:(BRDBirthday *)birthday;


@end
