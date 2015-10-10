//
//  RouteViewController.m
//  Pub Crawler
//
//  Created by Alexandru Clapa on 10/10/2015.
//  Copyright © 2015 Alexandru Clapa. All rights reserved.
//

#import "RouteViewController.h"
#import "UIImageEffects.h"

@interface RouteViewController ()

@end

@implementation RouteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self.navigationController.navigationBar setBackgroundImage:[UIImage new]
												  forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.shadowImage = [UIImage new];
	self.navigationController.navigationBar.translucent = YES;
	
	[self configureHeader];
}

- (void)configureHeader {
	UIColor *tintColor = [UIColor colorWithWhite:0.3 alpha:0.3];
	self.header.image = [UIImageEffects imageByApplyingBlurToImage:[UIImage imageNamed:@"headerImage.jpg"] withRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
