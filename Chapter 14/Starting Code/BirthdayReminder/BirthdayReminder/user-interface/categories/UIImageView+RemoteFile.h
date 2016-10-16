//
//  UIImageView+RemoteFile.h
//  BirthdayReminder
//
//  Created by Nick Kuh on 13/08/2012.
//  Copyright (c) 2012 Nick Kuh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (RemoteFile)

- (void)setImageWithRemoteFileURL:(NSString *)urlString placeHolderImage:(UIImage *)placeholderImage;

@end
