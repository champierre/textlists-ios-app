#import "ItemsTableViewController.h"
#import "ItemsCoreDataAppDelegate.h"
#import "ItemDetailViewController.h"
//#import "ItemViewController.h"


@implementation ItemsTableViewController

// @synthesize fetchedResultsController=_fetchedResultsController;
// @synthesize managedObjectContext=_managedObjectContext;
@synthesize list=_list;

#pragma mark -
#pragma mark Initialization

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if ((self = [super initWithStyle:style])) {
    }
    return self;
}
*/


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    NSLog(@"itemTable viewDidLoad");
    [super viewDidLoad];
    //self.navigationItem.title = @"Items";
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    // set Add button
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    self.navigationItem.rightBarButtonItem = addButton;
    [addButton release];
    // set srot order for listings
    NSFetchedPropertyDescription *fetchedDesc = [[[self.list entity] propertiesByName] objectForKey:@"fetchedListings"];
    NSFetchRequest *fetchRequest = [fetchedDesc fetchRequest];
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"position" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    [sortDescriptor release];
    [sortDescriptors release];
    // eager loading listings.item
    [fetchRequest setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObject:@"item"]];
    
//     NSError *error = nil;
//     if (![self.fetchedResultsController performFetch:&error]) {
//         NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
//         abort();
//     }
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.navigationItem.title = [self.list valueForKey:@"name"];
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1; //number of sections;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSUInteger count = [[self.list valueForKeyPath:@"fetchedListings"] count];
    NSLog(@"items count:%d", count);
    return count; //number of rows in section;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
//    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //NSManagedObject *managedObject = [self.items anyObject]; //FIXME
    //[[self.list valueForKeyPath:@"listings.item"]]
    //cell.textLabel.text = [[managedObject valueForKey:@"content"] description];
    NSManagedObject *item = [[self.list valueForKeyPath:@"fetchedListings.item"] objectAtIndex:[indexPath row]];
    cell.textLabel.text = [[item valueForKey:@"content"] description];
    
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
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}

#pragma mark -
#pragma mark Add a new object

- (void)insertNewObject {
#if 0
    ItemViewController *itemController = [[ItemViewController alloc] initWithNibName:@"ItemViewController" bundle:nil];
//    itemController.list = self.list;
    [[self navigationController] pushViewController:itemController animated:YES];
    [itemController release];
#else
    ItemDetailViewController *itemController = [[ItemDetailViewController alloc] initWithNibName:@"ItemDetailViewController" bundle:nil];
    itemController.list = self.list;
    [[self navigationController] pushViewController:itemController animated:YES];
    [itemController release];
#endif
/*    
    NSManagedObjectContext *context = UIAppDelegate.managedObjectContext;
    
    NSManagedObject *item = [NSEntityDescription insertNewObjectForEntityForName:@"Item"
                                                 inManagedObjectContext:context];
    [item setValue:@"hoge" forKey:@"content"];
    NSManagedObject *listing = [NSEntityDescription insertNewObjectForEntityForName:@"Listing"
                                                    inManagedObjectContext:context];
    [listing setValue:item forKey:@"item"];
    [[self.list mutableSetValueForKeyPath:@"listings"] addObject:listing];
    
    
    
//    [self.list
    //[self.items addObject: newManagedObject];
    // Save the context.
    NSError *error = nil;
    if (![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    // refresh list.items
    [context refreshObject:self.list mergeChanges:NO];
    NSLog(@"TODO: transit to Item detail view");
    */
}

#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    NSLog(@"itemsTable viewDidUnload");
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
    self.list = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

