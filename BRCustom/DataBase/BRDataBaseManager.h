//
//  BRDataBaseManager.h
//  BRCustom
//
//  Created by Miguel Villegas on 09/07/18.
//  Copyright © 2018 Miguel Villegas. All rights reserved.

#import <Foundation/Foundation.h>
#import "BRUsuario.h"


@interface BRDataBaseManager : NSObject
-(id)initWithDatabaseName:(NSString *)name;
-(void)getUsersFromTableWithCompletionHandler:(void (^)(NSArray *result, NSError *error))completion;
-(void)insertUserWith:(BRUsuario*)user withCompletionHandler:(void (^)(NSError *error))completion;
@end
