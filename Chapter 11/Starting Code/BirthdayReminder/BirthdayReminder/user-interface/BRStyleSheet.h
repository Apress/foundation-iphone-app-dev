//
//  BRStyleSheet.h
//  BirthdayReminder
//
//  Created by Nick Kuh on 27/07/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : int {
    BRLabelTypeName = 0,
    BRLabelTypeBirthdayDate,
    BRLabelTypeDaysUntilBirthday,
    BRLabelTypeDaysUntilBirthdaySubText,
    BRLabelTypeLarge
}BRLabelType;

@interface BRStyleSheet : NSObject

+(void)initStyles;
+(void)styleLabel:(UILabel *)label withType:(BRLabelType)labelType;
+(void)styleTextView:(UITextView *)textView;
+(void)styleRoundCorneredView:(UIView *)view;

@end
