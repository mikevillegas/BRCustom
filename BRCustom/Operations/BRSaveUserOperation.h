//
//  BRSaveUserOperation.h
//  BRCustom
//
//  Created by Miguel Villegas on 10/07/18.
//  Copyright © 2018 Miguel Villegas. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "BRUsuario.h"
typedef void (^completion_block_saveUsers)(NSError * error, BOOL wasCancelled);

@interface BRSaveUserOperation : NSOperation
    @property (nonatomic,strong) BRUsuario *usuario;
    @property (nonatomic, readonly) BOOL wasSaved;
    @property (nonatomic, copy) completion_block_saveUsers completionHandler;
@end
