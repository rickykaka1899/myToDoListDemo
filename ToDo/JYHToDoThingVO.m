//
//  JYHToDoThingVO.m
//  ToDoList
//
//  Created by Kaka on 8/21/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import "JYHToDoThingVO.h"

static NSString *TODOSTR = @"TODOSTR";
static NSString *ISFINISHED = @"ISFINISHED";
static NSString *ITIMESTAMP = @"TIMESTAMP";
static NSString *SWITCH = @"SWITCH";
static NSString *NOTE = @"NOTE";
static NSString *REMINDDATE = @"REMINDDATE";

@implementation JYHToDoThingVO

@synthesize isFinished;
@synthesize iTodoStr;
@synthesize iTimeStamp;
@synthesize iSwitch;
@synthesize iNote;
@synthesize iRemindDate;

- (void)dealloc
{
  [iTodoStr release];
  [iTimeStamp release];
  [iNote release];
  [iRemindDate release];
  [super dealloc];
}

  //序列化方法
- (id)initWithCoder:(NSCoder *)aDecoder
{
  if (self = [super init])
  {
    self.iTodoStr = [aDecoder decodeObjectForKey:TODOSTR];
    self.isFinished = [aDecoder decodeBoolForKey:ISFINISHED];
    self.iTimeStamp = [aDecoder decodeObjectForKey:ITIMESTAMP];
    self.iSwitch = [aDecoder decodeBoolForKey:SWITCH];
    self.iNote = [aDecoder decodeObjectForKey:NOTE];
    self.iRemindDate = [aDecoder decodeObjectForKey:REMINDDATE];
  }
  return self;
}
  //反序列化方法
- (void)encodeWithCoder:(NSCoder *)aCoder
{
  [aCoder encodeBool:isFinished forKey:ISFINISHED];
  [aCoder encodeObject:iTodoStr forKey:TODOSTR];
  [aCoder encodeObject:iTimeStamp forKey:ITIMESTAMP];
  [aCoder encodeObject:iRemindDate forKey:REMINDDATE];
  [aCoder encodeBool:iSwitch forKey:SWITCH];
  [aCoder encodeObject:iNote forKey:NOTE];
}


@end
