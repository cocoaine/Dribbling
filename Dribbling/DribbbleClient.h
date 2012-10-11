//
//  DribbbleClient.h
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFHTTPClient.h"

extern NSString * const kDribbbleBaseURLString;

@interface DribbbleClient : AFHTTPClient

+ (DribbbleClient *)sharedClient;

- (id)initWithBaseURL:(NSURL *)url;

@end
