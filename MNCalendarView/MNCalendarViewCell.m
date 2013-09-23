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
    self.titleLabel.highlightedTextColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.userInteractionEnabled = NO;
    self.titleLabel.backgroundColor = [UIColor clearColor];
    
    [self.contentView addSubview:self.titleLabel];
    
    self.selectedBackgroundView = [[UIView alloc] initWithFrame:self.bounds];
    self.selectedBackgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:0.23f green:0.61f blue:1.f alpha:1.f];
  }
  return self;
}

- (void)layoutSubviews {
  [super layoutSubviews];
  
  self.contentView.frame = self.bounds;
  self.selectedBackgroundView.frame = self.bounds;
}

- (void)drawRect:(CGRect)rect {
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGColorRef separatorColor = self.separatorColor.CGColor;
  
  CGFloat pixel = 1.f / [UIScreen mainScreen].scale;
  MNContextDrawLine(context,
                    CGPointMake(0.f, self.bounds.size.height),
                    CGPointMake(self.bounds.size.width, self.bounds.size.height),
                    separatorColor,
                    pixel);
}

@end



@implementation NSDate (Additional)

+ (NSDate *)dateFromDay:(NSInteger)day month:(NSInteger)month year:(NSInteger)year
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    
    [components setDay:day];
    
    if (month <= 0) {
        [components setMonth:12-month];
        [components setYear:year-1];
    } else if (month >= 13) {
        [components setMonth:month-12];
        [components setYear:year+1];
    } else {
        [components setMonth:month];
        [components setYear:year];
    }
    
    
    return [NSDate dateWithNoTime:[calendar dateFromComponents:components] middleDay:NO];
}
+ (NSDate *)dateWithNoTime:(NSDate *)dateTime middleDay:(BOOL)middle
{
    if( dateTime == nil ) {
        dateTime = [NSDate date];
    }
    
    NSCalendar       *calendar   = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    [calendar setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit
                             fromDate:dateTime];
    
    NSDate *dateOnly = [calendar dateFromComponents:components];
    
    if (middle)
        dateOnly = [dateOnly dateByAddingTimeInterval:(60.0 * 60.0 * 12.0)];           // Push to Middle of day.
    
    return dateOnly;
}

- (NSUInteger)numberOfDaysInMonth
{
    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:self];
    
    return days.length;
}


@end
