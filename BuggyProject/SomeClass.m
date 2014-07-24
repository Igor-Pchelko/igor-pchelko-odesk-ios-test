//
//  SomeClass.m
//  BuggyProject
//  Copyright (c) 2014 oDesk Corporation. All rights reserved.
//

#import "SomeClass.h"

@implementation SomeClass

+ (void)printTextInMain:(NSString *)someText {
    
    // FIX1: dispatch_sync tried to execute task (block) in the same queue that was cause of deadlock
    // https://developer.apple.com/library/ios/documentation/General/Conceptual/ConcurrencyProgrammingGuide/OperationQueues/OperationQueues.html
    // Important: You should never call the dispatch_sync or dispatch_sync_f function from a task that is executing in the same queue that you are planning to pass to the function. This is particularly important for serial queues, which are guaranteed to deadlock, but should also be avoided for concurrent queues.
    dispatch_block_t block = ^{
		NSLog(@"%@", someText);
	};
    
    if ([NSThread isMainThread])
    {
        block();
    }
    else
    {
        dispatch_sync(dispatch_get_main_queue(), block);
    }
}

@end
