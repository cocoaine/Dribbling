//
//  DribbblePlayer.h
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DribbbleDefaultModel.h"

@interface DribbblePlayer : DribbbleDefaultModel

@property (nonatomic, assign) NSInteger playerID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *username;
@property (nonatomic, strong) NSURL *url;
@property (nonatomic, strong) NSURL *avatarURL;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *twitterScreenName;
@property (nonatomic, assign) NSInteger draftedByPlayerID;
@property (nonatomic, assign) NSInteger shotsCount;
@property (nonatomic, assign) NSInteger drafteesCount;
@property (nonatomic, assign) NSInteger followersCount;
@property (nonatomic, assign) NSInteger followingCount;
@property (nonatomic, assign) NSInteger commentsCount;
@property (nonatomic, assign) NSInteger commentsReceivedCount;
@property (nonatomic, assign) NSInteger likesCount;
@property (nonatomic, assign) NSInteger likesReceivedCount;
@property (nonatomic, assign) NSInteger reboundsCount;
@property (nonatomic, assign) NSInteger reboundsReceivedCount;

@end
