//
//  FMDBTools.m
//  WeiXinTest
//
//  Created by long on 16/5/23.
//  Copyright © 2016年 long. All rights reserved.
//

#import "FMDBTools.h"
#import "FMDB.h"
#import "HomeModel.h"

static FMDatabaseQueue *_queue = nil;
@implementation FMDBTools
+ (void)initialize{
    
    NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]stringByAppendingPathComponent:@"chat.sqlite"];
    _queue = [FMDatabaseQueue databaseQueueWithPath:filePath];
    //创建表
    [_queue inDatabase:^(FMDatabase *db) {
        BOOL b = [db executeUpdate:@"create table if not exists message(ID integer primary key autoincrement,head blob,uname text,detailname text,time text,badge text,jid blob)"];
        if (!b) {
            NSLog(@"创建表失败!");
        }
    }];
    
    NSLog(@"%@",filePath);
}
//插入数据
+ (BOOL)addHead:(NSData *)head uname:(NSString *)uname detailName:(NSString *)detailName time:(NSString *)time badge:(NSString *)badge xmppjid:(XMPPJID *)jid{
    __block BOOL b;
    
    [_queue inDatabase:^(FMDatabase *db) {
        NSData *xmjid = [NSKeyedArchiver archivedDataWithRootObject:jid];
        NSString *sql = [NSString stringWithFormat:@"insert into message(head,uname,detailname,time,badge,jid) values(%@,'%@','%@','%@','%@',%@)",head,uname,detailName,time,badge,xmjid];
        
        b = [db executeUpdate:sql];
        
    }];
    
    return b;
}
//判断用户是否存在
+ (BOOL)selectUname:(NSString *)uname{
    
    __block BOOL b = NO;
    [_queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *rs=[db executeQuery:@"select * from message where uname=?",uname];
        while ([rs next]) {
            b = YES;
        }
        
    }];
    return b;
}
//更新数据
+ (BOOL)updateWithName:(NSString *)uname detailName:(NSString *)detailName time:(NSString *)time badge:(NSString *)badge{
    
    __block BOOL b;
    [_queue inDatabase:^(FMDatabase *db) {
        
        b = [db executeUpdate:@"update message set detailname=?,time=? ,badge=? where uname=?",detailName,time,badge,uname];

    }];

    return b;
}
/*
 NSDictionary *dict=@{@"uname":[jid user],@"time":strDate,@"body":body,@"jid":jid};
 */
//查询所有数据
+ (NSArray *)selectAllDatas{
    
    __block NSMutableArray *arr = nil;
    [_queue inDatabase:^(FMDatabase *db) {
        //按照time字段降序查找,如果不写 desc就是升序;
        FMResultSet *rs = [db executeQuery:@"select * from message order by time desc"];
        if (rs) {
            arr = [NSMutableArray array];
            if ([rs next]) {
                
                HomeModel *model = [HomeModel new];
                model.uname = [rs stringForColumn:@"uname"];
                model.body = [rs stringForColumn:@"detailname"];
                model.time = [rs stringForColumn:@"time"];
                model.badgeValue = [rs stringForColumn:@"badge"];
                model.headerIcon = [rs dataForColumn:@"head"];
                //获取xmppJID
                model.jid = [NSKeyedUnarchiver unarchiveObjectWithData:[rs dataForColumn:@"jid"]];
                [arr addObject:model];
            }
        }
    }];
    
    return arr;
}
//清除小红点
+ (void)clearRedPointWithName:(NSString *)uname{
    
    [_queue inDatabase:^(FMDatabase *db) {
        
        [db executeUpdate:@"update message set badge='' where uname=?",uname];
    }];
}
#pragma mark 删除聊天记录
+ (void)deleteWithName:(NSString *)uname{
   [_queue inDatabase:^(FMDatabase *db) {
       BOOL b = [db executeUpdate:@"delete  from message where uname=?",uname];
       if (!b) {
           NSLog(@"删除失败!");
       }
   }];
}
@end
