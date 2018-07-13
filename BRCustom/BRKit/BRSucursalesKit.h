//
//  BRSucursalesKit.h
//  BRCustom
//
//  Created by Miguel Villegas on 09/07/18.
//  Copyright © 2018 Miguel Villegas. All rights reserved.

#import <Foundation/Foundation.h>

@interface BRSucursalesKit : NSObject
    -(void)getSucursalesDataWithCompletionHandler:(void (^)(NSArray *result, NSError *error, BOOL wasCancelled))completion;
@end
