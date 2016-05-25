//
//  ViewController.m
//  TKLoadingHUDDemo
//
//  Created by 谭柯 on 16/5/24.
//  Copyright © 2016年 Tank. All rights reserved.
//

#import "ViewController.h"
#import "TKLoadingHUD.h"

@interface ViewController ()

@property (nonatomic, strong) UIBarButtonItem *countItem;
@property (nonatomic, strong) UISegmentedControl *segmentedControl;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"show" style:UIBarButtonItemStylePlain target:self action:@selector(showLoad)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"hide" style:UIBarButtonItemStylePlain target:self action:@selector(hideLoad)];
    self.navigationItem.rightBarButtonItems = @[item1,item2];
    
    self.countItem = [[UIBarButtonItem alloc] initWithTitle:@"0" style:UIBarButtonItemStylePlain target:self action:@selector(showLoad)];
    self.navigationItem.leftBarButtonItem = self.countItem;
    
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:@[@"Default",@"Line",@"Ball",@"BallChain"]];
    [self.segmentedControl setBounds:CGRectMake(self.segmentedControl.bounds.origin.x,
                                                self.segmentedControl.bounds.origin.y,
                                                200,
                                                self.segmentedControl.bounds.size.height)];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.navigationItem.titleView = self.segmentedControl;
    [self.segmentedControl addTarget:self action:@selector(segmentedControlChange:) forControlEvents:UIControlEventValueChanged];
    
    [TKLoadingHUD showHUDAddedTo:self.view];
    
    [self checkHUDCount];
}

- (void)showLoad{
    [TKLoadingHUD showHUDAddedTo:self.view];
    [self segmentedControlChange:self.segmentedControl];
    
    [self checkHUDCount];
}

- (void)hideLoad{
    [TKLoadingHUD hideHUDForView:self.view];
    
    [self checkHUDCount];
}

- (void)segmentedControlChange:(UISegmentedControl *)sender {
    switch (sender.selectedSegmentIndex) {
        case 1:
            [TKLoadingHUD changeloadingStyle:TKLoadingStyleLine ForView:self.view];
            break;
        case 2:
            [TKLoadingHUD changeloadingStyle:TKLoadingStyleBall ForView:self.view];
            break;
        case 3:
            [TKLoadingHUD changeloadingStyle:TKLoadingStyleBallChain ForView:self.view];
            break;
        default:
            [TKLoadingHUD changeloadingStyle:TKLoadingStyleDefault ForView:self.view];
            break;
    }
}

- (void)checkHUDCount{
    TKLoadingHUD *hud = [TKLoadingHUD subLoadingHUDFromView:self.view];
    if (hud) {
        [self.countItem setTitle:[NSString stringWithFormat:@"%ld",hud.loadCount]];
    }else{
        [self.countItem setTitle:@"0"];
    }
}

@end
