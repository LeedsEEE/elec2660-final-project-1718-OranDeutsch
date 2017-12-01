//
//  AppDelegate.h
//  I owe you owe
//
//  Created by Oran Deutsch [el16od] on 21/11/2017.
//  Copyright © 2017 Oran Deutsch [el16od]. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <UserNotifications/UserNotifications.h>

#define SYSTEM_VERSION_GRATERTHAN_OR_EQUALTO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface AppDelegate : UIResponder <UIApplicationDelegate,UNUserNotificationCenterDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;


- (void)saveContext;

@end

