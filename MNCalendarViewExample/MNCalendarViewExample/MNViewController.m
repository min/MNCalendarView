//
//  MNViewController.m
//  MNCalendarViewExample
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "MNViewController.h"

@interface MNViewController () <MNCalendarViewDelegate>

@property(nonatomic,strong) NSCalendar     *calendar;
@property(nonatomic,strong) MNCalendarView *calendarView;
@property(nonatomic,strong) NSDate         *currentDate;

@end

@implementation MNViewController

- (instancetype)initWithCalendar:(NSCalendar *)calendar title:(NSString *)title {
  if (self = [super init]) {
    self.calendar = calendar;
    self.title = title;
  }
  return self;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = UIColor.whiteColor;
  
  self.currentDate = [NSDate date];

  self.calendarView = [[MNCalendarView alloc] initWithFrame:self.view.bounds];
  self.calendarView.calendar = self.calendar;
  self.calendarView.selectedDate = [NSDate date];
  self.calendarView.delegate = self;
  self.calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
  self.calendarView.backgroundColor = UIColor.whiteColor;
  
  [self.view addSubview:self.calendarView];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
  [self.calendarView.collectionView.collectionViewLayout invalidateLayout];
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
  [self.calendarView reloadData];
}

#pragma mark - MNCalendarViewDelegate

- (void)calendarView:(MNCalendarView *)calendarView didSelectDate:(NSDate *)date {
  NSLog(@"date selected: %@", date);
}

- (BOOL)calendarView:(MNCalendarView *)calendarView shouldSelectDate:(NSDate *)date {
  NSTimeInterval timeInterval = [date timeIntervalSinceDate:self.currentDate];

  if (timeInterval > MN_WEEK && timeInterval < (MN_WEEK * 2)) {
    return NO;
  }

  return YES;
}

@end
