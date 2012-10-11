//
//  DribbbleDefaultModel.h
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DribbbleDefaultModel : NSObject

@property (nonatomic, assign) NSInteger page;
@property (nonatomic, assign) NSInteger pages;
@property (nonatomic, assign) NSInteger perPage;
@property (nonatomic, assign) NSInteger total;
@property (nonatomic, strong) NSString *createdAt;

- (id)initWithAttributes:(NSDictionary *)attributes;

+ (void)cancelAllRequests;

@end
