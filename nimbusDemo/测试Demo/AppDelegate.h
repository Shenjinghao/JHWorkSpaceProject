//
//  AppDelegate.h
//  测试Demo
//
//  Created by Shenjinghao on 15/8/25.
//  Copyright (c) 2015年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


/**
 *  sharedInstance
 */
+ (AppDelegate *) sharedInstance;

@property (nonatomic, strong) JHTabBarController* tabbarController;
/**
 *  栈顶的控制器
 */
@property (nonatomic, strong) JHViewController* topViewController;
@property (nonatomic, strong) JHNavigationController* navigationController;


@end

