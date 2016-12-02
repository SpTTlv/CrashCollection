//
//  CrashManager.h
//  CrashCollection
//
//  Created by Lv on 2016/11/8.
//  Copyright © 2016年 Lv. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CrashManager : NSObject<NSCoding>

/**崩溃类型 */
@property (nonatomic,strong) NSString *name;

/**崩溃原因 */
@property (nonatomic,strong) NSString *reason;

/**栈信息 */
@property (nonatomic,strong) NSString *className;

/**根据需要选择需不需要创建单例*/
+ (instancetype)shareCrashManager;
/**保存*/
+ (void)save:(CrashManager *)manager;
/**读取*/
+ (void)read:(void (^)(BOOL,CrashManager *))block;
/**上传服务器*/
+ (void)postServer:(CrashManager *)manager;

@end
