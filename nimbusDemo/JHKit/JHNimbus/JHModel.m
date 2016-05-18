//
//  JHModel.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/16.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHModel.h"

@implementation JHModel

- (NSMutableArray *) delegates
{
    if (_delegates == nil) {
        /**
         *  使用 NonRetainingMutableArray 要求 delegates在自己要dealloc时主动取消注册
         */
        _delegates = NICreateNonRetainingMutableArray();
    }
    return _delegates;
}

- (BOOL) isLoaded
{
    return YES;
}
///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoading {
    return NO;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoadingMore {
    return NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isOutDated {
    return NO;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)cancel {
}


- (void) reset {
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)invalidate:(BOOL)erase {
}

- (void)load:(JHURLRequestCachePolicy)cachePolicy more:(BOOL)more {
}


#pragma mark public

- (void)didStartLoad
{
    [_delegates perform:@selector(modelDidStartLoad:) withObject:self];
}

- (void)didFinishLoadWithObject:(id)object
{
    [_delegates perform:@selector(modelDidFinishLoad:withObject:) withObject:self withObject:object];
}

- (void)didFailLoadWithError:(NSError *)error
{
    [_delegates perform:@selector(model:didFailLoadWithError:) withObject:self withObject:error];
}

- (void)didCancelLoad
{
    [_delegates perform:@selector(modelDidCancelLoad:) withObject:self];
}

- (void)beginUpdates
{
    [_delegates perform:@selector(modelDidBeginUpdates:) withObject:self];
}

- (void)endUpdates
{
    [_delegates perform:@selector(modelDidEndUpdates:) withObject:self];
}

- (void)didChange
{
    [_delegates perform:@selector(modelDidChange:) withObject:self];
}

- (void)didUpdateObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    [_delegates perform:@selector(model:didUpdateObject:atIndexPath:) withObject:self withObject:object withObject:indexPath];
}

- (void)didInsertObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    [_delegates perform:@selector(model:didInsertObject:atIndexPath:) withObject:self withObject:object withObject:indexPath];
}

- (void)didDeleteObject:(id)object atIndexPath:(NSIndexPath *)indexPath
{
    [_delegates perform:@selector(model:didDeleteObject:atIndexPath:) withObject:self withObject:object withObject:indexPath];
}






@end











