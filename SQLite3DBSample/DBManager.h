//
//  DBManager.h
//  SQLite3DBSample
//
//  Created by ith on 4/19/18.
//  Copyright © 2018 ith. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject

@property (nonatomic, strong) NSString *documentsDirectory;
@property (nonatomic, strong) NSString *databaseFilename;

- (id) initWithDatabaseFileName:(NSString *) dbFileName;
- (void) copyDatabaseIntoDocumentsDirectory;
@end
