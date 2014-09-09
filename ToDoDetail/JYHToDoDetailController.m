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
  UISwitch *iSwitchButton;
}
@property (nonatomic,retain)UIDatePicker *iDatepicker;
@property (nonatomic,retain)UISwitch *iSwitchButton;

@end

@implementation JYHToDoDetailController
@synthesize iDetailVC;
@synthesize iDate;
@synthesize iDatepicker;
@synthesize iSwitchButton;

#pragma mark tableview delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (section == 1)
  {
      //带过来的数据或者当前页面对switchbtn进行改变。switchbtn切换时不对值进行改变，点击done之后才修改
    if (iDetailVC.iDetailVO.iSwitch | iSwitchButton.on)
    {
      return 2;
    }
    else
    {
      return 1;
    }
  }
  else
  {
    return 1;
  }
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
    cell = [tableView expandableTextCellWithId:@"cellId"];
    
    ((ACEExpandableTextCell *)cell).textView.text = iDetailVC.iDetailVO.iTodoStr;
    ((ACEExpandableTextCell *)cell).textView.placeholder = @"NEW";
  }
    //switch
  else if(indexPath.section == 1)
  {
    if (indexPath.row == 0)
    {
      cell = [[[NSBundle mainBundle] loadNibNamed:@"JYHSwitchTableViewCell" owner:nil options:nil] lastObject];
      
      iSwitchButton = ((JYHSwitchTableViewCell *)cell).iSwitch;
      UILabel *label = ((JYHSwitchTableViewCell *)cell).iNameLabel;
      label.text = @"设置提醒";
      if (iDetailVC.iDetailVO.iSwitch)
      {
        [iSwitchButton setOn:YES];
      }
      else
      {
        [iSwitchButton setOn:NO];
      }
      [iSwitchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    else
    {
        //datepicker
      {
        NSString *dateStr = nil;
        dateStr = [self systemDate:iDetailVC.iDetailVO.iRemindDate];
        cell.textLabel.text = dateStr;
        if (iDetailVC.iDetailVO.iSwitch)
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
    }
  }

  else
  {
    cell = [tableView expandableTextCellWithId:@"cellId"];
    ((ACEExpandableTextCell *)cell).textView.text = iDetailVC.iDetailVO.iNote;
    ((ACEExpandableTextCell *)cell).textView.placeholder = @"text";
  }
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //弹出datepicker
  if (indexPath.section == 1 && indexPath.row == 1)
  {
    iDatepicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, 300, 320, 216)];
    iDatepicker.datePickerMode = UIDatePickerModeDateAndTime;
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
  return 3;
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
    iDetailVC.iDetailVO.iSwitch = TRUE;
  }
  else
  {
    iDetailVC.iDetailVO.iSwitch = FALSE;
  }
  [iDetailVC.iTableview reloadData];
}

- (void)datePickerAction:(id)sender
{
  UIDatePicker * control = (UIDatePicker*)sender;
  self.iDate = control.date;
  iDetailVC.iDetailVO.iRemindDate = self.iDate;
  [iDetailVC.iTableview reloadData];
}

- (NSString *)systemDate:(NSDate *)date
{
  if (date == nil)
  {
    date = [NSDate date];
  }
  NSDateFormatter *aFmter = [[NSDateFormatter alloc]init];
  [aFmter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
  NSString *aStr = [aFmter stringFromDate:date];
  [aFmter release];
  return aStr;

}

- (void)dealloc
{
  [iDatepicker release];
  [iDate release];
  [super dealloc];
}

@end
