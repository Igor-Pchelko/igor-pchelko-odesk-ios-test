//
//  ModelsEntity.m
//  BuggyProject
//  Copyright (c) 2014 oDesk Corporation. All rights reserved.
//

#import "ModelsEntity.h"
#import "OwnerEntity.h"


@implementation ModelsEntity

@dynamic modelName;
@dynamic modelId;
@dynamic owner;


// FIX3: Add custom description for ModelsEntity class

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@: %@", self.modelName, self.owner.ownerName];
}

@end
