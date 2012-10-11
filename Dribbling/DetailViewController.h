//
//  DetailViewController.h
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DribbbleShot.h"
#import "MWPhotoBrowser.h"

@protocol DetailViewControllerPhotoDataSource;

@interface DetailViewController : UIViewController <MWPhotoBrowserDelegate>

@property (nonatomic, assign) id <DetailViewControllerPhotoDataSource> photoDataSource;

- (void)setShotDetail:(DribbbleShot *)shot;

@end

@protocol DetailViewControllerPhotoDataSource <NSObject>
@required
- (NSArray *)shotsForDetailViewController:(DetailViewController *)controller;
- (NSInteger)clickedShotIndexForDetailViewController:(DetailViewController *)controller;
@end
