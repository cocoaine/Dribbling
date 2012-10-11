//
//  DribbbleShot.m
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import "DribbbleShot.h"

#import "GlobalHeader.h"
#import "DribbbleClient.h"

@implementation DribbbleShot

@synthesize shotID = _shotID;
@synthesize title = _title;
@synthesize url = _url;
@synthesize shortURL = _shortURL;
@synthesize imageURL = _imageURL;
@synthesize imageTeaserURL = _imageTeaserURL;
@synthesize width = _width;
@synthesize height = _height;
@synthesize viewsCount = _viewsCount;
@synthesize likesCount = _likesCount;
@synthesize commentsCount = _commentsCount;
@synthesize reboundsCount = _reboundsCount;
@synthesize reboundSourceID = _reboundSourceID;
@synthesize player = _player;

- (id)initWithAttributes:(NSDictionary *)attributes {
	self = [super initWithAttributes:attributes];
	if (self) {
		if (ContainsDictionaryValue(attributes, @"id")) {
			self.shotID = [[attributes objectForKey:@"id"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"title")) {
			self.title = [attributes objectForKey:@"title"];
		}
		
		if (ContainsDictionaryValue(attributes, @"url")) {
			self.url = [NSURL URLWithString:[attributes objectForKey:@"url"]];
		}
		
		if (ContainsDictionaryValue(attributes, @"short_url")) {
			self.shortURL = [NSURL URLWithString:[attributes objectForKey:@"short_url"]];
		}
		
		if (ContainsDictionaryValue(attributes, @"image_url")) {
			self.imageURL = [NSURL URLWithString:[attributes objectForKey:@"image_url"]];
		}
		
		if (ContainsDictionaryValue(attributes, @"image_teaser_url")) {
			self.imageTeaserURL = [NSURL URLWithString:[attributes objectForKey:@"image_teaser_url"]];
		}
		
		if (ContainsDictionaryValue(attributes, @"width")) {
			self.width = [[attributes objectForKey:@"width"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"height")) {
			self.height = [[attributes objectForKey:@"height"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"views_count")) {
			self.viewsCount = [[attributes objectForKey:@"views_count"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"likes_count")) {
			self.likesCount = [[attributes objectForKey:@"likes_count"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"comments_count")) {
			self.commentsCount = [[attributes objectForKey:@"comments_count"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"rebounds_count")) {
			self.reboundsCount = [[attributes objectForKey:@"rebounds_count"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"rebound_source_id")) {
			self.reboundSourceID = [[attributes objectForKey:@"rebound_source_id"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"player")) {
		self.player = [[DribbblePlayer alloc] initWithAttributes:[attributes objectForKey:@"player"]];
		}
	}
	return self;
}

+ (void)getShotWithID:(NSInteger)shotID block:(void (^)(DribbbleShot *shot))block {
	[[DribbbleClient sharedClient] getPath:[NSString stringWithFormat:@"shots/%d", shotID]
								parameters:nil
								   success:^(AFHTTPRequestOperation *operation, id responseObject) {
									   NSLog(@"responseObject : %@", responseObject);
									   if (block) {
										   block([[DribbbleShot alloc] initWithAttributes:responseObject]);
									   }
								   }
								   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
									   NSLog(@"error: %@", error.localizedDescription);
									   if (block) {
										   block(nil);
									   }
								   }];
}

+ (void)getShotsWithType:(DribbbleShotsType)shotsType block:(void (^)(NSArray *shots, BOOL isLast, NSInteger currentPage))block {
	[[self class] getShotsWithType:shotsType page:1 perPage:DribbbleShotsDefaultPerPage block:block];
}

+ (void)getShotsWithType:(DribbbleShotsType)shotsType page:(NSInteger)page perPage:(NSInteger)perPage block:(void (^)(NSArray *shots, BOOL isLast, NSInteger currentPage))block {
	NSString *path = nil;
	
	switch (shotsType) {
		case DribbbleShotsTypeDebuts:
			path = [NSString stringWithFormat:@"shots/%@", @"debuts"];
			break;
			
		case DribbbleShotsTypeEveryone:
			path = [NSString stringWithFormat:@"shots/%@", @"everyone"];
			break;
			
		case DribbbleShotsTypePopular:
			path = [NSString stringWithFormat:@"shots/%@", @"popular"];
			break;
			
		default:
			break;
	}
	
//#define DribbbleShotsDefaultPerPage	15
//#define DribbbleShotsMaxPerPage		30
	
	// Add page number
	path = [path stringByAppendingFormat:@"?page=%d&per_page=%d", page, perPage];
	
	[[DribbbleClient sharedClient] getPath:path
								parameters:nil
								   success:^(AFHTTPRequestOperation *operation, id responseObject) {
									   NSMutableArray *tmpShots = [NSMutableArray array];
									   NSArray *shotsList = [responseObject objectForKey:@"shots"];
									   
									   for (NSDictionary *shotInfo in shotsList) {
										   NSLog(@"shotInfo : %@", shotInfo);
										   DribbbleShot *shot = [[DribbbleShot alloc] initWithAttributes:shotInfo];
										   [tmpShots addObject:shot];
									   }
									   
									   NSInteger page = 1;
									   if (ContainsDictionaryValue(responseObject, @"page")) {
										   page = [[responseObject objectForKey:@"page"] integerValue];
									   }
									   
									   NSInteger pages = 1;
									   if (ContainsDictionaryValue(responseObject, @"pages")) {
										   pages = [[responseObject objectForKey:@"pages"] integerValue];
									   }
									   
									   NSLog(@"page : %d, pages : %d", page, pages);
									   
									   BOOL tmpLast = NO;
									   if (page == pages) {
										   tmpLast = YES;
									   }
									   
									   if (block) {
										   block(tmpShots, tmpLast, page);
									   }
								   }
								   failure:^(AFHTTPRequestOperation *operation, NSError *error) {
									   NSLog(@"error: %@", error.localizedDescription);
									   if (block) {
										   block(nil, YES, 1);
									   }
								   }];
}

@end
