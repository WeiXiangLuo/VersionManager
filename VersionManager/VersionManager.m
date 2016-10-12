//
//  VersionManager.m
//  VersionManager
//
//  Created by lwx on 16/10/12.
//  Copyright © 2016年 lwx. All rights reserved.
//

#import "VersionManager.h"

@implementation VersionManager


- (instancetype)init
{
    self = [super init];
    if (self) {
        if (![self isNotNil:self.version]) {
            self.version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
        }
    }
    return self;
}

+ (instancetype)sharedInstance {
    static id sharedObject = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedObject = [[self alloc] init];
    });
    return sharedObject;
}

- (id)copyWithZone:(NSZone*)zone{
    return self;
}


/**
 *  判断字符串是否为空的方法
 *
 *  @param string 需要判断的字符串
 *
 *  @return 判断结果
 */
- (BOOL)isNotNil:(NSString *)string {
    if (string == nil || (id)string == [NSNull null] || [string isEqualToString:@""])
        return NO;
    return YES;
}


#pragma mark - 版本检测的回调方法
-(void)checkVersionSuccess:(void(^)())success fail:(void(^)())fail{
//    __weak __typeof(self) wself = self;
    [self checkIsluanchOptions];
    [self  checkIsFirstLuanchOption];
    //发送请求获得最新版本号
//    [[NetMine checkAPPVersion] requestSuccess:^(id JSON) {
//   
//        if (success) {
//            success();
//        }
//    } failure:^(id JSON) {
//        if (fail) {
//            fail();
//        }
//    }];
}


/**
 *  检查是否已经启动
 */
- (void)checkIsluanchOptions{
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"everLaunched"]) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"everLaunched"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
    }else {
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }
}


/**
 *  YES是第一次登陆，NO不是
 */
- (void)checkIsFirstLuanchOption{
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]) {
        self.isShowHomeGuideView = YES;
        self.isShowInviteGuideView = YES;
        self.isShowDiscoverGuideView = YES;
        self.isShowMineGuideView = YES;
        [[NSUserDefaults standardUserDefaults] setBool:NO forKey:@"firstLaunch"];
    }else{
        self.isShowHomeGuideView = NO;
        self.isShowMineGuideView = NO;
        self.isShowDiscoverGuideView = NO;
        self.isShowMineGuideView = NO;
    }
}



- (BOOL)checkVersionIsNew{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if ([self.version isEqualToString:version]) {
        return YES;
    }else{
        return NO;
    }
}



/**
 *  检查版本
 */
- (void)checkVersion{
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    if ([self.version isEqualToString:version]) {
        self.isTipUpdateVersion = NO;
        self.version = version;
    }else{
        self.isTipUpdateVersion = YES;
    }
}



@end
