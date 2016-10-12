//
//  VersionManager.h
//  VersionManager
//
//  Created by lwx on 16/10/12.
//  Copyright © 2016年 lwx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionManager : NSObject



#define VERSIONMGR  [VersionMgr sharedInstance]


/**
 *  单例类
 *
 *  @return 返回单例对象
 */
+ (instancetype)sharedInstance;



// 版本号
@property (nonatomic, strong) NSString  *version;
// 是否强制更新 1-是 0 -否
@property (nonatomic ,assign) NSInteger isForceStatus;
// 暂时冗余
@property (nonatomic ,copy) NSString    *versionMessage;
// 版本更新内容
@property (nonatomic ,copy) NSString    *versionUpdateContent;
// 是否提示更新
@property (nonatomic ,assign) BOOL      isTipUpdateVersion;


/**
 *  判断引导页面是否已经展示
 */
@property (nonatomic,assign) BOOL  isShowHomeGuideView;

@property (nonatomic,assign) BOOL  isShowDiscoverGuideView;

@property (nonatomic,assign) BOOL  isShowInviteGuideView;

@property (nonatomic,assign) BOOL  isShowMineGuideView;

/**
 *  检查版本的回调
 *
 *  @param success 成功回调的block
 *  @param fail    失败回调的block
 */
-(void)checkVersionSuccess:(void(^)())success fail:(void(^)())fail;

// 检验是否是最新版本
- (BOOL)checkVersionIsNew;


@end
