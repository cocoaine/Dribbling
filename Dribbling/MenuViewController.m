//
//  MenuViewController.m
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import "MenuViewController.h"

#import "GlobalHeader.h"

@interface MenuViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation MenuViewController

@synthesize tableView = _tableView;
@synthesize delegate = _delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
	
	self.view.backgroundColor = [UIColor blackColor];
	
	self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
	self.tableView.delegate = self;
	self.tableView.dataSource = self;
	self.tableView.backgroundColor = [UIColor clearColor];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	
	[self.view addSubview:self.tableView];
	
	[self.tableView reloadData];
	
	NSInteger selectedIndex = [[NSUserDefaults standardUserDefaults] integerForKey:@"shots_selected_index"];
	[self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:selectedIndex inSection:0]
								animated:YES scrollPosition:UITableViewScrollPositionNone];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 100.f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
									  reuseIdentifier:CellIdentifier];
		
		cell.contentView.backgroundColor = [UIColor colorWithWhite:0.15f alpha:1.f];
		cell.selectionStyle = UITableViewCellSelectionStyleGray;
	}
	
	NSString *text = nil;
	switch (indexPath.row) {
		case 0:
			text = @"Debuts";
			break;
			
		case 1:
			text = @"Everyone";
			break;
			
		case 2:
			text = @"Popular";
			break;
			
		default:
			break;
	}
	
	cell.textLabel.textColor = [UIColor whiteColor];
	cell.textLabel.text = text;
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[[NSUserDefaults standardUserDefaults] setInteger:indexPath.row forKey:@"shots_selected_index"];
	
	if (self.delegate) {
		[self.delegate menuViewController:self didSelectIndex:indexPath.row];
	}
}

@end
