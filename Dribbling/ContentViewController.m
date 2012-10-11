//
//  ContentViewController.m
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import "ContentViewController.h"

#import "GlobalHeader.h"
#import "DribbbleShot.h"
#import "DribbbleShotViewCell.h"
#import "AJNotificationView.h"

@interface ContentViewController ()

@property (nonatomic, assign) NSInteger currentPage;
@property (nonatomic, assign) NSInteger clickedShotIndex;
@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) PSCollectionView *collectionView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (nonatomic, strong) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) AJNotificationView *notificationView;
@property (nonatomic, assign) BOOL loading;
@property (nonatomic, assign) BOOL refreshEnabled;

- (void)requestShots:(id)sender;

@end

@implementation ContentViewController

@synthesize currentPage = _currentPage;
@synthesize clickedShotIndex = _clickedShotIndex;
@synthesize items = _items;
@synthesize collectionView = _collectionView;
@synthesize refreshControl = _refreshControl;
@synthesize activityIndicator = _activityIndicator;
@synthesize notificationView = _notificationView;
@synthesize loading = _loading;
@synthesize refreshEnabled = _refreshEnabled;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.currentPage = 0;
		self.clickedShotIndex = 0;
		self.loading = NO;
		self.refreshEnabled = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.view.backgroundColor = [UIColor lightGrayColor];
	
	self.collectionView = [[PSCollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	self.collectionView.collectionViewDelegate = self;
	self.collectionView.collectionViewDataSource = self;
	self.collectionView.backgroundColor = [UIColor darkGrayColor];
	self.collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		self.collectionView.numColsPortrait = 3;
		self.collectionView.numColsLandscape = 4;
	}
	else {
		self.collectionView.numColsPortrait = 2;
		self.collectionView.numColsLandscape = 3;
	}
	
	[self.view addSubview:self.collectionView];
	
	self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
	self.activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin);
	self.activityIndicator.hidesWhenStopped = YES;
	self.activityIndicator.center = self.collectionView.center;
	[self.collectionView addSubview:self.activityIndicator];
	
	self.refreshControl = [[UIRefreshControl alloc] init];
	[self.refreshControl addTarget:self action:@selector(requestShots:) forControlEvents:UIControlEventValueChanged];
	
	[self.collectionView addSubview:self.refreshControl];
	
	[self.activityIndicator startAnimating];
	[self.refreshControl beginRefreshing];
	
	[self requestShots:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.delegate = nil;
}

- (void)setShotsType:(NSInteger)shotsType {
	self.collectionView.scrollsToTop = YES;
	
	[self.items removeAllObjects];
	self.items = nil;
	
	[self.collectionView reloadData];
	
	[self.activityIndicator startAnimating];
	[self.refreshControl beginRefreshing];
	
	self.currentPage = 0;
	self.loading = NO;
	self.refreshEnabled = NO;
	
	[self requestShots:nil];
}

- (void)requestShots:(id)sender {
	if (self.loading) {
		return;
	}
	
	if (sender != nil) {
		[self.items removeAllObjects];
	}
	
	self.loading = YES;
	
	[DribbbleShot cancelAllRequests];
	
	if (self.notificationView) {
		[self.notificationView hide];
		self.notificationView = nil;
	}
	
	if (self.items != nil) {
		self.notificationView = [AJNotificationView showNoticeInView:self.view
																type:AJNotificationTypeBlue
															   title:@"NOW LOADING..."
													 linedBackground:AJLinedBackgroundTypeAnimated
														   hideAfter:30.f];
	}
	else {
		self.items = [NSMutableArray array];
	}
	
	NSInteger perPage = DribbbleShotsDefaultPerPage;
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
		perPage = DribbbleShotsMaxPerPage;
	}
	
	[DribbbleShot getShotsWithType:(DribbbleShotsType)[[NSUserDefaults standardUserDefaults] integerForKey:@"shots_selected_index"]
							  page:(self.currentPage + 1)
						   perPage:perPage
							 block:^(NSArray *shots, BOOL isLast, NSInteger currentPage)
	 {
		 self.loading = NO;
		 
		 if (self.notificationView != nil) {
			 [self.notificationView hide];
		 }
		 
		 if (isLast) {
			 self.collectionView.delegate = nil;
		 }
		 
		 [self.activityIndicator stopAnimating];
		 [self.refreshControl endRefreshing];
		 
		 if (shots != nil) {
			 self.refreshEnabled = YES;
			 self.currentPage = currentPage;
			 
			 [self.items addObjectsFromArray:shots];
			 NSLog(@"self.items : %d", [self.items count]);
			 
			 [self.collectionView reloadData];
			 
			 if (self.collectionView.delegate == nil && isLast == NO) {
				 self.collectionView.delegate = self;
			 }
		 }
	 }];
}

- (NSInteger)numberOfViewsInCollectionView:(PSCollectionView *)collectionView {
    return [self.items count];
}

- (PSCollectionViewCell *)collectionView:(PSCollectionView *)collectionView viewAtIndex:(NSInteger)index {
    DribbbleShot *item = (DribbbleShot *)[self.items objectAtIndex:index];
    
    DribbbleShotViewCell *cell = (DribbbleShotViewCell *)[self.collectionView dequeueReusableView];
    if (!cell) {
        cell = [[DribbbleShotViewCell alloc] initWithFrame:CGRectZero];
    }
    
    [cell fillViewWithObject:item];
    
    return cell;
}

- (CGFloat)heightForViewAtIndex:(NSInteger)index {
    DribbbleShot *item = (DribbbleShot *)[self.items objectAtIndex:index];
    
    return [DribbbleShotViewCell heightForViewWithObject:item inColumnWidth:self.collectionView.colWidth];
}

- (void)collectionView:(PSCollectionView *)collectionView didSelectView:(PSCollectionViewCell *)view atIndex:(NSInteger)index {
	// You can do something when the user taps on a collectionViewCell here
	NSLog(@"index : %d", index);
	
	if (self.delegate) {
		DribbbleShot *item = (DribbbleShot *)[self.items objectAtIndex:index];
		self.clickedShotIndex = index;
		
		[self.delegate contentViewController:self didSelectShot:item];
	}
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	if (self.collectionView.frame.size.height + self.collectionView.contentOffset.y > (self.collectionView.contentSize.height - 50.f)) {
		if (self.refreshEnabled && self.loading == NO) {
			NSLog(@"bottom refresh");
			[self requestShots:nil];
		}
	}
}

- (NSArray *)shotsForDetailViewController:(DetailViewController *)controller {
	return self.items;
}

- (NSInteger)clickedShotIndexForDetailViewController:(DetailViewController *)controller {
	return self.clickedShotIndex;
}

@end
