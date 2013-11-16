//
//  NSDate+MNAdditions.h
//  MNCalendarView
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (MNAdditions)

- (NSDate *)firstDateOfWeekWithCalendar:(NSCalendar *)calendar;

- (NSDate *)lastDateOfWeekWithCalendar:(NSCalendar *)calendar;

- (NSDate *)firstDateOfMonthWithCalendar:(NSCalendar *)calendar;

- (NSDate *)lastDateOfMonthWithCalendar:(NSCalendar *)calendar;

//- (instancetype)mn_firstDateOfMonth:(NSCalendar *)calendar;
//
//- (instancetype)mn_lastDateOfMonth:(NSCalendar *)calendar;
//
- (instancetype)mn_beginningOfDay:(NSCalendar *)calendar;

- (instancetype)mn_dateWithDay:(NSUInteger)day calendar:(NSCalendar *)calendar;

@end
