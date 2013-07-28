//
//  MNViewController.m
//  MNCalendarViewExample
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "MNViewController.h"

@interface MNViewController ()

@end

@implementation MNViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  self.view.backgroundColor = UIColor.whiteColor;
  
  MNCalendarView *calendarView = [[MNCalendarView alloc] initWithFrame:self.view.bounds];
  calendarView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
  calendarView.backgroundColor = UIColor.whiteColor;
  
  [self.view addSubview:calendarView];
}

@end
