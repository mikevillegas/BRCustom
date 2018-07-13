//
//  BRLoginKit.m
//  BRCustom
//
//  Created by Miguel Villegas on 09/07/18.
//  Copyright © 2018 Miguel Villegas. All rights reserved.

#import "BRLoginKit.h"
#import "BRRequestOperation.h"


@interface BRLoginKit()
@property(nonatomic,strong) BRRequestOperation *loginOperation;
@property(nonatomic, strong)NSOperationQueue *operationQueue;
@end

@implementation BRLoginKit

-(id)init{
    if (self = [super init]) {
        // Initialize self
    }
    return self;
}
-(void)getLoginDataWithCompletionHandler:(void (^)(NSDictionary *result, NSError *error, BOOL wasCancelled))completion{
    _loginOperation = [[BRRequestOperation alloc]init];
    _loginOperation.urlRequest    =   @"http://json.banregio.io/login";
    _loginOperation.completionHandler= ^(id result, NSError *error,BOOL wasCancelled){
        if(error)
            NSLog(@"%@",[NSString stringWithFormat:@"La Operación tuvo un error %@", error.description]);
        if(wasCancelled){
            NSLog(@"%@",[NSString stringWithFormat:@"La Operación fue cancelada"]);
        }
        if (completion)
            completion(result, error,wasCancelled);
    };
    _operationQueue=[NSOperationQueue new];
    [_operationQueue addOperation:_loginOperation];
}

@end
