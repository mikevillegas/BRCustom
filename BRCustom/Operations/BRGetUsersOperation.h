//
//  BRGetUsersOperation.h
//  BRCustom
//
//  Created by Miguel Villegas on 7/10/18.
//  Copyright © 2018 Miguel Villegas. All rights reserved.
//
#import <Foundation/Foundation.h>
typedef void (^completion_block_getUsers)(id result, NSError * error, BOOL wasCancelled);

@interface BRGetUsersOperation : NSOperation
    @property (nonatomic, readonly) id result;
    @property (nonatomic, copy) completion_block_getUsers completionHandler;
@end
