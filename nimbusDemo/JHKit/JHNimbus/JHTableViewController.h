//
//  JHTableViewController.h
//  测试Demo
//
//  Created by Shenjinghao on 15/12/23.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHModelViewController.h"
#import <NITableViewActions.h>
#import "JHTableViewModel.h"

@interface JHTableViewController : JHModelViewController<UITableViewDelegate>
{
    UITableView*  _tableView;
    UIView*       _tableOverlayView;
    UIView*       _errorView;
    UIView*       _emptyView;
    
    UIView*           _menuView;
    UITableViewCell*  _menuCell;
    
    UITableViewStyle        _tableViewStyle;
    
    UIInterfaceOrientation  _lastInterfaceOrientation;
    
    BOOL _variableHeightRows;
    BOOL _showTableShadows;
    BOOL _clearsSelectionOnViewWillAppear;
    
    
    id<UITableViewDelegate> _tableDelegate; // strong ref.
    
}

// 是否可以下拉刷新
@property (nonatomic) BOOL canDragRefreshTableView;

// 是否可以上拉加载更多
@property (nonatomic) BOOL canDragLoadMore;

// 是否可以下拉加载更多
@property (nonatomic) BOOL canDragLoadMoreInTop;

@property (nonatomic) CGFloat initialViewTopInset;

//
// 创建tableViewActions
// 不能在init函数中调用，必须等viewDidLoad调用时或调用之后才能调用
//
@property (nonatomic, strong) NITableViewActions* tableViewActions;

//
// TableViewModel和Three20中的DataSource相似，主要是实现UITableDataSource接口
// 必须通过 self.tableViewModel = xxx来设置tableView的datasource， 不能直接通过self.tableview.datasource =xxx
//
@property (nonatomic, strong) JHTableViewModel* tableViewModel;


//
// 必须使用self.cellFactory来获取NICellFactory, 不能使用[NICellFactory class]
//
@property (nonatomic, strong) NICellFactory* cellFactory;

@property (nonatomic, strong) UITableView* tableView;

/**
 * A view that is displayed over the table view._tableOverlayView用于展示其他信息，例如: errorView, emptyView等
 */
@property (nonatomic, strong) UIView* tableOverlayView;

@property (nonatomic, strong) UIView* tableLoadingView;
//@property (nonatomic, strong) UIView* errorView;
//@property (nonatomic, strong) UIView* emptyView;

@property (nonatomic, strong) NSString* titleForEmpty;

/**
 * The style of the table view.
 */
@property (nonatomic) UITableViewStyle tableViewStyle;


/**
 * When enabled, draws gutter shadows above the first table item and below the last table item.
 *
 * Known issues: When there aren't enough cell items to fill the screen, the table view draws
 * empty cells for the remaining space. This causes the bottom shadow to appear out of place.
 */
@property (nonatomic) BOOL showTableShadows;

/**
 * A Boolean value indicating if the controller clears the selection when the table appears.
 * Default is YES.
 */
@property (nonatomic) BOOL clearsSelectionOnViewWillAppear;

/**
 * Initializes and returns a controller having the given style.
 */
- (id)initWithStyle:(UITableViewStyle)style;

/**
 * Creates an delegate for the table view.
 *
 * Subclasses can override this to provide their own table delegate implementation.
 */
// - (id<UITableViewDelegate>)createDelegate;


/**
 * Tells the controller that the user began dragging the table view.
 */
- (void)didBeginDragging;

/**
 * Tells the controller that the user stopped dragging the table view.
 */
- (void)didEndDragging;

/**
 * The rectangle where the overlay view should appear.
 */
- (CGRect)rectForOverlayView;


- (NIActionBlock) loadMoreActionBlock;

- (void) reloadTableFromError;

/**
 *  model加载完数据需要更新时都显示上拉加载更多
 */
//- (void) updateLoadMoreView:(BOOL)show;

/**
 *  上拉加载更多 把上拉的view放在的tableView.tableFooterView;
 *  当hasMore = NO;无需加载更多时，上拉的View从tableView.tableFooterView移除，显示下面方法中的默认view，一般是一个为了保证显示效果的阴影
 */
- (UIView*) footerViewForNoMore;

/**
 *  下拉加载更多，接收到 scrollview的通知后调用的方法
 *
 */
- (void) receiveDragLoadMoreInTop;

/**
 * 清除MJRefresh控件.
 */
- (void)clearMJRefresh;

/**
 * 更新上拉加载更多的MJRefresh控件.
 */
- (void)updateLoadMoreView:(BOOL)hasMore;

/**
 * 用户下拉刷新进行时的会掉.
 * 注：调用createModel不会触发此方法
 */
- (void)tableviewDidDragRefresh;



@end

