  //
  //  JYHFirstViewController.m
  //  ToDoList
  //
  //  Created by Kaka on 8/20/14.
  //  Copyright (c) 2014 yonyou. All rights reserved.
  //

#import "JYHFirstViewController.h"


@interface JYHFirstViewController ()

@end

@implementation JYHFirstViewController
@synthesize iNavBar;
@synthesize iTableView;
@synthesize iFirstCtrl;
@synthesize eventStore;
@synthesize defaultCalendar;

  //@synthesize iArray;
  //@synthesize iMutArray;
  //@synthesize firstelement;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
      // Custom initialization
    iFirstCtrl = [[JYHFirstController alloc] init];
    iFirstCtrl.iFirstVC = self;
      //      iMutArray = [[NSMutableArray alloc] initWithCapacity:1];
      //      iMutArray = [NSMutableArray arrayWithObjects:@"abc",@"str", nil];
      //      firstelement = iMutArray[0];
      //      self.iArray = iMutArray;
  }
  return self;
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
//  [self checkEventStoreAccessForCalendar];
}

- (void)viewDidLoad
{
  [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    //  CWAPullingRefreshTableView *pulltableview = [[CWAPullingRefreshTableView alloc] initWithFrame:CGRectMake(0, 0, 320, 504)style:UITableViewStylePlain];
    //  iTableView = pulltableview;
    //  [pulltableview release];
  iTableView.delegate = iFirstCtrl;
  iTableView.dataSource = iFirstCtrl;
  [iFirstCtrl setData];
    //  NSString *str = @"str";
    //  [iMutArray addObject:str];
    //  iMutArray[0] = @"feafe";
    //  [iArray addObject:str];
    //  firstelement = [NSString stringWithFormat:@"%@%@",firstelement,@"afe"];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
  [iNavBar release];
  [iTableView release];
  [iFirstCtrl release];
  [eventStore release];
  [defaultCalendar release];
  [super dealloc];
}

  //检查是否获取日历权限
- (void)checkEventStoreAccessForCalendar
{
//  EKAuthorizationStatus status = [EKEventStore authorizationStatusForEntityType:EKEntityTypeEvent];
//  switch (status)
//  {
//    case EKAuthorizationStatusAuthorized:
//      
//      break;
//    case EKAuthorizationStatusNotDetermined:
//      break;
//    case EKAuthorizationStatusDenied:
//    case EKAuthorizationStatusRestricted:
//    {
//      UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Privacy Warning"
//                                                     message:@"Permission was not granted for Calendar"
//                                                    delegate:nil
//                                           cancelButtonTitle:@"ok"
//                                           otherButtonTitles:nil];
//      [alert show];
//    }
//      break;
//    default:
//      break;
//  }
}

  // This method is called when the user has granted permission to Calendar
-(void)accessGrantedForCalendar
{
    // Let's get the default calendar associated with our event store
  self.defaultCalendar = self.eventStore.defaultCalendarForNewEvents;


}

  // Prompt the user for access to their Calendar
-(void)requestCalendarAccess
{
  [self.eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error)
   {
     if (granted)
     {
       JYHFirstViewController *weakSelf = self;
         // Let's ensure that our code will be executed from the main queue
       dispatch_async(dispatch_get_main_queue(), ^{
           // The user has granted access to their Calendar; let's populate our UI with all events occuring in the next 24 hours.
         [weakSelf accessGrantedForCalendar];
       });
     }
   }];
}
@end
