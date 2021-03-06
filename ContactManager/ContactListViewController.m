//
//  ContactListViewController.m
//  ContactManager
//
//  Created by Scott Densmore on 6/14/11.
//  Copyright 2011 Scott Densmore. All rights reserved.
//

#import "ContactListViewController.h"
#import "ContactDataController.h"
#import "Contact.h"

@implementation ContactListViewController

#pragma mark - Synthesized Accessors

@synthesize contactsArrayController;
@synthesize tableView;

#pragma mark - Memory Management

- (id)init 
{
    return [self initWithContactDataController:nil];
}

- (id)initWithContactDataController:(ContactDataController *)controller 
{
    NSParameterAssert(controller != nil);
    
    self = [super init];
    if (self) {
        contactController = [controller retain];
    }
    return self;
}

- (void)dealloc
{
    RELEASE(contactsArrayController);
    RELEASE(contactController);
    
    [super dealloc];
}

#pragma mark - Accessors

- (NSArray *)contacts
{
    return [contactController contacts];
}

#pragma mark - Methods

- (Contact *)selectedContact
{
	if ([[contactsArrayController selectedObjects] count]) {
		return [[contactsArrayController selectedObjects] objectAtIndex:0];
	}
	return nil;
}

- (void)selectContact:(Contact *)contact
{
    BOOL valueChanged = NO;
    if (contact) {
        valueChanged = [contactsArrayController setSelectedObjects:[NSArray arrayWithObject:contact]];
    } else {
        valueChanged = [contactsArrayController setSelectedObjects:nil];
    }
    
    if (valueChanged) {
        [self willChangeValueForKey:@"selectedContact"];
        [self didChangeValueForKey:@"selectedContact"];
    }
}

- (void)reloadData 
{
	[self willChangeValueForKey:@"contacts"];
	[self didChangeValueForKey:@"contacts"];
}

#pragma mark - View methods

- (NSString *)nibName
{
    return NSStringFromClass([self class]);
}

#pragma mark - NSTableViewDelegate methods

- (void)tableViewSelectionDidChange:(NSNotification *)aNotification 
{
	[self willChangeValueForKey:@"selectedContact"];
	[self didChangeValueForKey:@"selectedContact"];
}

@end
