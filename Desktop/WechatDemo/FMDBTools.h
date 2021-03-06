//
//  FMDBTools.h
//  WeiXinTest
//
//  Created by long on 16/5/23.
//  Copyright © 2016年 long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBTools : NSObject
/*
 head blob,uname text,detailname text,time text,badge text
 */

//添加数据
+(BOOL)addHead:(NSData*)head uname:(NSString*)uname detailName:(NSString*)detailName time:(NSString*)time badge:(NSString*)badge xmppjid:(XMPPJID*)jid ;
//查询判断数据有没有存在
+(BOOL)selectUname:(NSString*)uname;
//更新数据库里面的东西
+(BOOL)updateWithName:(NSString*)uname detailName:(NSString*)detailName time:(NSString*)time badge:(NSString*)badge;
//查询所有的数据
+(NSArray*)selectAllDatas;
//清除小红点的方法
+(void)clearRedPointWithName:(NSString *)uname;
//删除聊天数据的方法
+(void)deleteWithName:(NSString*)uname;

@end
