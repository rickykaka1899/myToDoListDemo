//
//  JYHAppDelegate.m
//  ToDoList
//
//  Created by Kaka on 8/20/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import "JYHAppDelegate.h"
#import "JYHFirstViewController.h"
#import "JYHSaveToCache.h"
#import "JYHToDoThingVO.h"


@implementation JYHAppDelegate

- (void)initLocationNotification
{
  NSArray *cacheList = [JYHSaveToCache readFromFile];
    //初始化
  UILocalNotification *locationNotification = [[UILocalNotification alloc]  init];
    //设置推送时间，这里使用相对时间，如果fireDate采用GTM标准时间，timeZone可以至nil
  for ( JYHToDoThingVO *vo in cacheList)
  {
    locationNotification.fireDate = vo.iRemindDate;
    locationNotification.timeZone = [NSTimeZone defaultTimeZone];
      //设置重复周期
    locationNotification.repeatInterval = NSWeekCalendarUnit;
      //设置通知的音乐
    locationNotification.soundName = UILocalNotificationDefaultSoundName;
      //设置通知内容
    locationNotification.alertBody = vo.iTodoStr;
      //设置程序的Icon数量,
    locationNotification.applicationIconBadgeNumber = [[[UIApplication sharedApplication] scheduledLocalNotifications] count] + 1;
      //执行本地推送
    [[UIApplication sharedApplication] scheduleLocalNotification:locationNotification];
  }
  [locationNotification release];
}

- (void)deletenotification
{
    // 手动删除通知
    // 这里我们要根据我们添加时设置的key和自定义的ID来删
  NSArray *narry=[[UIApplication sharedApplication] scheduledLocalNotifications];
  NSUInteger acount=[narry count];
  if (acount>0)
  {
      // 遍历找到对应nfkey和notificationtag的通知
    for (int i=0; i<acount; i++)
      
    {
      UILocalNotification *myUILocalNotification = [narry objectAtIndex:i];
//      [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
      NSDictionary *userInfo = myUILocalNotification.userInfo;
      NSNumber *obj = [userInfo objectForKey:@"nfkey"];
      int mytag=[obj intValue];
      if (mytag==1)
      {
          // 删除本地通知
        [[UIApplication sharedApplication] cancelLocalNotification:myUILocalNotification];
      }
    }
  }
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification NS_AVAILABLE_IOS(4_0)
{

  NSLog(@"推送信息已经获得： %@",[notification alertBody]);
  UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:nil message:[notification alertBody] delegate:self cancelButtonTitle:nil otherButtonTitles:@"OK", nil] autorelease];
  [alert show];
  [self deletenotification];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  
//  [self initLocationNotification];
//  [self deletenotification];
  self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
  self.window.backgroundColor = [UIColor whiteColor];
  JYHFirstViewController *firstViewCtrl = [[JYHFirstViewController alloc] init];
  self.window.rootViewController = firstViewCtrl;
  [firstViewCtrl release];
  [self.window makeKeyAndVisible];
  return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  application.applicationIconBadgeNumber = 0;
  NSInteger count = [[[UIApplication sharedApplication]scheduledLocalNotifications] count];
  if (count > 0)
  {
    NSMutableArray *newarray = [NSMutableArray arrayWithCapacity:1];
    for (NSInteger i = 0; i < count; ++i)
    {
      UILocalNotification *notif = [[[UIApplication sharedApplication]scheduledLocalNotifications] objectAtIndex:i];
      notif.applicationIconBadgeNumber = i + 1;
      [newarray addObject:notif];
    }
    [[UIApplication sharedApplication]cancelAllLocalNotifications];
    if (newarray.count > 0)
    {
      for (NSInteger i = 0; i < newarray.count; ++i)
      {
        UILocalNotification *notif = [newarray objectAtIndex:i];
        [[UIApplication sharedApplication]scheduleLocalNotification:notif];
      }
    }
  }
    //删除通知
  [self deletenotification];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
