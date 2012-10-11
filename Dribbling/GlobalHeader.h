//
//  GlobalHeader.h
//  Dribbling
//
//  Created by J.C. Yang on 12. 10. 10..
//  Copyright (c) 2012년 Cocoaine Team. All rights reserved.
//

#ifndef Dribbling_GlobalHeader_h
#define Dribbling_GlobalHeader_h

#import "UIImageView+AFNetworking.h"
#import "UIColor+RandomColor.h"

#define IsNull(x)									((x) == nil || [(x) isKindOfClass:[NSNull class]])
#define ContainsDictionaryValue(dictionary, key)	(!IsNull([dictionary objectForKey:key]))

#endif
