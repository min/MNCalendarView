//
//  MNFastDateEnumeration.h
//  MNCalendarView
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MNFastDateEnumeration : NSObject<NSFastEnumeration>

@property(nonatomic,strong,readonly) NSCalendar *calendar;
@property(nonatomic,strong,readonly) NSDate     *fromDate;
@property(nonatomic,strong,readonly) NSDate     *toDate;

@property(nonatomic,assign,readonly) NSCalendarUnit unit;

- (instancetype)initWithFromDate:(NSDate *)fromDate
                          toDate:(NSDate *)toDate
                        calendar:(NSCalendar *)calendar
                            unit:(NSCalendarUnit)unit;

@end
