//
//  MNCalendarHeaderView.m
//  MNCalendarView
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "MNCalendarHeaderView.h"

NSString *const MNCalendarHeaderViewIdentifier = @"MNCalendarHeaderViewIdentifier";

@implementation MNCalendarHeaderView

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = UIColor.whiteColor;
  }
  return self;
}

@end
