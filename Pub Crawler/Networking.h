//
//  Networking.h
//  Pub Crawler
//
//  Created by Alexandru Clapa on 10/10/2015.
//  Copyright © 2015 Alexandru Clapa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Networking : NSObject

+ (Networking *)networking;

- (void)getRoutesWithCompletion:(void(^)(NSArray *array, NSError *error))completion;

@end
