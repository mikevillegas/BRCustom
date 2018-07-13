//
//  BRRequestOperation.m
//  BRCustom
//
//  Created by Miguel Villegas on 07/07/18.
//  Copyright © 2018 Miguel Villegas. All rights reserved.
//

#import "BRRequestOperation.h"
@interface BRRequestOperation()
    @property (assign) BOOL isFinishingWithError;
    @property(copy, readonly) NSError *errorOperation;
    @property (readwrite) BOOL isExecuting;
    @property (readwrite) BOOL isFinished;
@end


@implementation BRRequestOperation
@synthesize urlRequest;


-(void)main{
    if ([self isCancelled]) {
        [self terminate];
    }

    NSLog(@"%@", [NSString stringWithFormat:@"La Operación se está ejecutando %@", ([self isExecuting] ? @"YES" : @"NO")]);
    NSURL *myurl = [NSURL URLWithString:self.urlRequest];
     NSURLRequest *request=[NSURLRequest requestWithURL:myurl];
    if ([self isCancelled]) {
        [self terminate];
    }
    NSURLSession *session =[NSURLSession sharedSession];
    [[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable dataResult, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSInteger statusCode = [((NSHTTPURLResponse *)response) statusCode];
        if (statusCode >= 400)  {
            NSDictionary* errorInfo = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:
                                                                          NSLocalizedString(@"AsyncRequest: El server regreso un error = %d", @""), statusCode] forKey:NSLocalizedDescriptionKey];
            
            error = [NSError errorWithDomain:@"HTTP" code:statusCode userInfo:errorInfo];
            [self terminate];
            
        }
        if (error || !dataResult) {
            self->_errorOperation=error;
            [self willChangeValueForKey:@"isFinishingWithError"];
            self->_isFinishingWithError = YES;
            [self didChangeValueForKey:@"isFinishingWithError"];
            [self terminate];
        }else{
            if ([self isCancelled]) {
                [self terminate];
            }
            
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:dataResult options:NSJSONReadingAllowFragments error:&error];
            if (error) {
                self->_errorOperation=error;
                [self terminate];
            }
            
            self->_result = json;
            [self terminate];
        }
    } ]resume];
    
    
}

-(void)start{
    
    if ([self isCancelled]) {
        [self terminate];
    }
    [self main];
    
}

- (void) terminate {
    id result = _result;
    
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
