//
//  ViewController.m
//  MemoryManagement
//
//  Created by Paul Solt on 1/29/20.
//  Copyright © 2020 Lambda, Inc. All rights reserved.
//

#import "ViewController.h"
#import "Car.h"
#import "Person.h"
#import "LSILog.h"

@interface ViewController ()

@property (nonatomic, retain) NSMutableArray *people;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // TODO: Disable ARC in settings
    
    NSLog(@"Hi");
    
    NSString *jsonString = [[NSString alloc] initWithString:@"{\"name\" : \"Jerry\" }"];
    NSLog(@"jsonString: %p", jsonString);
    NSString *alias = [jsonString retain]; // RetainCount = 2
    NSLog(@"alias: %p", alias);
    [alias release]; // RetainCount = 1
    alias = nil;     // Clear out variable so we don't accidentally use it
    NSLog(@"Json: %@", jsonString);
    
    [jsonString release]; // RetainCount = 0 (immediately clean up the memory)
    jsonString = nil;
    
    NSString *jim = [[NSString alloc] initWithString:@"Jim"]; // jim 1
    
    self.people = [[NSMutableArray alloc] init]; // people 1
    
    [self.people addObject:jim]; // jim 2
    [jim release]; // transfer ownership to the collection
    
    [self.people removeObject:jim]; // jim 1 (array callse relase when removing an object)
    
    Car *honda = [Car carWithMake:@"Civic"];
    //Car *honda = [[Car alloc] initWithMake:@"Civic"]; // honda: 1
    
    Person *sarah = [[Person alloc] initWithCar:honda]; // honda: 2, sarah: 1
    [honda release]; // transfering ownership honda: 1
    
    [sarah release]; // sarah: 0, honda: 0
    
   // sarah.car = honda; // Potential crash if not set correctly
    
    NSString *name = [NSString stringWithFormat:@"%@ %@", @"John", @"Miller"];
    // yes
    
    NSDate *today = [NSDate date];
    // yes
    
    NSDate *now = [NSDate new];
    // no
    
    NSDate *tomorrow2 = [NSDate dateWithTimeIntervalSinceNow:60*60*24];
    // yes
    
    NSDate *nextTomorrow = [tomorrow2 copy]; // retain: 1
    // no
    
    NSArray *words = [@"This sentence is the bomb" componentsSeparatedByString:@" "];
    // yes
    
    NSString *idea = [[NSString alloc] initWithString:@"Hello Ideas"];
    // no
    
    Car *redCar = [Car carWithMake:@"Civic"];
    // yes
    
    NSString *idea2 = [[[NSString alloc] initWithString:@"Hello Ideas"] autorelease];
    // yes
    
    NSString
    *idea3 = [[NSString alloc] initWithString:@"Hello Ideas"];
    // no
    
    [idea3 autorelease];
    // yes
    
    [now release];
    [nextTomorrow release];
    [idea release];
}

//-(void)addObject:(id)object {
//    [object retain]; // take ownership: incrementing the reference count
//    // insert into collection
//    [_internalArray addObject:object]
//}

- (void)dealloc {
    [_people release]; // Calls release on all objects inside // jim = 0, people = 0
    _people = nil;
    
    [super dealloc];
}


@end
