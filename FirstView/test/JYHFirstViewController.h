//
//  JYHFirstViewController.h
//  ToDoList
//
//  Created by Kaka on 8/20/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JYHFirstController.h"
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>
static const NSString *CODE = @"code";

@interface JYHFirstViewController : UIViewController
{
  IBOutlet UINavigationBar *iNavBar;
  IBOutlet UITableView *iTableView;
  JYHFirstController *iFirstCtrl;
  EKEventStore *eventStore;
  EKCalendar *defaultCalendar;
//  NSMutableArray *iArray;
//  NSMutableArray *iMutArray;
//  NSMutableString *firstelement;
}
@property (retain, nonatomic) IBOutlet UINavigationBar *iNavBar;
@property (retain, nonatomic) IBOutlet UITableView *iTableView;
@property (retain, nonatomic) JYHFirstController *iFirstCtrl;
@property (nonatomic, retain) EKEventStore *eventStore;
@property (nonatomic, retain) EKCalendar *defaultCalendar;



//@property (nonatomic, retain) NSMutableArray *iArray;
//@property (nonatomic, retain) NSMutableArray *iMutArray;
//@property (nonatomic,assign) NSMutableString *firstelement;

@end
