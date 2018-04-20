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

@property (nonatomic, strong) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowId;

- (id) initWithDatabaseFileName:(NSString *) dbFileName;

- (NSArray *) loadData:(NSString *) query;
- (void) executeQuery:(NSString *) query;
@end
