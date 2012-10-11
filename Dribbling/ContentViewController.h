//
//  ContentViewController.h
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PSCollectionView.h"
#import "DribbbleShot.h"
#import "DetailViewController.h"

@protocol ContentViewControllerDelegate;

@interface ContentViewController : UIViewController <PSCollectionViewDelegate, PSCollectionViewDataSource, DetailViewControllerPhotoDataSource, UIScrollViewDelegate>

@property (nonatomic, assign) id <ContentViewControllerDelegate> delegate;

- (void)setShotsType:(NSInteger)shotsType;

@end

@protocol ContentViewControllerDelegate <NSObject>
@required
- (void)contentViewController:(ContentViewController *)controller didSelectShot:(DribbbleShot *)shot;
@end
