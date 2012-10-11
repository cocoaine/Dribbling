//
//  DribbbleShot.h
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DribbbleDefaultModel.h"
#import "DribbblePlayer.h"

enum {
    DribbbleShotsTypeDebuts		= 0,
    DribbbleShotsTypeEveryone	= 1,
    DribbbleShotsTypePopular	= 2
};
typedef NSUInteger DribbbleShotsType;

#define DribbbleShotsDefaultPerPage	15
#define DribbbleShotsMaxPerPage		30

@interface DribbbleShot : DribbbleDefaultModel

@property (nonatomic, assign) NSInteger shotID;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURL *shortURL;
@property (nonatomic, strong) NSURL *imageURL;
@property (nonatomic, strong) NSURL *imageTeaserURL;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger viewsCount;
@property (nonatomic, assign) NSInteger likesCount;
@property (nonatomic, assign) NSInteger commentsCount;
@property (nonatomic, assign) NSInteger reboundsCount;
@property (nonatomic, assign) NSInteger reboundSourceID;
@property (nonatomic, strong) DribbblePlayer *player;

+ (void)getShotWithID:(NSInteger)shotID block:(void (^)(DribbbleShot *shot))block;
+ (void)getShotsWithType:(DribbbleShotsType)shotsType block:(void (^)(NSArray *shots, BOOL isLast, NSInteger currentPage))block;
+ (void)getShotsWithType:(DribbbleShotsType)shotsType page:(NSInteger)page perPage:(NSInteger)perPage block:(void (^)(NSArray *shots, BOOL isLast, NSInteger currentPage))block;

@end
