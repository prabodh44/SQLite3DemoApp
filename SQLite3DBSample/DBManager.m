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

- (BOOL)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable{
    //1. set the database path
    sqlite3 *sqlite3Database;
    
    NSString *databasePath = [self.documentsDirectory stringByAppendingPathComponent:self.databaseFilename];
    
    //2 .initialize the two mutable arrays
    if(_arrayResults != nil){
        [_arrayResults removeAllObjects];
        _arrayResults = nil;
    }
    _arrayResults = [[NSMutableArray alloc] init];
    
    if(_arrColumnNames != nil){
        [_arrColumnNames removeAllObjects];
        _arrColumnNames = nil;
    }
    _arrColumnNames = [[NSMutableArray alloc] init];
    
    //3. Open the database
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
    if(openDatabaseResult == SQLITE_OK){
        sqlite3_stmt *compiledStatement;
        
        BOOL preparedStatementResult = sqlite3_prepare_v2(sqlite3Database, query, -1, &compiledStatement, NULL);
        if(preparedStatementResult == SQLITE_OK){
            //4. Check if the query is executable or not
            NSMutableArray *arrayDataRow;
            if(!queryExecutable){
                //for select query
                while(sqlite3_step(compiledStatement) == SQLITE_ROW){
                    arrayDataRow = [[NSMutableArray alloc] init];
                    //convert the column data into text
                    int totalColumnCount = sqlite3_column_count(compiledStatement);
                    for(int i = 0; i < totalColumnCount; i++){
                        char *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
                        
                        if(dbDataAsChars != NULL){
                            //add the data into arrayDataRow after conversion
                            NSString *dbData = [NSString stringWithUTF8String:dbDataAsChars];
                            [arrayDataRow addObject:dbData];
                        }
                        
                        //add the current column name
                        if([_arrColumnNames count] != totalColumnCount){
                            NSString *columnName = [NSString stringWithUTF8String:sqlite3_column_name(compiledStatement, i)];
                            [_arrColumnNames addObject:columnName];
                        }
                        
                        
                    }
                }
            }else{
                //for insert, delete and update
            }
        }
    }
    
    
}

@end
