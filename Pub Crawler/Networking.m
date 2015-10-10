//
//  Networking.m
//  Pub Crawler
//
//  Created by Alexandru Clapa on 10/10/2015.
//  Copyright © 2015 Alexandru Clapa. All rights reserved.
//

#import "Networking.h"
#import "AFNetworking.h"

@implementation Networking

static Networking *networking;

+ (Networking *)networking {
	if (networking == nil) {
		networking = [[Networking alloc] init];
	}
	
	return networking;
}

- (void)getRoutesWithCompletion:(void(^)(NSArray *array, NSError *error))completion {
	AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
	
	[manager GET:@"http://110a7847.ngrok.io/routes" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
		
		NSLog(@"Response object: %@", responseObject);
		
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		
	}];
}

@end