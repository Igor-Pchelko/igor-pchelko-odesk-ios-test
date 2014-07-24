//
//  ViewController.m
//  BuggyProject
//  Copyright (c) 2014 oDesk Corporation. All rights reserved.
//

#import "ViewController.h"
#import "SomeClass.h"
#import "CoreDataHelpers.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    // FIX4: Register default valuse of count
    [[NSUserDefaults standardUserDefaults] registerDefaults:[NSDictionary dictionaryWithObjectsAndKeys: [NSNumber numberWithInteger:1], @"count", nil]];
    
    NSInteger count = [[NSUserDefaults standardUserDefaults] integerForKey:@"count"];
    NSLog(@"cc: %d", count);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)firstBug:(id)sender {
    
	[SomeClass printTextInMain:@"Bug 1"];
}

- (IBAction)secondBug:(id)sender {
    
    // FIX2: change storage type of variable to __block. It allows to read/write current value of x state instead of constant copy of x.
    
	__block NSInteger x = 123;
	void (^printX)() = ^() {
		NSLog(@"%i", x);
	};
	x++;
	printX();
}

- (IBAction)thirdBug:(id)sender {
	[CoreDataHelpers fillUnsortedData];
	NSArray *models = [CoreDataHelpers arrayForFetchRequestWithName:@"AllModels"];
	NSLog(@"%@", models);
}

- (IBAction)fourthBug:(id)sender {
    
    // FIX4: static variable persist in one app session only. It doesn't save when app quits. Here we need to change logic. One of the approach is cheking if there any objects exists. Another approach is saving count in propery list (e.g. NSUserDefaults).

// FIX4: "approach 1"
//    NSArray *models = [CoreDataHelpers arrayForFetchRequestWithName:@"AllModels"];
//    
//	if (models.count>0) {
//		[CoreDataHelpers cleanData];
//        NSLog(@"Clean data");
//	}
//	
//	[CoreDataHelpers fillUnsortedData];
//	models = [CoreDataHelpers arrayForFetchRequestWithName:@"AllModels"];
//	NSLog(@"%@", models);
    

    // FIX4: "approach 2"
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSInteger count = [defaults integerForKey:@"count"];

    NSLog(@"count = %d", count);
    
    if (count>1) {
		[CoreDataHelpers cleanData];
        NSLog(@"Clean data");
    }
    
	[CoreDataHelpers fillUnsortedData];
	NSArray *models = [CoreDataHelpers arrayForFetchRequestWithName:@"AllModels"];
	NSLog(@"%@", models);

	count++;
    
    // Save count
    [defaults setInteger:count forKey:@"count"];
    [defaults synchronize];
}


- (IBAction)fifthBug:(id)sender {
    
    // FIX5: Sorting fetched result with sortedArrayUsingDescriptors method
	[CoreDataHelpers fillUnsortedData];
    
	NSArray *models = [CoreDataHelpers arrayForFetchRequestWithName:@"AllModels"];
	//NSLog(@"%@", models);
    
    NSSortDescriptor *sort1 = [[NSSortDescriptor alloc] initWithKey:@"owner.ownerName" ascending:YES];
    NSSortDescriptor *sort2 = [[NSSortDescriptor alloc] initWithKey:@"modelName" ascending:YES];
    
    models = [models sortedArrayUsingDescriptors:[NSArray arrayWithObjects:sort1, sort2, nil]];
    NSLog(@"%@", models);

}

@end
