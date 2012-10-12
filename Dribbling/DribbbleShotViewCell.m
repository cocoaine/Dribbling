//
//  DribbbleShotViewCell.m
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import "DribbbleShotViewCell.h"

#import "DribbbleShot.h"
#import "UIImageView+AFNetworking.h"

#define MARGIN 4.0

@interface DribbbleShotViewCell ()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation DribbbleShotViewCell

@synthesize imageView = _imageView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
		self.backgroundColor = [UIColor whiteColor];
        
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        self.imageView.clipsToBounds = YES;
        [self addSubview:self.imageView];
		
		self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
		self.titleLabel.font = [UIFont boldSystemFontOfSize:14.f];
		self.titleLabel.textColor = [UIColor darkGrayColor];
        self.titleLabel.numberOfLines = 0;
		[self addSubview:self.titleLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

- (void)prepareForReuse {
    [super prepareForReuse];
	
    self.imageView.image = nil;
	self.titleLabel.text = nil;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = self.frame.size.width - MARGIN * 2;
    CGFloat top = MARGIN;
    CGFloat left = MARGIN;
	
	DribbbleShot *shot = (DribbbleShot *)self.object;
    
    // Image
    CGFloat objectWidth = (CGFloat)shot.width;
    CGFloat objectHeight = (CGFloat)shot.height;
    CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
    self.imageView.frame = CGRectMake(left, top, width, scaledHeight);
	
	// Label
    CGSize labelSize = CGSizeZero;
    labelSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font
								 constrainedToSize:CGSizeMake(width, INT_MAX)
									 lineBreakMode:self.titleLabel.lineBreakMode];
    top = self.imageView.frame.origin.y + self.imageView.frame.size.height + MARGIN;
    
    self.titleLabel.frame = CGRectMake(left, top, labelSize.width, labelSize.height);
}

- (void)fillViewWithObject:(id)object {
    [super fillViewWithObject:object];
	
	DribbbleShot *shot = (DribbbleShot *)object;
	
	[self.imageView setImageWithURL:shot.imageTeaserURL];
	
	self.titleLabel.text = shot.title;
}

+ (CGFloat)heightForViewWithObject:(id)object inColumnWidth:(CGFloat)columnWidth {
    CGFloat height = 0.0;
    CGFloat width = columnWidth - MARGIN * 2;
    
    height += MARGIN;
	
	DribbbleShot *shot = (DribbbleShot *)object;
    
    // Image
    CGFloat objectWidth = (CGFloat)shot.width;
    CGFloat objectHeight = (CGFloat)shot.height;
    CGFloat scaledHeight = floorf(objectHeight / (objectWidth / width));
    height += scaledHeight;
	
	// Label
    NSString *title = shot.title;
    CGSize labelSize = CGSizeZero;
    UIFont *labelFont = [UIFont boldSystemFontOfSize:14.0];
    labelSize = [title sizeWithFont:labelFont constrainedToSize:CGSizeMake(width, INT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
    height += labelSize.height;
    
    height += MARGIN;
    
    return height;
}

@end
