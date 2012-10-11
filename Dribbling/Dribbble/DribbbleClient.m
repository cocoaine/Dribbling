//
//  DribbbleClient.m
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import "DribbbleClient.h"

#import "AFJSONRequestOperation.h"

NSString * const kDribbbleBaseURLString = @"http://api.dribbble.com/";

@implementation DribbbleClient

- (id)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)initWithBaseURL:(NSURL *)url {
	self = [super initWithBaseURL:url];
    if (!self) {
        return nil;
    }
    
    [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
    [self setDefaultHeader:@"Accept" value:@"application/json"];
    
    return self;
}

+ (DribbbleClient *)sharedClient
{
    static DribbbleClient * _sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[self alloc] initWithBaseURL:[NSURL URLWithString:kDribbbleBaseURLString]];
    });
    
    return _sharedClient;
}

@end
