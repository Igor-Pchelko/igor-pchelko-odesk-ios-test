//
//  ModelsEntity.h
//  BuggyProject
//
//  Created by Nabi Makhmudov on 3/4/14.
//  Copyright (c) 2014 oDesk Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OwnerEntity;

@interface ModelsEntity : NSManagedObject

@property (nonatomic, retain) NSString * modelName;
@property (nonatomic, retain) NSNumber * modelId;
@property (nonatomic, retain) OwnerEntity *owner;

@end
