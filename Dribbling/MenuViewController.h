//
//  MenuViewController.h
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MenuViewControllerDelegate;

@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) id <MenuViewControllerDelegate> delegate;

@end

@protocol MenuViewControllerDelegate <NSObject>
@required
- (void)menuViewController:(MenuViewController *)controller didSelectIndex:(NSInteger)index;
@end
