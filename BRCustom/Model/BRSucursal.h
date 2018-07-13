//
//  BRSucursal.h
//  BRCustom
//
//  Created by Miguel Villegas on 07/07/18.
//  Copyright © 2018 Miguel Villegas. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BRSucursal : NSObject <NSCoding>
@property(nonatomic, copy) NSString *  abre24HORAS;
@property(nonatomic, copy) NSString *  abreSabados;
@property(nonatomic, copy) NSString * ciudad;
@property(nonatomic, copy) NSString * correo_Gerente;
@property(nonatomic, copy) NSString * domicilio;
@property(nonatomic, copy) NSString * estado;
@property(nonatomic, copy) NSString * horario;
@property(nonatomic, copy) NSString * latitud;
@property(nonatomic, copy) NSString * longitud;
@property(nonatomic, copy) NSString * nombre;
@property(nonatomic, copy) NSString * telefono_app;
@property(nonatomic, copy) NSString * telefono_portal;
@property(nonatomic, copy) NSString * url_foto;
@property(nonatomic, copy) NSString *tipo;
@property(nonatomic, copy) NSString *idSucursal;
@property(nonatomic, copy) NSString *suc_Ciudad_Prioridad;
@property(nonatomic, copy) NSString *suc_Estado_Prioridad;


@end
