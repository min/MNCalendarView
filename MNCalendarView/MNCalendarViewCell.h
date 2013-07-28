//
//  MNCalendarViewCell.h
//  MNCalendarView
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const MNCalendarViewCellIdentifier;

@interface MNCalendarViewCell : UICollectionViewCell

@property(nonatomic,strong,readonly) NSDate     *date;
@property(nonatomic,strong,readonly) NSDate     *month;
@property(nonatomic,strong,readonly) NSCalendar *calendar;

@property(nonatomic,assign,getter = isEnabled) BOOL enabled;

@property(nonatomic,strong) UIColor *separatorColor;

- (void)setDate:(NSDate *)date
          month:(NSDate *)month
       calendar:(NSCalendar *)calendar;

@end
