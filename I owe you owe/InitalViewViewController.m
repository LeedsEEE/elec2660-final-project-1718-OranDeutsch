//
//  InitalViewViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 06/12/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "InitalViewViewController.h"

@interface InitalViewViewController ()

@end

@implementation InitalViewViewController


//the purpose of this view controller is to send the user to the welcome screen if they have no saved data and if they do to the app as usual.

//I used a seperate view controller as it will flash on this screen every timme the app is loaded, using this screen makes the app look better on launch

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    //since this is the first view to load, if this is the first time the app is run then the user is set to the welcome screen
    
    if ([Settings firstTimeLoad] == YES) {
        [self performSegueWithIdentifier:@"firstTimeRunSegue" sender:self];
        NSLog(@"program has been run with empty data");
        
    }else{
        [self performSegueWithIdentifier:@"notFirstTimeRunSegue" sender:self];
        NSLog(@"program will proceed");
    }
    
}

@end
