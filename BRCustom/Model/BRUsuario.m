//
//  BRUsuario.m
//  BRCustom
//
//  Created by Miguel Villegas on 09/07/18.
//  Copyright © 2018 Miguel Villegas. All rights reserved.

#import "BRUsuario.h"

@implementation BRUsuario
- (void)encodeWithCoder:(NSCoder*)encoder {
    [encoder encodeObject:self.nombre forKey:@"nombre"];
    [encoder encodeObject:self.apellidos forKey:@"apellidos"];
    [encoder encodeObject:self.fechaNacimiento forKey:@"fechaNacimiento"];
    [encoder encodeObject:self.direccion forKey:@"direccion"];
    [encoder encodeObject:self.foto forKey:@"foto"];
}
- (id)initWithCoder:(NSCoder*)decoder{
    if ((self = [super init])){
        self.nombre = [decoder decodeObjectForKey:@"nombre"];
        self.apellidos = [decoder decodeObjectForKey:@"apellidos"];
        self.fechaNacimiento = [decoder decodeObjectForKey:@"fechaNacimiento"];
        self.direccion = [decoder decodeObjectForKey:@"direccion"];
        self.foto = [decoder decodeObjectForKey:@"foto"];
    }
    return self;
}
@end
