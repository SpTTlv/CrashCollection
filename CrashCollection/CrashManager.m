//
//  CrashManager.m
//  CrashCollection
//
//  Created by Lv on 2016/11/8.
//  Copyright © 2016年 Lv. All rights reserved.
//

#import "CrashManager.h"

#define CrashFilePath [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"CrashManager.data"]
@implementation CrashManager

static CrashManager * _instance = nil;

+ (instancetype)shareCrashManager
{
    return _instance;
}
+(void)load
{
    _instance = [[self alloc] init];
}
+ (instancetype)alloc
{
    if (_instance) {
        @throw [NSException exceptionWithName:@"NSInternalInconsistencyException" reason:@"There can only be one Person instance." userInfo:nil];
    }
    return [super alloc];
}
+ (void)save:(CrashManager *)manager
{
    [NSKeyedArchiver archiveRootObject:manager toFile:CrashFilePath];
}
+ (void)read:(void (^)(BOOL,CrashManager *))block
{
    CrashManager * manager =(CrashManager *)[NSKeyedUnarchiver unarchiveObjectWithFile:CrashFilePath];
    if ([manager.name isEqualToString:@"(null)"] || manager.name == nil) {
        block(NO,manager);
    }else block(YES,manager);
 
}
+ (void)postServer:(CrashManager *)manager
{
    //上传
    NSLog(@"上传服务器");
    //上传成功后删除本地文件
    NSFileManager * fileManager =[NSFileManager defaultManager];
    BOOL existsFile =  [fileManager fileExistsAtPath:CrashFilePath];
    if (existsFile) {
        [fileManager removeItemAtPath:CrashFilePath error:nil];
    }
}
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:@"name"];
    [aCoder encodeObject:_reason forKey:@"reason"];
    [aCoder encodeObject:_className forKey:@"className"];
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _name = [aDecoder decodeObjectForKey:@"name"];
        _reason = [aDecoder decodeObjectForKey:@"reason"];
        _className = [aDecoder decodeObjectForKey:@"className"];
    }
    return self;
}
@end
