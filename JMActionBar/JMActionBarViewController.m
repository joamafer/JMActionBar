//
//  JMActionBarViewController.m
//  JMActionBar
//
//  Created by JOSE ANTONIO MARTINEZ FERNANDEZ on 06/08/2015.
//  Copyright (c) 2015 jamartinez. All rights reserved.
//

#import "JMActionBarViewController.h"
#import "JMActionBar.h"

@interface JMActionBarViewController () <JMActionBarDelegate>
@property (weak, nonatomic) IBOutlet JMActionBar *actionBar;

@end

@implementation JMActionBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureActionBar];
}

# pragma mark -
# pragma mark Setup UI

- (void)configureActionBar {
    self.actionBar.delegate = self;
    self.actionBar.tabs = @[@"Home",@"Photos",@"Videos",@"Music"];
    self.actionBar.backgroundColor = [UIColor colorWithRed:81/255.0 green:176/255.0 blue:1.0 alpha:1.0];
    self.actionBar.font = [UIFont fontWithName:@"Avenir" size:15];
    self.actionBar.selectedFontColor = [UIColor colorWithRed:0 green:84/255.0 blue:189/255.0 alpha:1.0];
    self.actionBar.deselectedFontColor = [UIColor colorWithRed:226/255.0 green:232/255.0 blue:229/255.0 alpha:1.0];
    self.actionBar.lineColor = [UIColor colorWithRed:0 green:84/255.0 blue:189/255.0 alpha:1.0];
}

# pragma mark -
# pragma mark JMActionBarDelegate

- (void)didTapTabWithTag:(NSInteger)tag {
    NSLog(@"Tapped button with tag %ld", (long)tag);
}

@end
