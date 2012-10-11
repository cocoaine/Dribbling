//
//  DribbbleDefaultModel.m
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import "DribbbleDefaultModel.h"

#import "GlobalHeader.h"
#import "DribbbleClient.h"

@implementation DribbbleDefaultModel

@synthesize page = _page;
@synthesize pages = _pages;
@synthesize perPage = _perPage;
@synthesize total = _total;
@synthesize createdAt = _createdAt;

- (id)initWithAttributes:(NSDictionary *)attributes {
	self = [super init];
    if (self) {
		if (ContainsDictionaryValue(attributes, @"page")) {
			self.page = [[attributes objectForKey:@"page"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"pages")) {
			self.pages = [[attributes objectForKey:@"pages"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"perPage")) {
			self.perPage = [[attributes objectForKey:@"perPage"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"total")) {
			self.total = [[attributes objectForKey:@"total"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"created_at")) {
			self.createdAt = [attributes objectForKey:@"created_at"];
		}
    }
    return self;
}

+ (void)cancelAllRequests {
	[[DribbbleClient sharedClient].operationQueue cancelAllOperations];
}

@end
