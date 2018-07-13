//
//  BRSucursal.m
//  BRCustom
//
//  Created by Miguel Villegas on 07/07/18.
//  Copyright © 2018 Miguel Villegas. All rights reserved.
//

#import "BRSucursal.h"


@implementation BRSucursal

- (void)encodeWithCoder:(NSCoder*)encoder
{
    [encoder encodeObject:self.ciudad forKey:@"ciudad"];
    [encoder encodeBool:self.abre24HORAS forKey:@"abre24HORAS"];
    [encoder encodeBool:self.abreSabados forKey:@"abreSabados"];
    [encoder encodeObject:self.correo_Gerente forKey:@"correo_Gerente"];
    [encoder encodeObject:self.domicilio forKey:@"domicilio"];
    [encoder encodeObject:self.horario forKey:@"horario"];
    [encoder encodeObject:self.latitud forKey:@"latitud"];
    [encoder encodeObject:self.longitud forKey:@"longitud"];
    [encoder encodeObject:self.nombre forKey:@"nombre"];
    [encoder encodeObject:self.telefono_app forKey:@"telefono_app"];
    [encoder encodeObject:self.telefono_portal forKey:@"telefono_portal"];
    [encoder encodeObject:self.url_foto forKey:@"url_foto"];
    [encoder encodeObject:self.idSucursal forKey:@"idSucursal"];
    [encoder encodeObject:self.suc_Ciudad_Prioridad forKey:@"suc_Ciudad_Prioridad"];
    [encoder encodeObject:self.suc_Estado_Prioridad forKey:@"suc_Estado_Prioridad"];
    [encoder encodeObject:self.tipo forKey:@"tipo"];
}

- (id)initWithCoder:(NSCoder*)decoder
{
    if ((self = [super init]))
    {
        self.ciudad = [decoder decodeObjectForKey:@"ciudad"];
        self.abre24HORAS = [decoder decodeObjectForKey:@"abre24HORAS"];
        self.abreSabados = [decoder decodeObjectForKey:@"abreSabados"];
        self.correo_Gerente = [decoder decodeObjectForKey:@"correo_Gerente"];
        self.domicilio = [decoder decodeObjectForKey:@"domicilio"];
        self.estado = [decoder decodeObjectForKey:@"estado"];
        self.horario = [decoder decodeObjectForKey:@"horario"];
        self.latitud = [decoder decodeObjectForKey:@"latitud"];
        self.longitud = [decoder decodeObjectForKey:@"longitud"];
        self.nombre = [decoder decodeObjectForKey:@"nombre"];
        self.telefono_app = [decoder decodeObjectForKey:@"telefono_app"];
        self.telefono_portal = [decoder decodeObjectForKey:@"telefono_portal"];
        self.url_foto = [decoder decodeObjectForKey:@"ciudad"];
        self.idSucursal = [decoder decodeObjectForKey:@"idSucursal"];
        self.suc_Ciudad_Prioridad = [decoder decodeObjectForKey:@"suc_Ciudad_Prioridad"];
        self.suc_Estado_Prioridad = [decoder decodeObjectForKey:@"suc_Estado_Prioridad"];
        self.tipo = [decoder decodeObjectForKey:@"tipo"];
    }
    return self;
}

@end
