//
//  EditInfoViewController.h
//  SQLite3DBSample
//
//  Created by ith on 4/19/18.
//  Copyright © 2018 ith. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditInfoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *txtFirstname;

@property (weak, nonatomic) IBOutlet UITextField *txtLastname;

@property (weak, nonatomic) IBOutlet UITextField *txtAge;


- (IBAction)saveInfo:(id)sender;@end
