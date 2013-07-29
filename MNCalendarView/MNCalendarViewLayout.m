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

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
  
  NSArray *array =
    [super layoutAttributesForElementsInRect:({
      CGRect bounds = self.collectionView.bounds;
      bounds.origin.y = proposedContentOffset.y - self.collectionView.bounds.size.height/2.f;
      bounds.size.width *= 1.5f;
      bounds;
    })];
  
  CGFloat minOffsetY = CGFLOAT_MAX;
  UICollectionViewLayoutAttributes *targetLayoutAttributes = nil;

  for (UICollectionViewLayoutAttributes *layoutAttributes in array) {
    if ([layoutAttributes.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
      CGFloat offsetY = fabs(layoutAttributes.frame.origin.y - proposedContentOffset.y);

      if (offsetY < minOffsetY) {
        minOffsetY = offsetY;

        targetLayoutAttributes = layoutAttributes;
      }
    }
  }

  if (targetLayoutAttributes) {
    return targetLayoutAttributes.frame.origin;
  }

  return CGPointMake(proposedContentOffset.x, proposedContentOffset.y);
}

@end
