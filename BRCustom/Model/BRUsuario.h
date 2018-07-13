//
//  BRUsuario.h
//  BRCustom
//
//  Created by Miguel Villegas on 09/07/18.
// Copyright © 2018 Miguel Villegas. All rights reserved.

#import <Foundation/Foundation.h>

@interface BRUsuario : NSObject
    @property(nonatomic, copy) NSString *  nombre;
    @property(nonatomic, copy) NSString *  apellidos;
    @property(nonatomic, copy) NSString * fechaNacimiento;
    @property(nonatomic, copy) NSString * direccion;
    @property(nonatomic, copy) NSData * foto;
@end
