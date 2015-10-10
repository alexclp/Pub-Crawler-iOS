//
//  PubTableViewCell.h
//  Pub Crawler
//
//  Created by Alexandru Clapa on 10/10/2015.
//  Copyright © 2015 Alexandru Clapa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PubTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *priceRange;
@property (nonatomic, weak) IBOutlet UILabel *distance;

@end
