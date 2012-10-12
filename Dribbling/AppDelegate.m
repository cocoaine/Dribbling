//
//  AppDelegate.m
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import "AppDelegate.h"

#import "PaperFoldNavigationController.h"
#import "ContentViewController.h"
#import "MenuViewController.h"
#import "DetailViewController.h"

@interface AppDelegate (MenuViewControllerDelegate) <MenuViewControllerDelegate>
- (void)menuViewController:(MenuViewController *)controller didSelectIndex:(NSInteger)index;
@end

@interface AppDelegate (ContentViewControllerDelegate) <ContentViewControllerDelegate>
- (void)contentViewController:(ContentViewController *)controller didSelectShot:(DribbbleShot *)shot;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
	
	ContentViewController *contentViewController = [[ContentViewController alloc] initWithNibName:nil bundle:nil];
	contentViewController.delegate = self;
	
	self.viewController = [[PaperFoldNavigationController alloc] initWithRootViewController:contentViewController];
	
	MenuViewController *menuViewController = [[MenuViewController alloc] initWithNibName:nil bundle:nil];
	menuViewController.delegate = self;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[self.viewController setLeftViewController:menuViewController width:300.f];
	}
	else {
		[self.viewController setLeftViewController:menuViewController width:150.f];
	}
	
	DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:nil bundle:nil];
	detailViewController.photoDataSource = contentViewController;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		[self.viewController setRightViewController:detailViewController width:600.f rightViewFoldCount:6 rightViewPullFactor:0.9f];
	}
	else {
		[self.viewController setRightViewController:detailViewController width:300.f rightViewFoldCount:3 rightViewPullFactor:0.9f];
	}
	
	self.window.rootViewController = self.viewController;
	[self.window makeKeyAndVisible];
	
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
	// Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

@implementation AppDelegate (MenuViewControllerDelegate)

- (void)menuViewController:(MenuViewController *)controller didSelectIndex:(NSInteger)index {
	NSLog(@"index : %d", index);
	
	DetailViewController *detailViewController = (DetailViewController *)self.viewController.rightViewController;
	[detailViewController resetShotDetail];
	
	ContentViewController *contentViewController = (ContentViewController *)self.viewController.rootViewController;
	[contentViewController setShotsType:index];
	
	[self.viewController.paperFoldView setPaperFoldState:PaperFoldStateDefault];
}

@end

@implementation AppDelegate (ContentViewControllerDelegate)

- (void)contentViewController:(ContentViewController *)controller didSelectShot:(DribbbleShot *)shot {
	NSLog(@"image url : %@", shot.imageURL);
	
	DetailViewController *detailViewController = (DetailViewController *)self.viewController.rightViewController;
	[detailViewController setShotDetail:shot];
	
	[self.viewController.paperFoldView setPaperFoldState:PaperFoldStateRightUnfolded];
}

@end
