//
//  MNCalendarWeekdayViewCell.m
//  MNCalendarView
//
//  Created by Min Kim on 7/28/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "MNCalendarViewWeekdayCell.h"

NSString *const MNCalendarViewWeekdayCellIdentifier = @"MNCalendarViewWeekdayCellIdentifier";

@implementation MNCalendarViewWeekdayCell

- (void)setWeekday:(NSUInteger)weekday {
  _weekday = weekday;
  
  [self setNeedsDisplay];
}

@end
