//
//  MNViewController.m
//  MNCalendarViewExample
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "MNViewController.h"

@interface MNViewController () <MNCalendarViewDelegate>

@property(nonatomic,strong) NSCalendar *calendar;

@end

@implementation MNViewController

- (instancetype)initWithCalendar:(NSCalendar *)calendar {
  if (self = [super init]) {
    self.calendar = calendar;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = UIColor.whiteColor;
  
  MNCalendarView *calendarView = [[MNCalendarView alloc] initWithFrame:self.view.bounds];
  calendarView.calendar = self.calendar;
  calendarView.delegate = self;
  calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
  calendarView.backgroundColor = UIColor.whiteColor;
  
  [self.view addSubview:calendarView];
}

#pragma mark - MNCalendarViewDelegate

- (void)calendarView:(MNCalendarView *)calendarView didSelectDate:(NSDate *)date {
  NSLog(@"date selected: %@", date);
}

@end
