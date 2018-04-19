//
//  DBManager.m
//  SQLite3DBSample
//
//  Created by ith on 4/19/18.
//  Copyright © 2018 ith. All rights reserved.
//

#import "DBManager.h"


@interface DBManager()

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;
@property (nonatomic, strong) NSMutableArray *arrayResults;

- (void) copyDatabaseIntoDocumentsDirectory;
-(BOOL) runQuery : (NSString *)query isQueryExecutable:(BOOL) queryExecutable;

@end



@implementation DBManager

-(id) initWithDatabaseFileName:(NSString *)dbFileName{
    self = [super init];
    if(self){
        //get the documents directory
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentsDirectory = [paths objectAtIndex:0];
        //keep the database filename
        self.databaseFilename = dbFileName;
        //copy the database filename into documents directory
        [self copyDatabaseIntoDocumentsDirectory];
    }
    
    return self;
}

- (void)copyDatabaseIntoDocumentsDirectory{
    //TODO: modify code so that the path for the database directory is checked only once
    
    
    //check if the database file exists at the documents directory
    NSString *destinationPath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    
    if(![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]){
        //copy the path from the main bundle
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        if(error != nil){
            NSLog(@"%@", [error localizedDescription]);
        }
    }
}

@end
