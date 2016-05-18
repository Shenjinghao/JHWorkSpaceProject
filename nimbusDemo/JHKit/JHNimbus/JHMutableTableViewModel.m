//
//  JHMutableTableViewModel.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/23.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHMutableTableViewModel.h"

@implementation JHMutableTableViewModel


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
    if (reloading) {
        return @"正在更新...";
        
    } else {
        return @"正在加载...";
    }
}



#pragma mark - JHModel

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSMutableArray*)delegates {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isLoaded {
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
- (void)load:(JHURLRequestCachePolicy)cachePolicy more:(BOOL)more {
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)cancel {
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)invalidate:(BOOL)erase {
}

- (void) reset {
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<JHModel>)model {
    return _model ? _model : self;
}

#pragma mark public

- (void)tableViewDidLoadModel:(UITableView*)tableView {
    
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*)imageForEmpty {
    return [self imageForError:nil];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForEmpty {
    return nil;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage*)imageForError:(NSError*)error {
    return [[UIImage load:@"ugly_face.png"] imageWithTintColor: RGBCOLOR_HEX(0xdddddd)];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForError:(NSError*)error {
    if ([JHDescriptionForError(error) isNotEmpty]) {
        return [NSString stringWithFormat:@"%@，%@", JHDescriptionForError(error), @"点此尝试重新载入"];
    }
    
    return @"点此尝试重新载入";
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
    return nil; //JHLocalizedString(@"Sorry, there was an error.", @"");
}

@end
