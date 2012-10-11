//
//  DribbblePlayer.m
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#import "DribbblePlayer.h"

#import "GlobalHeader.h"

@implementation DribbblePlayer

@synthesize playerID = _playerID;
@synthesize name = _name;
@synthesize username = _username;
@synthesize url = _url;
@synthesize avatarURL = _avatarURL;
@synthesize location = _location;
@synthesize twitterScreenName = _twitterScreenName;
@synthesize draftedByPlayerID = _draftedByPlayerID;
@synthesize shotsCount = _shotsCount;
@synthesize drafteesCount = _drafteesCount;
@synthesize followersCount = _followersCount;
@synthesize followingCount = _followingCount;
@synthesize commentsCount = _commentsCount;
@synthesize commentsReceivedCount = _commentsReceivedCount;
@synthesize likesCount = _likesCount;
@synthesize likesReceivedCount = _likesReceivedCount;
@synthesize reboundsCount = _reboundsCount;
@synthesize reboundsReceivedCount = _reboundsReceivedCount;

- (id)initWithAttributes:(NSDictionary *)attributes {
	self = [super initWithAttributes:attributes];
	if (self) {
		if (ContainsDictionaryValue(attributes, @"id")) {
			self.playerID = [[attributes objectForKey:@"id"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"name")) {
			self.name = [attributes objectForKey:@"name"];
		}
		
		if (ContainsDictionaryValue(attributes, @"username")) {
			self.username = [attributes objectForKey:@"username"];
		}
		
		if (ContainsDictionaryValue(attributes, @"url")) {
			self.url = [NSURL URLWithString:[attributes objectForKey:@"url"]];
		}
		
		if (ContainsDictionaryValue(attributes, @"avatar_url")) {
			self.avatarURL = [NSURL URLWithString:[attributes objectForKey:@"avatar_url"]];
		}
		
		if (ContainsDictionaryValue(attributes, @"location")) {
			self.location = [attributes objectForKey:@"location"];
		}
		
		if (ContainsDictionaryValue(attributes, @"twitter_screen_name")) {
			self.twitterScreenName = [attributes objectForKey:@"twitter_screen_name"];
		}
		
		if (ContainsDictionaryValue(attributes, @"drafted_by_player_id")) {
			self.draftedByPlayerID = [[attributes objectForKey:@"drafted_by_player_id"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"shots_count")) {
			self.shotsCount = [[attributes objectForKey:@"shots_count"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"draftees_count")) {
			self.drafteesCount = [[attributes objectForKey:@"draftees_count"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"followers_count")) {
			self.followersCount = [[attributes objectForKey:@"followers_count"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"following_count")) {
			self.followingCount = [[attributes objectForKey:@"following_count"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"comments_count")) {
			self.commentsCount = [[attributes objectForKey:@"comments_count"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"comments_received_count")) {
			self.commentsReceivedCount = [[attributes objectForKey:@"comments_received_count"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"likes_count")) {
			self.likesCount = [[attributes objectForKey:@"likes_count"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"likes_received_count")) {
			self.likesReceivedCount = [[attributes objectForKey:@"likes_received_count"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"rebounds_count")) {
			self.reboundsCount = [[attributes objectForKey:@"rebounds_count"] integerValue];
		}
		
		if (ContainsDictionaryValue(attributes, @"rebounds_received_count")) {
			self.reboundsReceivedCount = [[attributes objectForKey:@"rebounds_received_count"] integerValue];
		}
	}
	return self;
}

@end
