//
//  JYHToDoThingVO.h
//  ToDoList
//
//  Created by Kaka on 8/21/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JYHToDoThingVO : NSObject<NSCoding>
{
  BOOL isFinished;
  NSString *iTodoStr;
  NSString *iTimeStamp;
  BOOL iSwitch;
  NSDate *iRemindDate;
  NSString *iNote;
}

@property (nonatomic,assign) BOOL isFinished;
@property (nonatomic,retain) NSString *iTodoStr;
@property (nonatomic,retain) NSString *iTimeStamp;
@property (nonatomic,assign) BOOL iSwitch;
@property (nonatomic,retain) NSDate *iRemindDate;
@property (nonatomic,retain) NSString *iNote;


@end
