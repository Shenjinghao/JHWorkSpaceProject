//
//  JHModelViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/16.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHModelViewController.h"
#import "JHModel.h"
#import "JHURLRequestModel.h"


@implementation JHModelViewController
{
    @protected
    BOOL _hasViewAppeared;
    BOOL _isViewAppearing;
    
}

@synthesize model = _model;

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _flags.isViewInvalid = YES;
        _showDefaultLoadingStatus = YES;
    }
    return self;
}
/**
 *  默认的构造函数最终resort to initWithNibName:bundle
 *
 *  @return 
 */
- (instancetype)init
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
    [_model.delegates removeObject:self];
}

#pragma mark -　Private
///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)resetViewStates {
    // 取消Loading, showingModel, error, empty等状态
    if (_flags.isShowingLoading) {
        [self showLoading:NO];
        _flags.isShowingLoading = NO;
    }
    if (_flags.isShowingModel) {
        [self showModel:NO];
        _flags.isShowingModel = NO;
    }
    if (_flags.isShowingError) {
        [self showError:NO];
        _flags.isShowingError = NO;
    }
    if (_flags.isShowingEmpty) {
        [self showEmpty:NO];
        _flags.isShowingEmpty = NO;
    }
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateViewStates {
    // Refresh/WillLoad, DidLoad
    if (_flags.isModelDidRefreshInvalid) {
        [self didRefreshModel];
        _flags.isModelDidRefreshInvalid = NO;
    }
    if (_flags.isModelWillLoadInvalid) {
        [self willLoadModel];
        _flags.isModelWillLoadInvalid = NO;
    }
    if (_flags.isModelDidLoadInvalid) {
        [self didLoadModel:_flags.isModelDidLoadFirstTimeInvalid];
        _flags.isModelDidLoadInvalid = NO;
        _flags.isModelDidLoadFirstTimeInvalid = NO;
        _flags.isShowingModel = NO;
    }
    
    BOOL showModel = NO, showLoading = NO, showError = NO, showEmpty = NO;
    
    if (_model.isLoaded || ![self shouldLoad]) {
        if ([self canShowModel]) {
            showModel = !_flags.isShowingModel;
            _flags.isShowingModel = YES;
            
        } else {
            if (_flags.isShowingModel) {
                [self showModel:NO];
                _flags.isShowingModel = NO;
            }
        }
        
    } else {
        if (_flags.isShowingModel) {
            [self showModel:NO];
            _flags.isShowingModel = NO;
        }
    }
    
    if (_model.isLoading) {
        showLoading = !_flags.isShowingLoading;
        _flags.isShowingLoading = YES;
        
    } else {
        if (_flags.isShowingLoading && self.showDefaultLoadingStatus) {
            [self showLoading:NO];
            _flags.isShowingLoading = NO;
        }
    }
    
    if (_modelError) {
        showError = !_flags.isShowingError;
        _flags.isShowingError = YES;
        
    } else {
        if (_flags.isShowingError && self.showDefaultLoadingStatus) {
            [self showError:NO];
            _flags.isShowingError = NO;
        }
    }
    
    if (!_flags.isShowingLoading && !_flags.isShowingModel && !_flags.isShowingError) {
        showEmpty = !_flags.isShowingEmpty;
        _flags.isShowingEmpty = YES;
        
    } else {
        if (_flags.isShowingEmpty && self.showDefaultLoadingStatus) {
            [self showEmpty:NO];
            _flags.isShowingEmpty = NO;
        }
    }
    
    if (showModel) {
        [self showModel:YES];
        [self didShowModel:_flags.isModelDidShowFirstTimeInvalid];
        _flags.isModelDidShowFirstTimeInvalid = NO;
    }
    
    if (self.showDefaultLoadingStatus) {
        if (showEmpty) {
            [self showEmpty:YES];
        }
        if (showError) {
            [self showError:YES];
        }
        if (showLoading) {
            [self showLoading:YES];
        }
    }
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createInterstitialModel {
    self.model = [[JHModel alloc] init];
}

#pragma mark UIViewController (TTCategory)



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)delayDidEnd {
    [self invalidateModel];
}

#pragma mark - Public

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setModelError:(NSError*)error {
    if (error != _modelError) {
        _modelError = error;
        
        [self invalidateView];
    }
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createModel {
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)invalidateModel {
    BOOL wasModelCreated = self.isModelCreated;
    [self resetViewStates];
    [_model.delegates removeObject:self];
    _model = nil;
    
    if (wasModelCreated) {
        [self model];
    }
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)isModelCreated {
    return !!_model;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldLoad {
    return !self.model.isLoaded;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldReload {
    return !_modelError && self.model.isOutDated;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)shouldLoadMore {
    return NO;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)canShowModel {
    return YES;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)reload {
    _flags.isViewInvalid = YES;
    [self.model load:JHURLRequestCachePolicyNetwork more:NO];
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)reloadIfNeeded {
    if ([self shouldReload] && !self.model.isLoading) {
        [self reload];
    }
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)refresh {
    _flags.isViewInvalid = YES;
    _flags.isModelDidRefreshInvalid = YES;
    
    BOOL loading = self.model.isLoading;
    BOOL loaded = self.model.isLoaded;
    
    // 刷新?
    // 如果没有加载过，则more = NO
    // 如果加载过，则按照PolicyNetwork来处理Cache
    //
    if (!loading && !loaded && [self shouldLoad]) {
        [self.model load: JHURLRequestCachePolicyDefault more:NO];
        
    } else if (!loading && loaded && [self shouldReload]) {
        [self.model load: JHURLRequestCachePolicyNetwork more:NO];
        
    } else if (!loading && [self shouldLoadMore]) {
        [self.model load: JHURLRequestCachePolicyDefault more:YES];
        
    } else {
        _flags.isModelDidLoadInvalid = YES;
        if (_isViewAppearing) {
            [self updateView];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)beginUpdates {
    _flags.isViewSuspended = YES;
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)endUpdates {
    _flags.isViewSuspended = NO;
    [self updateView];
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)invalidateView {
    _flags.isViewInvalid = YES;
    if (_isViewAppearing) {
        [self updateView];
    }
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateView {
    // 每次View出现时都会刷新View的状态
    if (_flags.isViewInvalid && !_flags.isViewSuspended && !_flags.isUpdatingView) {
        _flags.isUpdatingView = YES;
        
        // Ensure the model is created
        // 如果self.model没有创建一个有效的模型也就“认了"
        [self model];
        
        // Ensure the view is created
        [self view];
        
        [self updateViewStates];
        
        
        _flags.isViewInvalid = NO;
        _flags.isUpdatingView = NO;
        
        [self reloadIfNeeded];
    }
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didRefreshModel {
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)willLoadModel {
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didLoadModel:(BOOL)firstTime {
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didShowModel:(BOOL)firstTime {
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showModel:(BOOL)show {
}

/**
 *  model setter
 *
 *  @param model 
 */
- (void) setModel:(id<JHModel>)model
{
    if (model != _model) {
        [_model.delegates removeObject:self];
        _model = model;
        [_model.delegates addObject:self];
        if (_model) {
            _flags.isModelWillLoadInvalid = NO;
            _flags.isModelDidLoadInvalid = NO;
            _flags.isModelDidLoadFirstTimeInvalid = NO;
            _flags.isModelDidShowFirstTimeInvalid = YES;
        }
    }
}
/**
 *  model  getter
 *
 *  @return
 */
- (id<JHModel>) model
{
    if (!_model) {
        [self createModel];
        if (!_model) {
            self.model = [[JHModel alloc] init];
        }
    }
    return _model;
}


#pragma mark JHModelDelegate
- (void)modelDidStartLoad:(id<JHModel>)model
{
    if (model == self.model) {
        _flags.isModelWillLoadInvalid = YES;
        _flags.isModelDidLoadFirstTimeInvalid = YES;
        [self invalidateView];
    }
    if (_showDefaultLoadingStatus) {
        [self showLoading:YES];
    }
}

- (void)modelDidFinishLoad:(id<JHModel>)model withObject:(id)object {
    if (model == _model) {
        _modelError = nil;
        _flags.isModelDidLoadInvalid = YES;
        [self invalidateView];
    }
    
    if (_showDefaultLoadingStatus) {
        // 正常结束
        [self showLoading: NO];
        [self showError: NO];
    }
}

- (void)model:(id<JHModel>)model didFailLoadWithError:(NSError*)error {
    // modelError来自何方?!!
    if (model == _model) {
        self.modelError = error;
    }
    
    if (_showDefaultLoadingStatus) {
        [self showLoading: NO];
        [self showError: YES];
    }
    
}


/**
 *  取消加载model
 *
 *  @param model <#model description#>
 */
- (void)modelDidCancelLoad:(id<JHModel>)model
{
    if (model == _model) {
        [self invalidateView];
    }
}
/**
 *  model改变
 *
 *  @param model <#model description#>
 */
- (void)modelDidChange:(id<JHModel>)model
{
    if (model == _model) {
        [self refresh];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)model:(id<JHModel>)model didUpdateObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)model:(id<JHModel>)model didInsertObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)model:(id<JHModel>)model didDeleteObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)modelDidBeginUpdates:(id<JHModel>)model {
    if (model == _model) {
        [self beginUpdates];
    }
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)modelDidEndUpdates:(id<JHModel>)model {
    if (model == _model) {
        [self endUpdates];
    }
}


#pragma mark -show

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showEmpty:(BOOL)show {
    [self showEmpty:show withText:nil];
}



///////////////////////////////////////////////////////////////////////////////////////////////////

- (void) showLoading: (BOOL) show {
    [self showLoading:show withText:@"正在载入"];
}

- (void)showError:(BOOL)show {
    // 没有设置_dataSource,　表明当前的请求可能是依赖于网络的
    if (show) {
        if (!self.model.isLoaded || ![self canShowModel]) {
            NSString* title = nil;
            if ([_modelError.userInfo[@"error_msg"] isNotEmpty]) {
                title = _modelError.userInfo[@"error_msg"];
            } else {
                title = @"载入失败";
            }
            
            [self showError:show withText:title];
        }
    } else {
        [self showError:show withText:nil];
    }
}

- (void)showLoading:(BOOL)show withText:(NSString *)text {
    [super showLoading:show withText:text];
    _flags.isShowingLoading = show;
}

- (void)showError:(BOOL)show withText:(NSString *)text {
    [super showError:show withText:text];
    _flags.isShowingError = show;
    
    if (!show) {
        _modelError = nil;
    }
}

- (void)showEmpty:(BOOL)show withText:(NSString *)text {
    [super showEmpty:show withText:text];
    _flags.isShowingEmpty = show;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) reloadTableFromErrorButton {
    NIDPRINTMETHODNAME();
    
    // 加载出错后重新加载?
    // 1. 清楚出错状态
    [self showError: NO];
    
    self.modelError = nil;
    
    [_model load: JHURLRequestCachePolicyDefault more: NO];
}


- (void) parseHttpResponse: (id) httpObject withModel: (JHURLRequestModel*) model {
    // DO NOTHING
}

//
// showError的frame
//
- (CGRect)rectForOverlayView {
    CGRect rect = self.view.frame;
    if (JHIsKeyboardVisible()) {
        rect.size.height -= JHKeyboardHeightForOrientation(UIInterfaceOrientationPortrait);
    }
    return rect;
}

BOOL JHIsKeyboardVisible()
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    
    UIView* firstResponder = [window findFirstResponder];
    
    if (![firstResponder isKindOfClass: NSClassFromString(@"UIWebBrowserView")]) {
        return !!firstResponder;
    } else {
        return NO;
    }

}

@end
