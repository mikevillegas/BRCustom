//
//  BRSucursaleskit.m
//  BRCustom
//
//  Created by Miguel Villegas on 09/07/18.
//  Copyright © 2018 Miguel Villegas. All rights reserved.

#import "BRSucursalesKit.h"
#import "BRRequestOperation.h"
#import "BRSucursal.h"

@interface BRSucursalesKit()
    @property(nonatomic,strong) BRRequestOperation *sucursalesOperation;
    @property(nonatomic, strong)NSOperationQueue *operationQueue;
@end

@implementation BRSucursalesKit


-(id)init{
    if (self = [super init]) {
        // Initialize self
    }
    return self;
}


-(void)getSucursalesDataWithCompletionHandler:(void (^)(NSArray *result, NSError *error, BOOL wasCancelled))completion{
    _sucursalesOperation = [[BRRequestOperation alloc]init];
    _sucursalesOperation .urlRequest    =   @"http://json.banregio.io/sucursales";
    _sucursalesOperation .completionHandler= ^(id result, NSError *error,BOOL wasCancelled){
        if(error)
            NSLog(@"%@",[NSString stringWithFormat:@"La Operación tuvo un error %@", error.description]);
        if(wasCancelled){
            NSLog(@"%@",[NSString stringWithFormat:@"La Operación fue cancelada"]);
        }
        NSMutableArray *sucursalesArray = [[NSMutableArray alloc]init];
        for (id tempObject in result) {
            BRSucursal * sucursal = [[BRSucursal alloc]init];
            sucursal.abre24HORAS = [tempObject objectForKey:@"24_HORAS"];
            sucursal.ciudad = [tempObject objectForKey:@"CIUDAD"];
            sucursal.domicilio = [tempObject objectForKey:@"DOMICILIO"];
            sucursal.estado = [tempObject objectForKey:@"ESTADO"];
            sucursal.horario = [tempObject objectForKey:@"HORARIO"];
            sucursal.idSucursal = [tempObject objectForKey:@"ID"];
            sucursal.latitud = [tempObject objectForKey:@"Latitud"];
            sucursal.longitud = [tempObject objectForKey:@"Longitud"];
            sucursal.nombre = [tempObject objectForKey:@"NOMBRE"];
            sucursal.abreSabados = [tempObject objectForKey:@"SABADOS"];
            sucursal.suc_Estado_Prioridad = [tempObject objectForKey:@"Suc_Ciudad_Prioridad"];
            sucursal.suc_Ciudad_Prioridad = [tempObject objectForKey:@"Suc_Estado_Prioridad"];
            sucursal.telefono_app = [tempObject objectForKey:@"TELEFONO_APP"];
            sucursal.telefono_portal = [tempObject objectForKey:@"TELEFONO_PORTAL"];
            sucursal.url_foto = [tempObject objectForKey:@"URL_FOTO"];
            sucursal.tipo = [tempObject objectForKey:@"tipo"];
            [sucursalesArray addObject:sucursal];

        }
        
        if (completion)
            completion(sucursalesArray, error,wasCancelled);
    };
    _operationQueue=[NSOperationQueue new];
    [_operationQueue addOperation:self.sucursalesOperation ];
}
@end
