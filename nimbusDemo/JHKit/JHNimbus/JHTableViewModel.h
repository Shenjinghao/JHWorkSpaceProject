//
//  JHTableViewModel.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/23.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "NITableViewModel.h"

@interface JHTableViewModel : NITableViewModel<JHModel>

// Optional method to return a model object to delegate the TTModel protocol to.
@property (nonatomic, strong) id<JHModel> model;

@property (nonatomic, strong) UIImage* imageEmpty;
@property (nonatomic, strong) UIImage* imageError;
@property (nonatomic, strong) NSString* titleEmpty;
@property (nonatomic, strong) NSString* titleError;
@property (nonatomic, strong) NSString* subtitleEmpty;
@property (nonatomic, strong) NSString* subtitleError;

// Informs the data source that its model loaded.
// That would be a good time to prepare the freshly loaded data for use in the table view.
- (void)tableViewDidLoadModel:(UITableView*)tableView;

- (NSString*)titleForLoading:(BOOL)reloading;

// 没有数据时的UI的处理
- (UIImage*)imageForEmpty;

- (NSString*)titleForEmpty;

- (NSString*)subtitleForEmpty;
/**
 *  出现错误的处理
 *
 *  @param error
 *
 *  @return
 */
- (UIImage*)imageForError:(NSError*)error;

- (NSString*)titleForError:(NSError*)error;

- (NSString*)subtitleForError:(NSError*)error;

//- (id)initWithSectionedArray:(NSArray *)sectionedArray delegate:(id<NITableViewModelDelegate>)delegate;



@end
