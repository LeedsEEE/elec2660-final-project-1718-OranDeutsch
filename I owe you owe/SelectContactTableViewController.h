//
//  SelectContactTableViewController.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 01/12/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Payee+CoreDataClass.h"
#import <ContactsUI/ContactsUI.h>


@interface SelectContactTableViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *contactNames;


@end
