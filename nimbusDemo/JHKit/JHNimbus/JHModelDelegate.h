//
//  JHModelDelegate.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/16.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol JHModel;

@protocol JHModelDelegate <NSObject>

@optional
// Model开始加载
- (void)modelDidStartLoad:(id<JHModel>)model;

// Model加载成功
- (void)modelDidFinishLoad:(id<JHModel>)model withObject: (id) object;

// Model加载失败
- (void)model:(id<JHModel>)model didFailLoadWithError:(NSError*)error;

// Model加载取消
- (void)modelDidCancelLoad:(id<JHModel>)model;

/**
 * Informs the delegate that the model has changed in some fundamental way.
 *
 * The change is not described specifically, so the delegate must assume that the entire
 * contents of the model may have changed, and react almost as if it was given a new model.
 */
- (void)modelDidChange:(id<JHModel>)model;

- (void)model:(id<JHModel>)model didUpdateObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

- (void)model:(id<JHModel>)model didInsertObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

- (void)model:(id<JHModel>)model didDeleteObject:(id)object atIndexPath:(NSIndexPath*)indexPath;

/**
 * Informs the delegate that the model is about to begin a multi-stage update.
 *
 * Models should use this method to condense multiple updates into a single visible update.
 * This avoids having the view update multiple times for each change.  Instead, the user will
 * only see the end result of all of your changes when you call modelDidEndUpdates.
 */
- (void)modelDidBeginUpdates:(id<JHModel>)model;

/**
 * Informs the delegate that the model has completed a multi-stage update.
 *
 * The exact nature of the change is not specified, so the receiver should investigate the
 * new state of the model by examining its properties.
 */
- (void)modelDidEndUpdates:(id<JHModel>)model;

@end
