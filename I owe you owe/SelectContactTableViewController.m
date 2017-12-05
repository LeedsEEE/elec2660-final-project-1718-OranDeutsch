//
//  SelectContactTableViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 01/12/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "SelectContactTableViewController.h"

@interface SelectContactTableViewController ()

@end

@implementation SelectContactTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    self.contactNames = [self loadContacts];
    
    int rows = (int)[self.contactNames count];
    
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"contactCell" forIndexPath:indexPath];
    
    self.contactNames = [self loadContacts];
    
    cell.textLabel.text = [self.contactNames objectAtIndex:indexPath.row];
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    
    NSString *payeeName = [self.contactNames objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    
    int payeeID = [Payee newPayeeID];
    
    NSDictionary *newPayee = @{@"name" : payeeName,
                               @"payeeID" : [NSNumber numberWithInt:payeeID]};
    
    
    [Payee AddPayeeFromDictionary:newPayee];
    

    
    
    
}


-(NSMutableArray *)loadContacts {
    CNContactStore *store = [[CNContactStore alloc] init];

    
    
    //keys with fetching properties
    NSArray *keys = @[CNContactFamilyNameKey, CNContactGivenNameKey];
    NSMutableArray *tempContacts = [[NSMutableArray alloc]init];
    
    
    //uses the contacts libary to search through the users contacts before assigning all the enteries to a simple array
    
    CNContactFetchRequest *request = [[CNContactFetchRequest alloc] initWithKeysToFetch:keys];
    NSError *error;
    [store enumerateContactsWithFetchRequest:request error:&error usingBlock:^(CNContact * __nonnull contact, BOOL * __nonnull stop) {
        if (error) {
            
            NSLog(@"error fetching contacts %@", error);
            
        }else{
            NSString *newContact = [NSString stringWithFormat:@"%@ %@",contact.givenName,contact.familyName];
            
            [tempContacts addObject:newContact];
        }
    }];
    
    
    return tempContacts;
}


@end
