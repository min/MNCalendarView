//
//  MNFastDateEnumeration.m
//  MNCalendarView
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "MNFastDateEnumeration.h"

@interface MNFastDateEnumeration()

@property(nonatomic,strong,readwrite) NSCalendar       *calendar;
@property(nonatomic,strong,readwrite) NSDateComponents *components;
@property(nonatomic,strong,readwrite) NSDate           *fromDate;
@property(nonatomic,strong,readwrite) NSDate           *toDate;

@property(nonatomic,assign,readwrite) NSCalendarUnit    unit;

@end

@implementation MNFastDateEnumeration

- (instancetype)initWithFromDate:(NSDate *)fromDate
                          toDate:(NSDate *)toDate
                        calendar:(NSCalendar *)calendar
                            unit:(NSCalendarUnit)unit {
  if (self = [super init]) {
    self.fromDate   = fromDate;
    self.toDate     = toDate;
    self.calendar   = calendar;
    self.unit       = unit;
    self.components =
    [self.calendar components:unit
                     fromDate:self.fromDate
                       toDate:self.toDate
                      options:0];
  }
  return self;
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(__unsafe_unretained id [])buffer count:(NSUInteger)len {
  NSInteger unit = 0;
  
  if (state->state == 0) {
    state->mutationsPtr = &state->extra[0];
    switch (self.unit) {
      case NSYearCalendarUnit:
        unit = self.components.year;
        break;
      case NSMonthCalendarUnit:
        unit = self.components.month;
        break;
      default:
        unit = self.components.day;
        break;
    }
    state->extra[0] = unit;
  } else {
    unit = state->extra[0];
  }
  NSUInteger count = 0;
  
  if (state->state <= unit) {
    state->itemsPtr = buffer;
    while ( (state->state <= unit) && (count < len) ) {
      switch (self.unit) {
        case NSYearCalendarUnit:
          [self.components setYear:state->state];
          break;
        case NSMonthCalendarUnit:
          [self.components setMonth:state->state];
          break;
        default:
          [self.components setDay:state->state];
          break;
      }
      
      NSDate *date =
        [self.calendar dateByAddingComponents:self.components
                                       toDate:self.fromDate
                                      options:0];
      buffer[count] = date;
      state->state++;
      count++;
    }
  }
  return count;
}

@end
