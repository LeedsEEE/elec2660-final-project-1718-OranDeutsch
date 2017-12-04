//
//  WelcomeViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 01/12/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Settings+manipulate.h"


//Background image sourced from https://gallery.yopriceville.com/Free-Clipart-Pictures/Money-PNG/Pile_of_Coins_PNG_Picture#.WiWehWX-1sY

@interface WelcomeViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIPickerView *currencyPicker;

- (IBAction)goToApp:(id)sender;



@property (nonatomic, strong) Settings *tempSettings;
@property (nonatomic, strong) NSMutableArray *currencyData;

@end
