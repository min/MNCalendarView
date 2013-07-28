//
//  MNCalendarViewLayout.m
//  MNCalendarView
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "MNCalendarViewLayout.h"

@implementation MNCalendarViewLayout

- (id)init {
  if (self = [super init]) {
    self.sectionInset = UIEdgeInsetsZero;
    self.minimumInteritemSpacing = 0.f;
    self.minimumLineSpacing = 0.f;
    self.headerReferenceSize = CGSizeMake(0.f, 44.f);
    self.footerReferenceSize = CGSizeZero;
  }
  return self;
}

@end
