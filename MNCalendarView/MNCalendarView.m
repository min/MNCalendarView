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
@property(nonatomic,assign,readwrite) NSUInteger        daysInWeek;

- (NSDate *)firstVisibleDateOfMonth:(NSDate *)date;
- (NSDate *)lastVisibleDateOfMonth:(NSDate *)date;

- (void)applyConstraints;

@end

@implementation MNCalendarView

- (id)initWithFrame:(CGRect)frame {
  if (self = [super initWithFrame:frame]) {
    self.calendar       = [NSCalendar currentCalendar];
    self.fromDate       = [[NSDate date] mn_beginningOfDay:self.calendar];
    self.toDate         = [self.fromDate dateByAddingTimeInterval:MN_YEAR * 4];
    self.separatorColor = [UIColor grayColor];
    
    self.daysInWeek = 7;
    
    [self addSubview:self.collectionView];
    [self applyConstraints];
    [self reloadData];
  }
  return self;
}

- (UICollectionView *)collectionView {
  if (nil == _collectionView) {
    _collectionView =
      [[UICollectionView alloc] initWithFrame:CGRectZero
                         collectionViewLayout:[[MNCalendarViewLayout alloc] init]];
    _collectionView.translatesAutoresizingMaskIntoConstraints = NO;
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    
    [_collectionView registerClass:MNCalendarViewCell.class
        forCellWithReuseIdentifier:MNCalendarViewCellIdentifier];
    
    [_collectionView registerClass:MNCalendarHeaderView.class
        forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
               withReuseIdentifier:MNCalendarHeaderViewIdentifier];
  }
  return _collectionView;
}

- (void)reloadData {
  NSMutableArray *monthDates = @[].mutableCopy;
  MNFastDateEnumeration *enumeration =
    [[MNFastDateEnumeration alloc] initWithFromDate:[self.fromDate mn_firstDateOfMonth:self.calendar]
                                             toDate:[self.toDate mn_firstDateOfMonth:self.calendar]
                                           calendar:self.calendar
                                               unit:NSCalendarUnitMonth];
  for (NSDate *date in enumeration) {
    [monthDates addObject:date];
  }
  self.monthDates = monthDates;
  
  [self.collectionView reloadData];
}

- (NSDate *)firstVisibleDateOfMonth:(NSDate *)date {
  date = [date mn_firstDateOfMonth:self.calendar];
  
  NSDateComponents *components =
    [self.calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit
                fromDate:date];
  
  return
    [[date mn_dateWithDay:-((components.weekday - 1) % self.daysInWeek) calendar:self.calendar] dateByAddingTimeInterval:MN_DAY];
}

- (NSDate *)lastVisibleDateOfMonth:(NSDate *)date {
  date = [date mn_lastDateOfMonth:self.calendar];
  
  NSDateComponents *components =
    [self.calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit
                     fromDate:date];
  
  return
    [date mn_dateWithDay:components.day + (self.daysInWeek - 1) - ((components.weekday - 1) % self.daysInWeek)
                calendar:self.calendar];
}

- (void)applyConstraints {
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
  
  cell.separatorColor = self.separatorColor;
  
  NSDate *monthDate =
    [self firstVisibleDateOfMonth:self.monthDates[indexPath.section]];
  
  cell.date = [monthDate dateByAddingTimeInterval:indexPath.item * MN_DAY];
  
  return cell;
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout*)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
  
  CGFloat width     = self.bounds.size.width;
  CGFloat itemWidth = roundf(width / self.daysInWeek);
  
  NSUInteger weekday = indexPath.item % self.daysInWeek;
  
  if (weekday == self.daysInWeek - 1) {
    return CGSizeMake(width - (itemWidth * (self.daysInWeek - 1)), itemWidth);
  }
  
  return CGSizeMake(itemWidth, itemWidth);
}

@end
