//
//  JYHToDoDetailController.m
//  ToDoList
//
//  Created by Kaka on 8/26/14.
//  Copyright (c) 2014 yonyou. All rights reserved.
//

#import "JYHToDoDetailController.h"
#import "JYHToDoDetailViewController.h"
#import "JYHSwitchTableViewCell.h"

@interface JYHToDoDetailController()
{
  UIDatePicker *iDatepicker;
  CGFloat cellHeight[4];
}
@property (nonatomic,retain)UIDatePicker *iDatepicker;
@end

@implementation JYHToDoDetailController
@synthesize iDetailVC;
@synthesize iDate;
@synthesize iDatepicker;


#pragma mark tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *cellidentifier = @"tododetailidentifier";
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellidentifier];
  if (cell == nil)
  {
    cell = [[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier]autorelease];
  }
  if (indexPath.section == 0)
  {
    cell = [[[ACEExpandableTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier]autorelease];
    cell = [tableView expandableTextCellWithId:@"cellId"];
    
    ((ACEExpandableTextCell *)cell).textView.text = iDetailVC.iDetailVO.iTodoStr;
    ((ACEExpandableTextCell *)cell).textView.placeholder = @"text";
  }
    //switch
  else if(indexPath.section == 1)
  {
    cell = [[[NSBundle mainBundle] loadNibNamed:@"JYHSwitchTableViewCell" owner:nil options:nil] lastObject];

    UISwitch *switchButton = ((JYHSwitchTableViewCell *)cell).iSwitch;
    UILabel *label = ((JYHSwitchTableViewCell *)cell).iNameLabel;
    label.text = @"设置提醒";
    if (iDetailVC.iDetailVO.iSwitch != nil && [iDetailVC.iDetailVO.iSwitch isEqualToString:@"1"])
    {
      [switchButton setOn:YES];
    }
    else
    {
      [switchButton setOn:NO];
    }
    [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    [cell addSubview:switchButton];
  }
    //datepicker
  else if(indexPath.section == 2)
  {
    NSString *dateStr = nil;
      //获得系统时间
    if (iDetailVC.iDetailVO.iRemindDate != nil  )
    {
      dateStr = iDetailVC.iDetailVO.iRemindDate;
    }
    else
    {
      dateStr = [self systemDate];
    }
    
    cell.textLabel.text = dateStr;
    if (iDetailVC.iDetailVO.iSwitch != nil && [iDetailVC.iDetailVO.iSwitch isEqualToString:@"1"])
    {
      cell.textLabel.textColor = [UIColor blackColor];
      cell.userInteractionEnabled = YES;
    }
    else
    {
      cell.textLabel.textColor = [UIColor grayColor];
      cell.userInteractionEnabled = NO;
    }
  }
    //label
  else
  {
    cell = [[[ACEExpandableTextCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellidentifier]autorelease];
    cell = [tableView expandableTextCellWithId:@"cellId"];

    ((ACEExpandableTextCell *)cell).textView.text = iDetailVC.iDetailVO.iNote;
    ((ACEExpandableTextCell *)cell).textView.placeholder = @"text";
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //弹出datepicker
  if (indexPath.section == 2)
  {
    iDatepicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 300, 320, 216)];
    iDatepicker.datePickerMode = UIDatePickerModeDate;
    iDatepicker.backgroundColor = [UIColor greenColor];
    [iDatepicker addTarget:self action:@selector(datePickerAction:) forControlEvents:UIControlEventValueChanged];
    [iDetailVC.view addSubview:iDatepicker];
  }
  else
  {
    iDatepicker.hidden = YES;
  }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.row == 0 && indexPath.row == 3)
  {
    return MAX(48.0f, cellHeight[indexPath.row]);
  }
  else
  {
    return 48.0f;
  }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  iDatepicker.hidden = YES;
}

#pragma mark expandcell delegate
- (void)tableView:(UITableView *)tableView updatedHeight:(CGFloat)height atIndexPath:(NSIndexPath *)indexPath
{
  cellHeight[indexPath.row] = height;
}

- (void)tableView:(UITableView *)tableView updatedText:(NSString *)text atIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section == 0)
  {
    iDetailVC.iDetailVO.iTodoStr = text;
  }
  else
  {
    iDetailVC.iDetailVO.iNote = text;
  }
  [iDetailVC.iTableview reloadData];
}

#pragma mark switch
- (void)switchAction:(id)sender
{
  iDatepicker.hidden = YES;
  UISwitch *tempSwitch = (UISwitch *)sender;
  if (tempSwitch.on)
  {
    iDetailVC.iDetailVO.iSwitch = @"1";
  }
  else
  {
    iDetailVC.iDetailVO.iSwitch = @"0";
  }
  [iDetailVC.iTableview reloadData];
}

- (void)datePickerAction:(id)sender
{
  UIDatePicker * control = (UIDatePicker*)sender;
  self.iDate = control.date;
  iDetailVC.iDetailVO.iRemindDate = [self systemDate];
  [iDetailVC.iTableview reloadData];
}

- (NSString *)systemDate
{
  if (self.iDate == nil)
  {
    self.iDate = [NSDate date];
  }
  NSCalendar  * cal=[NSCalendar  currentCalendar];
  NSUInteger  unitFlags=NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit;
  NSDateComponents * conponent= [cal components:unitFlags fromDate:self.iDate];
  NSInteger year=[conponent year];
  NSInteger month=[conponent month];
  NSInteger day=[conponent day];
  NSString *nsDateString= [NSString  stringWithFormat:@"%4d年%2d月%2d日",year,month,day];
  return nsDateString;
}

- (void)dealloc
{
  [iDatepicker release];
  [iDate release];
  [super dealloc];
}

@end
