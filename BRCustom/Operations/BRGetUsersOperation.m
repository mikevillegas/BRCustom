//
//  BRGetUsersOperation.m
//  BRCustom
//
//  Created by Miguel Villegas on 10/07/18.
//  Copyright © 2018 Miguel Villegas. All rights reserved.
//

#import "BRGetUsersOperation.h"
#import "BRDataBaseManager.h"
#import "BRUsuario.h"

@interface BRGetUsersOperation()
    @property (assign) BOOL isFinishingWithError;
    @property(copy, readonly) NSError *errorOperation;
    @property (readwrite) BOOL isExecuting;
    @property (readwrite) BOOL isFinished;
    @property (nonatomic, strong) BRDataBaseManager *dbManager;
    @property (nonatomic, strong) NSArray *usuariosArray;
@end

@implementation BRGetUsersOperation



-(void)main{
    if ([self isCancelled]) {
        [self terminate];
    }
    
    self.dbManager = [[BRDataBaseManager alloc]initWithDatabaseName:@"brUsuarios.sqlite"];
    [self.dbManager getUsersFromTableWithCompletionHandler:^(NSArray *result, NSError *error) {
        if (error){
            self->_errorOperation =error;
            self->_isFinishingWithError = YES;
        }
        self.usuariosArray =result;
        
        [self terminate];
    }];
    
}


-(void)start{
    if ([self isCancelled]) {
        [self terminate];
    }
    [self main];
}


-(void)terminate{
    id result = self.usuariosArray;
    
    if (self.completionHandler) {
        [self willChangeValueForKey:@"isFinished"];
        [self willChangeValueForKey:@"isExecuting"];
        _isExecuting = NO;
        _isFinished = YES;
        [self didChangeValueForKey:@"isExecuting"];
        [self didChangeValueForKey:@"isFinished"];
        
        if([self isFinished]){
            NSLog(@"La Operación fue finalizada");
        }
        
        if([self isFinishingWithError]){
            self.completionHandler(result,_errorOperation,NO);
            return;
        }
        if ([self isCancelled]) {
            NSLog(@"La Operación fue cancelada");
            self.completionHandler(nil,nil,YES);
            return;
        }
        self.completionHandler(result,_errorOperation,NO);
        NSLog(@"La Operación ha terminado");
    }
    
}

-(void)cancel{
    [super cancel];
    NSLog(@"Canceling Operation");
}
@end
