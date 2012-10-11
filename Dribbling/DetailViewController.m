//
//  DetailViewController.m
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import "DetailViewController.h"

#import <QuartzCore/QuartzCore.h>

#import "GlobalHeader.h"

@interface DetailViewController ()

@property (nonatomic, strong) NSMutableArray *shots;
@property (nonatomic, strong) UIButton *imageViewButton;
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;

- (void)clickImage:(id)sender;

@end

@implementation DetailViewController

@synthesize shots = _shots;
@synthesize imageViewButton = _imageViewButton;
@synthesize imageView = _imageView;
@synthesize activityIndicator = _activityIndicator;
@synthesize photoDataSource = _photoDataSource;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		self.shots = [NSMutableArray array];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor lightGrayColor];
	
	self.imageViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.imageViewButton.frame = CGRectMake(10.f, 10.f, 280.f, 280.f);
	self.imageViewButton.backgroundColor = [UIColor whiteColor];
	self.imageViewButton.layer.shadowColor = [UIColor darkGrayColor].CGColor;
	self.imageViewButton.layer.shadowOffset = CGSizeMake(0.f, 5.f);
	self.imageViewButton.layer.shadowRadius = 5.f;
	self.imageViewButton.layer.shadowOpacity = 0.7f;
	
	[self.imageViewButton addTarget:self action:@selector(clickImage:) forControlEvents:UIControlEventTouchUpInside];
	
	[self.view addSubview:self.imageViewButton];
	
	CGRect imageViewRect = self.imageViewButton.frame;
	imageViewRect.origin.x = 5.f;
	imageViewRect.origin.y = 5.f;
	imageViewRect.size.width -= 10.f;
	imageViewRect.size.height -= 10.f;
	
	self.imageView = [[UIImageView alloc] initWithFrame:imageViewRect];
	self.imageView.backgroundColor = [UIColor lightGrayColor];
	self.imageView.contentMode = UIViewContentModeScaleAspectFill;
	self.imageView.clipsToBounds = YES;
	
	[self.imageViewButton addSubview:self.imageView];
	
	self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
	self.activityIndicator.hidesWhenStopped = YES;
	self.activityIndicator.center = self.imageView.center;
	[self.imageView addSubview:self.activityIndicator];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setShotDetail:(DribbbleShot *)shot {
	self.imageView.image = nil;
	
	[self.activityIndicator startAnimating];
	
	[self.imageView setImageWithURLRequest:[NSURLRequest requestWithURL:shot.imageURL]
						  placeholderImage:nil
								   success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
									   [self.activityIndicator stopAnimating];
								   }
								   failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
									   [self.activityIndicator stopAnimating];
								   }];
}

- (void)clickImage:(id)sender {
	if (self.imageView.image == nil) {
		return;
	}
	
	if (self.shots.count > 0) {
		[self.shots removeAllObjects];
	}
	
	NSArray *tmpShots = [self.photoDataSource shotsForDetailViewController:self];
	for (DribbbleShot *shot in tmpShots) {
		[self.shots addObject:[MWPhoto photoWithURL:shot.imageURL]];
	}
	
	MWPhotoBrowser *photoBrowser = [[MWPhotoBrowser alloc] initWithDelegate:self];
	photoBrowser.wantsFullScreenLayout = YES;
	photoBrowser.displayActionButton = YES;
	[photoBrowser setInitialPageIndex:[self.photoDataSource clickedShotIndexForDetailViewController:self]];
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:photoBrowser];
	
	[[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:navController animated:YES completion:^{
		
	}];
}

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.shots.count;
}

- (MWPhoto *)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.shots.count)
        return [self.shots objectAtIndex:index];
    return nil;
}

@end
