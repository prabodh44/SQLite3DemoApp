//
//  ViewController.h
//  SQLite3DBSample
//
//  Created by ith on 4/19/18.
//  Copyright © 2018 ith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tblPeople;


- (IBAction)addNewRecord:(id)sender;

@end

