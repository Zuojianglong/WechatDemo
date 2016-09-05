//
//  FMDBMessage.m
//  WeiXinTest
//
//  Created by long on 16/5/24.
//  Copyright © 2016年 long. All rights reserved.
//

#import "FMDBMessage.h"
#import "FMDB.h"
static FMDatabaseQueue *_queue;
@implementation FMDBMessage
+ (void)initialize{
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) lastObject];
    NSString *chatFilePath = [NSString stringWithFormat:@"%@/Application Support/%@/XMPPMessageArchiving.sqlite",path,APP_ID];
    
    _queue = [FMDatabaseQueue databaseQueueWithPath:chatFilePath];
}
+ (void)deleteChatData:(NSString *)jid{
    
    [_queue inDatabase:^(FMDatabase *db) {
        
        BOOL b = [db executeUpdate:@"delete from ZXMPPMESSAGEARCHIVING_MESSAGE_COREDATAOBJECT where ZBAREJIDSTR=?",jid];
        if (!b) {
            NSLog(@"删除聊天数据失败");
        }
        
        
    }];
    
}
@end
