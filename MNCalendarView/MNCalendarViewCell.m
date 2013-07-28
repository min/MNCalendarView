//
//  MNCalendarViewCell.m
//  MNCalendarView
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "MNCalendarViewCell.h"

void MNContextDrawLine(CGContextRef c, CGPoint start, CGPoint end, CGColorRef color, CGFloat lineWidth) {
  CGContextSetAllowsAntialiasing(c, false);
  CGContextSetStrokeColorWithColor(c, color);
  CGContextSetLineWidth(c, lineWidth);
  CGContextMoveToPoint(c, start.x, start.y - (lineWidth/2.f));
  CGContextAddLineToPoint(c, end.x, end.y - (lineWidth/2.f));
  CGContextStrokePath(c);
  CGContextSetAllowsAntialiasing(c, true);
}

NSString *const MNCalendarViewCellIdentifier = @"MNCalendarViewCellIdentifier";

@interface MNCalendarViewCell()

@property(nonatomic,strong,readwrite) UILabel *titleLabel;

@property(nonatomic,strong,readwrite) NSDate     *date;
@property(nonatomic,strong,readwrite) NSDate     *month;
@property(nonatomic,strong,readwrite) NSCalendar *calendar;

@end

@implementation MNCalendarViewCell

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.whiteColor;
    self.contentView.backgroundColor = UIColor.clearColor;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
    self.titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.titleLabel.font = [UIFont systemFontOfSize:14.f];
    self.titleLabel.textColor = [UIColor darkTextColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.userInteractionEnabled = NO;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.titleLabel];
    
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.selectedBackgroundView.backgroundColor = UIColor.blueColor;
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  self.contentView.frame = self.bounds;
  self.selectedBackgroundView.frame = self.bounds;
}

- (void)setDate:(NSDate *)date
          month:(NSDate *)month
       calendar:(NSCalendar *)calendar {
  
  self.date     = date;
  self.month    = month;
  self.calendar = calendar;
  
  NSDateComponents *components =
    [self.calendar components:NSMonthCalendarUnit|NSDayCalendarUnit
                     fromDate:self.date];
  
  NSDateComponents *monthComponents =
    [self.calendar components:NSMonthCalendarUnit
                     fromDate:self.month];
  
  self.titleLabel.text = [NSString stringWithFormat:@"%d", components.day];
  self.enabled = monthComponents.month == components.month;
  
  [self setNeedsDisplay];
}

- (void)setEnabled:(BOOL)enabled {
  _enabled = enabled;
  
  self.titleLabel.textColor =
    self.enabled ? UIColor.darkTextColor : UIColor.lightGrayColor;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGColorRef separatorColor = self.separatorColor.CGColor;
  
  MNContextDrawLine(context,
                    CGPointMake(0.f, 0.5f),
                    CGPointMake(self.bounds.size.width, 0.5f),
                    separatorColor,
                    0.5f);
  
  MNContextDrawLine(context,
                    CGPointMake(self.bounds.size.width - 0.5f, 0.5f),
                    CGPointMake(self.bounds.size.width - 0.5f, self.bounds.size.height),
                    separatorColor,
                    0.5f);
}

@end
