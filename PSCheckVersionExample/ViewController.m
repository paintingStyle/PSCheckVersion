//
//  ViewController.m
//  PSCheckVersionExample
//
//  Created by paintingStyle on 2018/5/29.
//  Copyright © 2018年 paintingStyle. All rights reserved.
//

#import "ViewController.h"
#import "PSCheckVersion.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *openAppStoreInAppSwitch;
@property (weak, nonatomic) IBOutlet UITextField *salesAreaTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (IBAction)openAppstoreSwitchChange:(UISwitch *)sender {
    
    [PSCheckVersion shardInstance].openAppStoreInApp = sender.on;
}

- (IBAction)salesAreaTextFieldEditingChange:(UITextField *)sender {
    
    [PSCheckVersion shardInstance].salesArea = sender.text;
}

- (IBAction)checkVersionBtnDidClicked {
    
    [self.view endEditing:YES];
    [PSCheckVersion checkVersion];
}

- (IBAction)checkVersionCompulsoryBtnDidClicked {
    
    [self.view endEditing:YES];
    [PSCheckVersion checkVersionCompulsoryUpdate];
}

- (IBAction)checkVersionCustomBtnDidClicked {
    
    [self.view endEditing:YES];
    [PSCheckVersion checkVersionCompleteBlock:^(PSAppInfo *info, NSError *error) {
        
    }];
}

@end
