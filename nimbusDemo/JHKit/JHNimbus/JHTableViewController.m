//
//  JHTableViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/23.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#define  ttkDefaultTransitionDuration 0.3
#define  ttkDefaultFastTransitionDuration 0.2
#define  ttkDefaultFlipTransitionDuration 0.7
#define TT_TRANSITION_DURATION      ttkDefaultTransitionDuration
#define TT_FAST_TRANSITION_DURATION ttkDefaultFastTransitionDuration
#define TT_FLIP_TRANSITION_DURATION ttkDefaultFlipTransitionDuration

#import "JHTableViewController.h"
#import "JHUtility.h"


@implementation JHTableViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        /**
         *  屏幕方向
         */
        _lastInterfaceOrientation = self.interfaceOrientation;
        /**
         *  tableView样式: 普通样式为列表
         */
        _tableViewStyle = UITableViewStylePlain;
        /**
         *  默认: 在TableViewController显示的时候，没有TableViewCell会被选中
         */
        _clearsSelectionOnViewWillAppear = YES;
    }
    return self;
}

- (id)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        
    }
    return self;
}
/**
 *  定义tableview样式
 *
 *  @param style
 *
 *  @return
 */
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [self initWithNibName:nil bundle:nil];
    if (self) {
        _tableViewStyle = style;
        
    }
    return self;
}

- (void)dealloc
{
    _tableView.delegate = nil;
    _tableView.dataSource = nil;
    [_tableOverlayView removeFromSuperview];
    _tableOverlayView = nil;
    
    [_tableLoadingView removeFromSuperview];
    _tableLoadingView = nil;
    
    [_errorView removeFromSuperview];
    _errorView = nil;
    
    [_emptyView removeFromSuperview];
    _emptyView = nil;
    
    [_menuView removeFromSuperview];
    _menuView = nil;
    
    [_menuCell removeFromSuperview];
    _menuCell = nil;
}
#pragma mark UITableViewDelegate
///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
    return self.tableViewActions;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - UIViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)loadView {
    [super loadView];
    
    [self tableView];
}



///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (_lastInterfaceOrientation != self.interfaceOrientation) {
        // 如果方向改变，则重新加载数据
        _lastInterfaceOrientation = self.interfaceOrientation;
        [_tableView reloadData];
        
    }
    
    // 如何取消Table Row的selection状态呢?
    if (_clearsSelectionOnViewWillAppear) {
        [_tableView deselectRowAtIndexPath:[_tableView indexPathForSelectedRow] animated:animated];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    // 闪动一下Flash Indicators
    if (_flags.isShowingModel) {
        [_tableView flashScrollIndicators];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

#pragma mark - UITableViewDelegate
///////////////////////////////////////////////////////////////////////////////////////////////////
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    // Table Cell的高度交给_cellFactory来处理
    
    NIDASSERT(_cellFactory);
    NIDASSERT(_tableViewModel);
    
    return [_cellFactory tableView: tableView heightForRowAtIndexPath: indexPath model: self.tableViewModel];
}


/**
 *  创建默认的CellFactory
 */
- (NICellFactory *)cellFactory
{
    if (_cellFactory) {
        _cellFactory = [[NICellFactory alloc] init];
    }
    return _cellFactory;
}

- (NIActionBlock)loadMoreActionBlock
{
    return (NIActionBlock)NO;
}
/**
 *  不能在init函数中调用，必须等viewDidLoad调用时或调用之后才能调用
 *
 *  @return
 */
- (NITableViewActions *)tableViewActions
{
    if (_tableViewActions) {
        _tableViewActions = [[NITableViewActions alloc] initWithTarget:self];
        /**
         *  通过forwadingTo 建立了 NICellFactory和UITableViewDelegate之间的联系
         */
        [_tableViewActions forwardingTo:self];
        
    }
    /**
     *  如果需要支持 下拉刷新
     */
    WEAK_VAR(self);
    if (self.canDragRefreshTableView) {
        if (_tableView.header == nil) {
            MJRefreshNormalHeader *headerView = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
                [_model reset];
                [_model load:JHURLRequestCachePolicyNetwork more:NO];
                [_self tableviewDidDragRefresh];
            }];
            [headerView setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
            [headerView setTitle:@"释放立即刷新" forState:MJRefreshStatePulling];
            [headerView setTitle:@"正在刷新" forState:MJRefreshStateRefreshing];
            [headerView setTitle:@"正在刷新" forState:MJRefreshStateWillRefresh];
            [headerView setTitle:@"无历史数据" forState:MJRefreshStateNoMoreData];
            headerView.stateLabel.textColor = COLOR_A4;
            headerView.stateLabel.font = [UIFont systemFontOfSize:12];
            headerView.lastUpdatedTimeLabel.textColor = COLOR_A4;
            headerView.lastUpdatedTimeLabel.font = [UIFont systemFontOfSize:12];
        }
    }else if (self.canDragLoadMoreInTop){
        
    }
    /**
     *  如需要上拉加载更多
     */
    if (self.canDragLoadMore) {
        [self installTableViewHasMoreFooterView];
    }
    return _tableViewActions;
}

- (void)installTableViewHasMoreFooterView
{
    if (self.tableView.footer == nil) {
        MJRefreshAutoNormalFooter *footerView = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
            [_model load:JHURLRequestCachePolicyNetwork more:YES];
        }];
        self.tableView.footer = footerView;
        [footerView setTitle:@"上拉加载更多数据" forState:MJRefreshStateIdle];
        [footerView setTitle:@"释放获取更多内容" forState:MJRefreshStatePulling];
        [footerView setTitle:@"加载中" forState:MJRefreshStateRefreshing];
        [footerView setTitle:@"加载中" forState:MJRefreshStateWillRefresh];
        [footerView setTitle:@"暂无新内容" forState:MJRefreshStateNoMoreData];
        footerView.stateLabel.textColor = COLOR_A4;
        footerView.stateLabel.font = [UIFont systemFontOfSize:12];
    }
}
/**
 *  移除footerView
 */
- (void)removeTableViewHasMoreFooterView
{
    self.tableView.footer = nil;
}

- (UIView*) footerViewForNoMore {
    return nil;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark - Public

- (void)backToLastController:(id)sender
{
    [self clearMJRefresh];
    [super backToLastController:sender];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (UITableView*)tableView {
    if (nil == _tableView) {
        // 在真正需要tableView时才展示tableView, 并且设置样式
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:_tableViewStyle];
        _tableView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _tableView.backgroundColor = [UIColor viewBackgroundColor];
        _tableView.separatorColor = COLOR_A7;
        [self.view addSubview:_tableView];
        
        
        // 问题: 如果TableView中没有数据，或者数据比较少，则会出现很多EmptyCell, 并且可能带有边框
        // http://stackoverflow.com/questions/1633966/can-i-force-a-uitableview-to-hide-the-separator-between-empty-cells
        //
        _tableView.tableFooterView = [[UIView alloc] initWithFrame: CGRectZero];
    }
    return _tableView;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTableView:(UITableView*)tableView {
    if (tableView != _tableView) {
        _tableView = tableView;
        if (!_tableView) {
            self.tableOverlayView = nil;
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTableOverlayView:(UIView*)tableOverlayView animated:(BOOL)animated {
    if (tableOverlayView != _tableOverlayView) {
        if (_tableOverlayView) {
            if (animated) {
                [self fadeOutView:_tableOverlayView];
                
            } else {
                [_tableOverlayView removeFromSuperview];
            }
        }
        
        
        _tableOverlayView = tableOverlayView;
        
        if (_tableOverlayView) {
            _tableOverlayView.frame = [self rectForOverlayView];
            [self addToOverlayView:_tableOverlayView];
        }
        
        // XXXjoe There seem to be cases where this gets left disable - must investigate
        _tableView.scrollEnabled = !_tableOverlayView;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
// 在设置TableViewModel前， 必须先设置好 self.tableViewActions
- (void)setTableViewModel:(JHTableViewModel *)tableViewModel{
    if (tableViewModel != _tableViewModel) {
        
        _tableViewModel = tableViewModel;
        _tableView.dataSource = nil;
        // 设置dataSource以及model
        self.model = _tableViewModel.model;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)setTableLoadingView:(UIView *)view{
    if (view != _tableLoadingView) {
        if (_tableLoadingView) {
            [_tableLoadingView removeFromSuperview];
            _tableLoadingView = nil;
        }
        _tableLoadingView = view;
        if (_tableLoadingView) {
            [self addToOverlayView:_tableLoadingView];
            
        } else {
            [self resetOverlayView];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)invalidateModel {
    [super invalidateModel];
    
    // Renew the tableView delegate when the model is refreshed.
    // Otherwise the delegate will be retained the model.
    
    // You need to set it to nil before changing it or it won't have any effect
    _tableView.delegate = nil;
    [self updateTableDelegate];
}


- (void)tableviewDidDragRefresh
{
    
}

- (void)updateLoadMoreView:(BOOL)hasMore
{
    WEAK_VAR(self);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (_self.canDragLoadMore) {
            
            if (hasMore) {
                
                [_self installTableViewHasMoreFooterView];
            }else {
                [_self removeTableViewHasMoreFooterView];
            }
        }
    });
}

- (void) reloadTableFromError {
    NIDPRINTMETHODNAME();
    
    // 加载出错后重新加载?
    // 1. 清楚出错状态
    [_errorView removeFromSuperview];
    self.modelError = nil;
    [self showLoading:YES];
    [_model load: JHURLRequestCachePolicyDefault more: NO];
}

- (CGRect)rectForOverlayView {
    CGRect rect = self.tableView.frame;
    if ([JHUtility JHIsKeyboardVisible]) {
        rect.size.height -= JHKeyboardHeightForOrientation(UIInterfaceOrientationPortrait);
    }
    rect.size.height -= self.initialViewTopInset;
    rect.origin.y += self.initialViewTopInset;
    return rect;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didBeginDragging {
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didEndDragging {
}


#pragma mark - Private


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createInterstitialModel {
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)defaultTitleForLoading {
    return JHLocalizedString(@"Loading...", @"");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)updateTableDelegate {
    if (!_tableView.delegate) {
        // 创建 _tableViewDelegate
        _tableDelegate = [self createDelegate] ;
        
        _tableView.delegate = _tableDelegate;
    }
}




///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addToOverlayView:(UIView*)view {
    // _tableOverlayView用于展示其他信息，例如: errorView, emptyView等
    if (!_tableOverlayView) {
        CGRect frame = [self rectForOverlayView];
        
        // 如何添加overlay呢?
        _tableOverlayView = [[UIView alloc] initWithFrame:frame];
        _tableOverlayView.backgroundColor = [UIColor clearColor];
        
        _tableOverlayView.autoresizesSubviews = YES;
        _tableOverlayView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        
        // 和_tableView在同一个parent下
        NSInteger tableIndex = [_tableView.superview.subviews indexOfObject:_tableView];
        if (tableIndex != NSNotFound) {
            [_tableView.superview addSubview:_tableOverlayView];
        }
    }
    
    // view的高度和宽度会自适应调整
    view.frame = _tableOverlayView.bounds;
    view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_tableOverlayView addSubview:view];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)resetOverlayView {
    if (_tableOverlayView && !_tableOverlayView.subviews.count) {
        [_tableOverlayView removeFromSuperview];
        _tableOverlayView = nil;
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)addSubviewOverTableView:(UIView*)view {
    NSInteger tableIndex = [_tableView.superview.subviews
                            indexOfObject:_tableView];
    if (NSNotFound != tableIndex) {
        [_tableView.superview addSubview:view];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)layoutOverlayView {
    if (_tableOverlayView) {
        _tableOverlayView.frame = [self rectForOverlayView];
    }
}




///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)fadeOutView:(UIView*)view {
    
    [UIView beginAnimations:nil context:(__bridge void*)view];
    [UIView setAnimationDuration:TT_TRANSITION_DURATION];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(fadingOutViewDidStop:finished:context:)];
    view.alpha = 0;
    [UIView commitAnimations];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)fadingOutViewDidStop:(NSString*)animationID finished:(NSNumber*)finished
                     context:(void*)context {
    UIView* view = (__bridge UIView*)context;
    [view removeFromSuperview];
}

#pragma mark JHModelViewController


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)beginUpdates {
    [super beginUpdates];
    [_tableView beginUpdates];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)endUpdates {
    [super endUpdates];
    [_tableView endUpdates];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (BOOL)canShowModel {
    // 有数据才能够ShowModel
    if ([_tableViewModel respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        NSInteger numberOfSections = [_tableViewModel numberOfSectionsInTableView:_tableView];
        if (!numberOfSections) {
            return NO;
            
        } else if (numberOfSections == 1) {
            NSInteger numberOfRows = [_tableViewModel tableView:_tableView numberOfRowsInSection:0];
            return numberOfRows > 0;
            
        } else {
            return YES;
        }
        
    } else {
        NSInteger numberOfRows = [_tableViewModel tableView:_tableView numberOfRowsInSection:0];
        return numberOfRows > 0;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didLoadModel:(BOOL)firstTime {
    [super didLoadModel:firstTime];
    
    // 加载Model
    [_tableViewModel tableViewDidLoadModel:_tableView];
    // 我们的Model在这里已经准备好了?
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)didShowModel:(BOOL)firstTime {
    [super didShowModel:firstTime];
    
    if (![self isViewAppearing] && firstTime) {
        [_tableView flashScrollIndicators];
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showModel:(BOOL)show {
    // 直接load, 这样tableView可以保持当前的状态
    
    if (show) {
        [self updateTableDelegate];
        _tableView.dataSource = _tableViewModel;
        
    } else {
        _tableView.dataSource = nil;
    }
    
    [_tableView reloadData];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showLoading:(BOOL)show {
    if (show) {
        if (!self.model.isLoaded || ![self canShowModel]) {
#ifdef USE_CHUNYU_LOADING
            CYLoadingView* loadingView = [[CYLoadingView alloc] init];
            loadingView.isAnimating = YES;
            self.tblLoadingView =loadingView;
#else
            NSString* title = _tableViewModel ? [_tableViewModel titleForLoading:NO] : [self defaultTitleForLoading];
            
            // TODO: 重写
            if (title.length) {
                JHActivityView* label = [[JHActivityView alloc] initWithStyle: JHActivityLabelStyleBlackBox];
                label.text = title;
                label.backgroundColor = _tableView.backgroundColor;
                self.tableLoadingView = label;
            }
#endif
        }
        
    } else {
        self.tableLoadingView = nil;
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showError:(BOOL)show {
    
    // 首先判断是否是服务器出现Denied的异常
    NSString* data = [_modelError.userInfo objectForKey:NSLocalizedRecoverySuggestionErrorKey];
    BOOL isDenied = FALSE;
    if (data) {
        @try {
            
            NSDictionary* json = [data objectFromJSONString];
            isDenied = [json[@"code"] intValue] == -306;
        }
        @catch (NSException *exception) {
            
        }
        @finally {
        }
        
    }
    
    if (show) {
        // 如果数据没有加载，或者不能显示Model, 则展示Error
        if (!self.model.isLoaded || ![self canShowModel]) {
            if (isDenied) {
                if (self.errorView) {
                    return;
                }
                NSString* title = @"拒绝访问。";
                NSString* subtitle = @"您无权访问当前的问诊数据";
                ErrorView* errorView = [[ErrorView alloc] initWithTitle:title
                                                                   subtitle:subtitle
                                                                      image:[[UIImage load:@"ugly_face.png"] imageWithTintColor: RGBCOLOR_HEX(0xdddddd)]];
                errorView.backgroundColor = [UIColor clearColor];
                self.errorView = errorView;
                [self.view addSubview:self.errorView];
            } else {
                if (self.errorView) {
                    return;
                }
                NSString* title = [_tableViewModel titleForError: _modelError];
                NSString* subtitle = [_tableViewModel subtitleForError: _modelError];
                UIImage* image = [_tableViewModel imageForError: _modelError];
                
                if (title.length || subtitle.length || image) {
                    ErrorView* errorView = [[ErrorView alloc] initWithTitle: title
                                                                       subtitle: subtitle
                                                                          image: image];
                    NIDPRINT(@"frame:%@", NSStringFromCGRect(errorView.frame));
                    errorView.backgroundColor = _tableView.backgroundColor;
                    errorView.width = self.tableView.width;
                    errorView.height = self.tableView.height;
                    UIButton *button = [[UIButton alloc] initWithFrame: errorView.bounds];
                    [errorView addSubview: button];
                    
                    [button     addTarget: self
                                   action: @selector(reloadTableFromError)
                         forControlEvents: UIControlEventTouchUpInside];
                    self.errorView = errorView;
                    [self.view addSubview:self.errorView];
                } else {
                    [self.errorView removeFromSuperview];
                    self.errorView = nil;
                }
                
            }
            // 数据为空:
            _tableView.dataSource = nil;
            [_tableView reloadData];
        } else {
            // 其他情况下的showError
            if ([self.model isKindOfClass:[JHURLRequestModel class]]) {
                JHURLRequestModel* model = self.model;
                if (model.isLoadingMore) {
                    // 如果是加载更多出现问题:
                    [SVProgressHUD showErrorWithStatus:JHDescriptionForError(_modelError)];
                }
                
            }
        }
        
    } else {
        [self.errorView removeFromSuperview];
        self.errorView = nil;
    }
}

- (NSString*) titleForEmpty {
    return @"无记录";
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)showEmpty:(BOOL)show {
    [super showEmpty:show withText:@"暂无数据"];
}

- (void) refreshList {
    [self createModel];
}

#pragma mark - JHmodel delegate

- (void)modelDidStartLoad:(id<JHModel>)model
{
    [super modelDidStartLoad:model];
}

// Model加载成功
- (void)modelDidFinishLoad:(id<JHModel>)model withObject: (id) object
{
    [super modelDidFinishLoad:model withObject:object];
    if (model.isLoadingMore) {
        
        [self endTableviewFooterLoading];
    }else {
        [self.tableView reloadData];
        [self endTableviewHeaderLoading];
    }
}

// Model加载失败
- (void)model:(id<JHModel>)model didFailLoadWithError:(NSError*)error
{
    [self hideCustomazieLoading];
    [SVProgressHUD showErrorWithStatus:JHDescriptionForError(error)];
    [super model:model didFailLoadWithError:error];
    if (model.isLoadingMore) {
        
        [self endTableviewFooterLoading];
    }else {
        
        [self endTableviewHeaderLoading];
    }
}

// Model加载取消
- (void)modelDidCancelLoad:(id<JHModel>)model
{
    [super modelDidCancelLoad:model];
    if (model.isLoadingMore) {
        
        [self endTableviewFooterLoading];
    }else {
        
        [self endTableviewHeaderLoading];
    }
    
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)model:(id<JHModel>)model didUpdateObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    
    NIDASSERT([_tableViewModel isKindOfClass:[NITableViewModel class]]);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)model:(id<JHModel>)model didInsertObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    if (model == _model) {
        if (_flags.isShowingModel) {
            
        } else {
            [self refresh];
        }
    }
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)model:(id<JHModel>)model didDeleteObject:(id)object atIndexPath:(NSIndexPath*)indexPath {
    if (model == _model) {
        NIDPRINT(@"ShowingModel: %d", _flags.isShowingModel);
        
        if (_flags.isShowingModel) {
            
            
        } else {
            [self refresh];
        }
    }
}

#pragma mark - refresh & load more action

- (void)endTableviewHeaderLoading
{
    [self.tableView.header endRefreshing];
}

- (void)endTableviewFooterLoading
{
    [self.tableView.footer endRefreshing];
}

- (void)clearMJRefresh
{
    self.tableView.header = nil;
    self.tableView.footer = nil;
}

- (void) receiveDragLoadMoreInTop {
    NIDPRINTMETHODNAME();
    
}

@end


