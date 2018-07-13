//
//  BRDataBaseManager.m
//  BRCustom
//
//  Created by Miguel Villegas on 09/07/18.
//  Copyright © 2018 Miguel Villegas. All rights reserved.

#import "BRDataBaseManager.h"
#import <sqlite3.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"


@interface BRDataBaseManager()
@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;
@property (nonatomic, strong) NSMutableArray * usuarios;
@end

@implementation BRDataBaseManager
-(id)initWithDatabaseName:(NSString *)name{
    if (self = [super init]) {
        // Initialize self
        self.databaseFilename = name;
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [paths objectAtIndex:0];
        [self copyDatabaseIntoDocumentsDirectory];
    }
    return self;
}


-(void)copyDatabaseIntoDocumentsDirectory{
    // Check if the database file exists in the documents directory.
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        // The database file does not exist in the documents directory, so copy it from the main bundle now.
        NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
        
        NSString *sourcePath = [[frameworkBundle resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        // Check if any error occurred during copying and display it.
        if (error != nil) {
            NSLog(@"%@", [error localizedDescription]);
        }else{
            NSLog(@"La base de datos fue copiada en %@",destinationPath);
        }
    }
}

-(void)getUsersFromTableWithCompletionHandler:(void (^)(NSArray *result, NSError *error))completion{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:self.databaseFilename];
    NSError *error = nil;
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    [database open];
    FMResultSet *results = [database executeQuery:@"SELECT * FROM usuarios"];
    self.usuarios = [[NSMutableArray alloc]init];
    while([results next]) {
        BRUsuario *user = [[BRUsuario alloc]init];
        user.nombre = [results stringForColumn:@"nombre"];
        user.apellidos = [results stringForColumn:@"apellidos"];
        user.fechaNacimiento = [results stringForColumn:@"fechaNacimiento"];
        user.direccion = [results stringForColumn:@"direccion"];
        user.foto = [results objectForColumn:@"imagen"];
        [self.usuarios addObject:user];
    }
    if ([database hadError]){
        error= database.lastError;
    }
    [database close];
   
    if (completion)
        completion(self.usuarios, error);
}

-(void)insertUserWith:(BRUsuario*)user withCompletionHandler:(void (^)(NSError *error))completion{
    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [docPaths objectAtIndex:0];
    NSError *error = nil;
    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:self.databaseFilename];
    NSString *sqlSearchDuplicates = [NSString stringWithFormat:@"select count(id) from usuarios where nombre = '%@' and apellidos = '%@'", user.nombre, user.apellidos];
    
    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
    if (![database open]) {
        NSLog(@"No se pudo abrir la bd Medios.");
        [database close];
        error= database.lastError;
    }
    if(![database intForQuery:sqlSearchDuplicates]) {
        [database executeUpdate:@"INSERT INTO usuarios (nombre, apellidos, fechaNacimiento, direccion,imagen) VALUES (?, ?, ?, ?,?)", user.nombre, user.apellidos, user.fechaNacimiento, user.direccion,user.foto];
        if ([database hadError]) {
            NSLog(@"Error al insertar");
            error= database.lastError;
            [database close];
            
        }
        NSLog(@"El usuario se ha insertado correctamente");
        [database close];
    }else{
        NSLog(@"El Registro ya existe");
         error= database.lastError;
        [database close];
        
    }
    if (completion)
        completion(error);
}

//-(void)updateDataFromTable{
//    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDir = [docPaths objectAtIndex:0];
//    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:self.databaseFilename];
//
//    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
//    [database open];
//    //    [database executeUpdate:@"UPDATE tableName set fieldName= ? where fieldName= ?", [NSNumber numberWithLong:fieldVariable], [NSString stringWithFormat:@"%@", fieldVariable], nil];
//    [database close];
//}
//-(void)deleteDataFromTable{
//    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDir = [documentPaths objectAtIndex:0];
//    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:self.databaseFilename];
//
//    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
//    [database open];
//    //    [database executeUpdate:@"DELETE FROM tableName WHERE fieldName= ? and fieldName= ?", [NSString stringWithFormat:@"%@", fieldVariable], [NSNumber numberWithLong:fieldVariable], nil];
//    [database close];
//}


//-(void)crearTable{
//    NSArray *docPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDir = [docPaths objectAtIndex:0];
//    NSString *dbPath = [documentsDir   stringByAppendingPathComponent:self.databaseFilename];
//
//    FMDatabase *database = [FMDatabase databaseWithPath:dbPath];
//    [database open];
//    [database executeUpdate:@"CREATE TABLE tablename (id INTEGER  PRIMARY KEY DEFAULT NULL,field1Name INTEGER DEFAULT NULL,field2Name INTEGER DEFAULT NULL,field3Name INTEGER DEFAULT NULL,field4Name TEXT DEFAULT NULL)"];
//    [database close];
//}
@end
