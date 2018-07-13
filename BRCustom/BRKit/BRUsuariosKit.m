//
//  BRUsuariosKit.m
//  BRCustom
//
//  Created by Miguel Villegas on 12/07/18.
//  Copyright © 2018 Miguel Villegas. All rights reserved.

#import "BRUsuariosKit.h"
#import "BRSaveUserOperation.h"
#import "BRGetUsersOperation.h"

@interface BRUsuariosKit()
@property(nonatomic, strong)NSOperationQueue *operationQueue;
@end



@implementation BRUsuariosKit

-(id)init{
    if(self =[super init]){
        // Initialize self
    }
    return self;
}


-(void)saveUser:(BRUsuario *)user  withCompletionHandler:(void (^)( NSError *error, BOOL wasCancelled))completion{
    BOOL wasSaved= NO;
    BRSaveUserOperation * saveUserOp = [[BRSaveUserOperation alloc]init];
    saveUserOp.usuario = user;
    saveUserOp.completionHandler= ^(NSError *error,BOOL wasCancelled){
        if(error)
            NSLog(@"%@",[NSString stringWithFormat:@"La Operación tuvo un error %@", error.description]);
        if(wasCancelled){
            NSLog(@"%@",[NSString stringWithFormat:@"La Operación fue cancelada"]);
        }
        if (completion)
            completion(error,wasCancelled);
    };
    _operationQueue=[NSOperationQueue new];
    [_operationQueue addOperation:saveUserOp];
}

-(void)getAllUserWithCompletionHandler:(void (^)(NSArray *result, NSError *error, BOOL wasCancelled))completion{
    BRGetUsersOperation *getUserOp = [[BRGetUsersOperation alloc]init];
    getUserOp.completionHandler= ^(id result, NSError *error,BOOL wasCancelled){
        if(error)
            NSLog(@"%@",[NSString stringWithFormat:@"La Operación tuvo un error %@", error.description]);
        if(wasCancelled){
            NSLog(@"%@",[NSString stringWithFormat:@"La Operación fue cancelada"]);
        }
        if (completion)
            completion(result, error,wasCancelled);
    };
    _operationQueue=[NSOperationQueue new];
    [_operationQueue addOperation:getUserOp];
    
    
}

@end
