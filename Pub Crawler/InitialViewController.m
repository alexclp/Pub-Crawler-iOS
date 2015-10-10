//
//  ViewController.m
//  Pub Crawler
//
//  Created by Alexandru Clapa on 10/10/2015.
//  Copyright © 2015 Alexandru Clapa. All rights reserved.
//

#import "InitialViewController.h"
#import "IntroTableViewCell.h"
#import "UIImageEffects.h"
#import "Networking.h"
#import "RouteViewController.h"

#define CellIndentifier @"TableViewCell"

@interface InitialViewController ()

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *images;

@property (nonatomic, assign) NSInteger selectedIndex;

@end

@implementation InitialViewController

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
	[self.navigationController.navigationBar setBackgroundImage:nil
												  forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.shadowImage = nil;
	self.navigationController.navigationBar.translucent = NO;
	self.navigationController.navigationBar.tintColor = [UIColor blackColor];
	
	
	self.title = @"Pub Crawler";
}

- (void)viewDidLoad {
	[super viewDidLoad];
	
	
	
	
	// Do any additional setup after loading the view, typically from a nib.

	 
	self.title = @"Pub Crawler";
	
	self.images = @[@"beer1.jpg", @"beer2.jpg", @"beer3.jpg", @"beer4.jpg"];
	
	[[Networking networking] getRoutesWithCompletion:^(NSArray *data, NSError *error) {
		if (!error) {
			self.dataSource = [NSArray arrayWithArray:data];
			[self.tableView reloadData];
		} else {
			NSLog(@"Error: %@", error.description);
		}
	}];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

-(int)generateRandomNumberWithlowerBound:(int)lowerBound
							   upperBound:(int)upperBound {
	int rndValue = lowerBound + arc4random() % (upperBound - lowerBound);
	return rndValue;
}

#pragma mark UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

	return self.dataSource.count + 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.row == 0) {
		return 235;
	}
	return 113;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	IntroTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIndentifier forIndexPath:indexPath];
	
	UIColor *tintColor = [UIColor colorWithWhite:0.3 alpha:0.3];

	int randomNumber = [self generateRandomNumberWithlowerBound:0 upperBound:3];
	
	if (indexPath.row == 0) {
		UIImage *backgroundImage = [UIImageEffects imageByApplyingBlurToImage:[UIImage imageNamed:@"headerImage.jpg"] withRadius:30.0 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
		
		
		cell.backgroundImage.image = backgroundImage;
		cell.titleLabel.text = @"Explore your city";
	} else {
		UIImage *backgroundImage = [UIImageEffects imageByApplyingBlurToImage:[UIImage imageNamed:[self.images objectAtIndex:randomNumber]] withRadius:15.0 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
		cell.backgroundImage.image = backgroundImage;
		
		NSDictionary *dict = [self.dataSource objectAtIndex:indexPath.row - 1];
		cell.titleLabel.text = [dict objectForKey:@"title"];
	}
	
	cell.backgroundImage.contentMode = UIViewContentModeScaleAspectFill;
	cell.backgroundImage.clipsToBounds = YES;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	if (indexPath.row == 0) {
//		HEADER CLICK
	} else {
//		CELL CLICK
		self.selectedIndex = indexPath.row - 1;

		[self performSegueWithIdentifier:@"showRouteSegue" sender:self];
	}
	
	
}
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
	
	UIImage *myImage = [UIImage imageNamed:@"headerImage.jpg"];
	UIImageView *imageView = [[UIImageView alloc] initWithImage:myImage];
	imageView.frame = CGRectMake(0, 0, self.view.frame.size.width, 235);
	
	return imageView;
	
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 235;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	CGFloat sectionHeaderHeight = 337;//Change as per your table header height
	if (scrollView.contentOffset.y <= sectionHeaderHeight&&scrollView.contentOffset.y >= 0) {
		scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
	} else if (scrollView.contentOffset.y >= sectionHeaderHeight) {
		scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
	}
}
*/

#pragma mark Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
	if ([segue.identifier isEqualToString:@"showRouteSegue"]) {
		RouteViewController *vc = segue.destinationViewController;
		
		NSLog(@"Array: %@", [self.dataSource objectAtIndex:self.selectedIndex]);
		
		vc.routeDetails = [self.dataSource objectAtIndex:self.selectedIndex];
	}
}

@end
