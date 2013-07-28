//
//  MNCalendarViewCell.h
//  MNCalendarView
//
//  Created by Min Kim on 7/26/13.
//  Copyright (c) 2013 min. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const MNCalendarViewCellIdentifier;

@interface MNCalendarViewCell : UICollectionViewCell

@property(nonatomic,strong) NSDate *date;

@property(nonatomic,strong) UIColor *separatorColor;

@end
