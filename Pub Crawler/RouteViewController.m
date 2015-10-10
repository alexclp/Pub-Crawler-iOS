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

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
	
	[self configureHeader];
	self.navigationController.navigationBar.barStyle = UIStatusBarStyleLightContent;
}

- (void)configureHeader {
	[self.navigationController.navigationBar setBackgroundImage:[UIImage new]
												  forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.shadowImage = [UIImage new];
	self.navigationController.navigationBar.translucent = YES;
	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
	
	
	self.navigationController.navigationBar.topItem.title = @"";
	
	UIColor *tintColor = [UIColor colorWithWhite:0.3 alpha:0.3];
	self.header.image = [UIImageEffects imageByApplyingBlurToImage:[UIImage imageNamed:@"headerImage.jpg"] withRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
	
	self.titleLabel.text = [self.routeDetails objectForKey:@"title"];
	self.subtitleLabel.text = @"Lorem ipsum";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
