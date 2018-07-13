//
//  BRSaveUserOperation.m
//  BRCustom
//
///  Created by Miguel Villegas on 7/10/18.
//  Copyright © 2018 Miguel Villegas. All rights reserved.
//
#import "BRSaveUserOperation.h"
#import "BRDataBaseManager.h"
@interface BRSaveUserOperation()
    @property (assign) BOOL isFinishingWithError;
    @property(copy, readonly) NSError *errorOperation;
    @property (readwrite) BOOL isExecuting;
    @property (readwrite) BOOL isFinished;
    @property (nonatomic, strong) BRDataBaseManager *dbManager;
@end


@implementation BRSaveUserOperation
-(void)main{
    if ([self isCancelled]) {
        [self terminate];
    }
    self.dbManager = [[BRDataBaseManager alloc]initWithDatabaseName:@"brUsuarios.sqlite"];
    [self.dbManager insertUserWith:self.usuario withCompletionHandler:^(NSError *error) {
        if (error){
            self->_errorOperation =error;
            self->_isFinishingWithError = YES;
        }
        
         [self terminate];
    }];
    
}


-(void)start{
    
    if ([self isCancelled]) {
        [self terminate];
    }
    [self main];
    
}


- (void) terminate {
    
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
            self.completionHandler(_errorOperation,NO);
            return;
        }
        if ([self isCancelled]) {
            NSLog(@"La Operación fue cancelada");
            self.completionHandler(nil,YES);
            return;
        }
        self.completionHandler(_errorOperation,NO);
        NSLog(@"La Operación ha terminado");
    }
}

-(void)cancel{
    [super cancel];
    NSLog(@"Canceling Operation");
}
@end
