//
//  PaidDebtsTableViewController.m
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 29/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import "PaidDebtsTableViewController.h"

@interface PaidDebtsTableViewController ()

@end

@implementation PaidDebtsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
 
    //Tableview delegate and datasource set to self 
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    //Reloads the table and changes the title every time the view appears
    [self.tableView reloadData];
    [self.tabBarController setTitle:@"Paid Debts"];
    
    //Gives the user some visual feedback that there is no data to display
    if ([self.tableView numberOfRowsInSection:0] == 0) {
        [self.view makeToast:@"No paid debts to display"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

-(NSArray *)loadData {
    
    //loads all the debts into an array and sorts by the NSDate the debts were paid
    NSArray *data =  [Debt returnDebts:1 owed:0];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey: @"datePaid" ascending: NO];
    NSArray *sortedData = [data sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    return sortedData;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //Calls the loaded array, counts the amount of elements and makes a row for each element
    self.paidDebts = [self loadData];
    int numberOfRows = (int)[self.paidDebts count];
    
    return numberOfRows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    
    //Imports the dictionary for the corisponding cell
    self.paidDebts = [self loadData];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"paidDebt" forIndexPath:indexPath];
    cell.textLabel.text = [[self.paidDebts objectAtIndex:indexPath.row]objectForKey:@"name"];
    NSNumber *amountVal = [[self.paidDebts objectAtIndex:indexPath.row]objectForKey:@"amount"];
    
    //Changes some text and the colour of the detail cell based on if the debt is owed to the user or the debt ia from the user
    if ([[[self.paidDebts objectAtIndex:indexPath.row]objectForKey:@"imOwedDebt"]  integerValue] == 1) {
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Owed Me %@",[Debt amountString:amountVal]];
        cell.detailTextLabel.textColor = [UIColor redColor];
    }else{
        cell.detailTextLabel.text = [NSString stringWithFormat:@"Loaned Me %@",[Debt amountString:amountVal]];
        UIColor *darkGreen = [UIColor colorWithRed:(0) green:(150/255.0) blue:(0) alpha:1];
        cell.detailTextLabel.textColor =  darkGreen;
    }
    
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
    
    ViewPaidDebtViewController *destinationViewController = [segue destinationViewController];
    
    
    //Calls the debt ID
    if ([[segue identifier] isEqualToString:@"paidDebtSegue"]) {
        
        //Calls the debt ID at the row selected by the user to be passed over the segue
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSArray *tempDebt = [self loadData];
        NSInteger segueDebtID = [[[tempDebt objectAtIndex:indexPath.row] objectForKey:@"debtID"] integerValue];
        destinationViewController.debtID = segueDebtID;
    }
}

#pragma mark exit segues


- (IBAction)debtDeletedSegue:(UIStoryboardSegue *)segue{
        [super viewDidLoad];
    
    
}

- (IBAction)debtMarkedUnpaidSegue:(UIStoryboardSegue *)segue{
        [super viewDidLoad];
    
}

@end
