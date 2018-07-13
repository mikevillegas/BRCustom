//
//  BRUsuariosKit.h
//  BRCustom
//
//  Created by Miguel Villegas on 12/07/18.
//  Copyright © 2018 Miguel Villegas. All rights reserved.

#import <Foundation/Foundation.h>
#import "BRUsuario.h"

@interface BRUsuariosKit : NSObject
-(void)saveUser:(BRUsuario *)user  withCompletionHandler:(void (^)(NSError *error, BOOL wasCancelled))completion;
-(void)getAllUserWithCompletionHandler:(void (^)(NSArray *result, NSError *error, BOOL wasCancelled))completion;
@end
