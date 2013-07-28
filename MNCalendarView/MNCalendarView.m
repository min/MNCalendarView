//
//  MNCalendarView.m
//  MNCalendarView
//
//  Created by Min Kim on 7/23/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import "MNCalendarView.h"
#import "MNCalendarViewLayout.h"
#import "MNCalendarViewCell.h"
#import "MNCalendarHeaderView.h"

#import "NSDate+MNAdditions.h"
#import "MNFastDateEnumeration.h"

@interface MNCalendarView() <UICollectionViewDataSource, UICollectionViewDelegate>

@property(nonatomic,strong,readwrite) UICollectionView           *collectionView;
@property(nonatomic,strong,readwrite) UICollectionViewFlowLayout *layout;

@property(nonatomic,strong,readwrite) NSArray          *monthDates;
@property(nonatomic,assign,readwrite) NSUInteger        numberOfDaysInWeek;

- (NSDate *)firstVisibleDateOfMonth:(NSDate *)date;
- (NSDate *)lastVisibleDateOfMonth:(NSDate *)date;

@end

@implementation MNCalendarView

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.calendar  = [NSCalendar currentCalendar];
    self.startDate = [[NSDate date] mn_beginningOfDay:self.calendar];
    self.endDate   = [self.startDate dateByAddingTimeInterval:MN_YEAR * 4];
    
    self.numberOfDaysInWeek = 7;
    
    self.layout = [[MNCalendarViewLayout alloc] init];

    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
    self.collectionView.backgroundColor = UIColor.redColor;
    self.collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    self.collectionView.allowsSelection = YES;
    self.collectionView.allowsMultipleSelection = YES;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerClass:MNCalendarViewCell.class
            forCellWithReuseIdentifier:MNCalendarViewCellIdentifier];
    
    [self.collectionView registerClass:MNCalendarHeaderView.class
            forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                   withReuseIdentifier:MNCalendarHeaderViewIdentifier];
    
    self.collectionView.delegate = self;
    
    [self addSubview:self.collectionView];
    
    NSDictionary *views = @{@"collectionView" : self.collectionView};
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[collectionView]|"
                                             options:0
                                             metrics:nil
                                               views:views]];
    
    [self addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[collectionView]|"
                                             options:0
                                             metrics:nil
                                               views:views]
     ];
    [self reloadData];
  }
  return self;
}

- (void)reloadData {
  NSMutableArray *monthDates = @[].mutableCopy;
  MNFastDateEnumeration *enumeration =
    [[MNFastDateEnumeration alloc] initWithStartDate:[self.startDate mn_firstDateOfMonth:self.calendar]
                                             endDate:[self.endDate mn_firstDateOfMonth:self.calendar]
                                            calendar:self.calendar
                                                unit:NSCalendarUnitMonth];
  for (NSDate *date in enumeration) {
    [monthDates addObject:date];
  }
  self.monthDates = monthDates;
  
  [self.collectionView reloadData];
}

- (void)setCalendar:(NSCalendar *)calendar {
  _calendar = calendar;
}

- (NSDate *)firstVisibleDateOfMonth:(NSDate *)date {
  date = [date mn_firstDateOfMonth:self.calendar];
  
  NSDateComponents *components =
    [self.calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit
                fromDate:date];
  
  return [[date mn_dateWithDay:-((components.weekday-1) % self.numberOfDaysInWeek) calendar:self.calendar] dateByAddingTimeInterval:MN_DAY];
}

- (NSDate *)lastVisibleDateOfMonth:(NSDate *)date {
  date = [date mn_lastDateOfMonth:self.calendar];
  
  NSDateComponents *components =
  [self.calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit
                   fromDate:date];
  
  return [date mn_dateWithDay:components.day + (self.numberOfDaysInWeek - 1) - ((components.weekday-1) % self.numberOfDaysInWeek) calendar:self.calendar];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
  return self.monthDates.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
  MNCalendarHeaderView *headerView =
  [collectionView dequeueReusableSupplementaryViewOfKind:kind
                                     withReuseIdentifier:MNCalendarHeaderViewIdentifier
                                            forIndexPath:indexPath];
  return headerView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
  NSDate *monthDate = self.monthDates[section];
  
  NSDateComponents *components =
  [self.calendar components:NSDayCalendarUnit
                   fromDate:[self firstVisibleDateOfMonth:monthDate]
                     toDate:[self lastVisibleDateOfMonth:monthDate]
                    options:0];
  
  return components.day + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {

  MNCalendarViewCell *cell =
  [collectionView dequeueReusableCellWithReuseIdentifier:MNCalendarViewCellIdentifier
                                            forIndexPath:indexPath];
  
  NSDate *monthDate =
    [self firstVisibleDateOfMonth:self.monthDates[indexPath.section]];
  
  NSDate *date =
    [monthDate dateByAddingTimeInterval:indexPath.item * MN_DAY];
  
  NSDateComponents *components =
    [self.calendar components:NSDayCalendarUnit fromDate:date];
  
  cell.titleLabel.text = [NSString stringWithFormat:@"%d", components.day];
  cell.weekday = (indexPath.item % self.numberOfDaysInWeek);
  
  return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  CGFloat calendarWidth = self.collectionView.bounds.size.width;
  
  CGFloat width = floorf(calendarWidth / self.numberOfDaysInWeek);
  
  if ((indexPath.item % self.numberOfDaysInWeek) == self.numberOfDaysInWeek - 1) {
    return CGSizeMake(calendarWidth - (width * (self.numberOfDaysInWeek - 1)), width);
  }
  
  return CGSizeMake(width, width);
}

@end
