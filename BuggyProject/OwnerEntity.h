//
//  OwnerEntity.h
//  BuggyProject
//
//  Created by Nabi Makhmudov on 3/4/14.
//  Copyright (c) 2014 oDesk Corporation. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ModelsEntity;

@interface OwnerEntity : NSManagedObject

@property (nonatomic, retain) NSString * ownerName;
@property (nonatomic, retain) NSSet *models;
@end

@interface OwnerEntity (CoreDataGeneratedAccessors)

- (void)addModelsObject:(ModelsEntity *)value;
- (void)removeModelsObject:(ModelsEntity *)value;
- (void)addModels:(NSSet *)values;
- (void)removeModels:(NSSet *)values;

@end
