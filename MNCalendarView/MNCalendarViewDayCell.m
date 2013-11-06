//
//  MNCalendarViewDayCell.m
//  MNCalendarView
//
//  Created by Min Kim on 7/28/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "MNCalendarViewDayCell.h"

NSString *const MNCalendarViewDayCellIdentifier = @"MNCalendarViewDayCellIdentifier";

@interface MNCalendarViewDayCell()

@property(nonatomic,strong,readwrite) NSDate *date;
@property(nonatomic,strong,readwrite) NSDate *month;
@property(nonatomic,assign,readwrite) NSUInteger weekday;
@property(nonatomic,assign, readwrite) BOOL withinMonth;

@end

@implementation MNCalendarViewDayCell

- (void)setDate:(NSDate *)date
          month:(NSDate *)month
       calendar:(NSCalendar *)calendar {
  
  self.date     = date;
  self.month    = month;
  self.calendar = calendar;
  
  NSDateComponents *components =
  [self.calendar components:NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit
                   fromDate:self.date];
  
  NSDateComponents *monthComponents =
  [self.calendar components:NSMonthCalendarUnit
                   fromDate:self.month];
  
  self.weekday = components.weekday;
  self.enabled = self.withinMonth = (monthComponents.month == components.month);
  self.titleLabel.text = self.withinMonth ? [@(components.day) stringValue] : @"";

  [self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled {
  [super setEnabled:enabled && self.withinMonth];

  self.titleLabel.textColor =
  self.enabled ? UIColor.darkTextColor : UIColor.lightGrayColor;
  
  self.backgroundColor =
  self.enabled ? UIColor.whiteColor :
	  self.withinMonth ? [UIColor colorWithRed:.96f green:.96f blue:.96f alpha:1.f] :
		  [UIColor colorWithRed:.80f green:.80f blue:.80f alpha:1.f];
}

- (void)drawRect:(CGRect)rect {
  [super drawRect:rect];
  
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGColorRef separatorColor = self.separatorColor.CGColor;
  
  CGSize size = self.bounds.size;

  if (self.withinMonth && self.weekday != 1) {
	  CGFloat pixel = 1.f / [UIScreen mainScreen].scale;
      MNContextDrawLine(context,
                     CGPointMake(0, 0),
                     CGPointMake(0, size.height),
                     separatorColor,
                     pixel);

  }
}

@end
