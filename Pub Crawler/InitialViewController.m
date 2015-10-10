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

#define CellIndentifier @"TableViewCell"

@interface InitialViewController ()

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) NSArray *images;

@end

@implementation InitialViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

	/*
	
	[self.navigationController.navigationBar setBackgroundImage:[UIImage new]
							 forBarMetrics:UIBarMetricsDefault];
	self.navigationController.navigationBar.shadowImage = [UIImage new];
	self.navigationController.navigationBar.translucent = YES;
	*/
	 
	self.title = @"Pub Crawler";
	
	self.images = @[@"beer1.jpg", @"beer2.jpg"];
	
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

	if (indexPath.row == 0) {
		UIImage *backgroundImage = [UIImageEffects imageByApplyingDarkEffectToImage:[UIImage imageNamed:@"headerImage.jpg"]];
		
		
		cell.backgroundImage.image = backgroundImage;
		cell.titleLabel.text = @"Explore your city";
	} else {
		UIImage *backgroundImage = [UIImageEffects imageByApplyingDarkEffectToImage:[UIImage imageNamed:[self.images objectAtIndex:[self generateRandomNumberWithlowerBound:0 upperBound:1]]]];
		cell.backgroundImage.image = backgroundImage;
		
		NSDictionary *dict = [self.dataSource objectAtIndex:indexPath.row - 1];
		cell.titleLabel.text = [dict objectForKey:@"title"];
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
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
@end
