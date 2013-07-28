//
//  MNFastDateEnumeration.h
//  MNCalendarView
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNFastDateEnumeration : NSObject<NSFastEnumeration>

@property(nonatomic,assign,readonly) NSCalendar *calendar;
@property(nonatomic,strong,readonly) NSDate *startDate;
@property(nonatomic,strong,readonly) NSDate *endDate;
@property(nonatomic,assign,readonly) NSCalendarUnit unit;

- (instancetype)initWithStartDate:(NSDate *)startDate
                          endDate:(NSDate *)endDate
                         calendar:(NSCalendar *)calendar
                             unit:(NSCalendarUnit)unit;

@end
