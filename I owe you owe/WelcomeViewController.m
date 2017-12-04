//
//  WelcomeViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 01/12/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "WelcomeViewController.h"

@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void) viewWillAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];

    
}

- (IBAction)goToApp:(id)sender {
    
        [self performSegueWithIdentifier:@"Proceed" sender:self];
    
}
@end
