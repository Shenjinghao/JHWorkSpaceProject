//
//  JHCollectionViewFlowLayout.m
//  测试Demo
//
//  Created by Shenjinghao on 16/6/13.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHCollectionViewFlowLayout.h"

static CGFloat dividX = 0.5;
static CGFloat dividY = 0.5;

@interface JHCollectionViewFlowLayout ()

@property (nonatomic) NSInteger columnCount;    //列数
@property (nonatomic) NSInteger itemCount;      //项目个数
@property (nonatomic) CGFloat itemHeight;       //项目高度
@property (nonatomic) CGFloat itemWidth;        //项目宽度
@property (nonatomic, strong) NSMutableArray* itemAttributes;  //存储item


@end

@implementation JHCollectionViewFlowLayout


- (instancetype)initWithHeaderHeight:(CGFloat)headerHeight
{
    self = [super init];
    if (self) {
        _headerHeight = headerHeight;
        _itemAttributes = [NSMutableArray array];
        
        _columnCount = 4;
        _itemWidth = (viewWidth() - (_columnCount - 1) * dividX) / _columnCount;
        _itemHeight = _itemWidth / 80 * 90;
        
        //为collectionview添加headerview
        self.headerReferenceSize = CGSizeMake(viewWidth(), self.headerHeight);
    }
    return self;
}

- (void)setHeaderHeight:(CGFloat)headerHeight {
    _headerHeight = headerHeight;
    //
    self.headerReferenceSize = CGSizeMake(viewWidth(), headerHeight);
    
    [self creatLayoutAttrbutes];
}

- (void)prepareLayout
{
    [super prepareLayout];
    [self creatLayoutAttrbutes];
}
/**
 *  在初始化一个UICollectionViewLayout实例后，会有一系列准备方法被自动调用，以保证layout实例的正确。
 */
- (void)creatLayoutAttrbutes
{
    _itemCount = [self.collectionView numberOfItemsInSection:0];
    
    //创建header
    UICollectionViewLayoutAttributes *header = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:@"header" withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    header.frame = CGRectMake(0, 0, viewWidth(), self.headerHeight);
    [_itemAttributes addObject:header];
    
    //布局
    for (NSInteger i = 0; i < _itemCount; i ++) {
        
        NSInteger columnIndex = i % _columnCount;
        NSInteger columnRow = i / _columnCount;
        //偏移量
        CGFloat xOffSet = dividX + (dividX + _itemWidth) * columnIndex;
        CGFloat yOffSet = (dividY + _itemHeight) * columnRow;
        
        //##################################警告  这样写会出现     2016-06-16 18:27:44.354 测试Demo[17653:475081] *** Terminating app due to uncaught exception 'NSInternalInconsistencyException', reason: 'UICollectionView received layout attributes for a cell with an index path that does not exist: <NSIndexPath: 0xc00000000000000e> {length = 1, path = 0}'
//        NSIndexPath *indexPath = [NSIndexPath indexPathWithIndex:i];
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *layoutAttrbutes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        layoutAttrbutes.frame = CGRectMake(xOffSet, yOffSet + self.headerHeight, _itemWidth, _itemHeight);
        
        [_itemAttributes addObject:layoutAttrbutes];
        
    }
    
}
/**
 *  以确定collection应该占据的尺寸。注意这里的尺寸不是指可视部分的尺寸，而应该是所有内容所占的尺寸
 *
 *  @return
 */
- (CGSize)collectionViewContentSize
{
    if (_itemCount == 0) {
        return CGSizeZero;
    }
    
    CGSize contentSize = self.collectionView.frame.size;
    NSInteger columnIndex = _itemCount % _columnCount == 0 ? (_itemCount / _columnCount) : (_itemCount / _columnCount) + 1;
    CGFloat height = columnIndex * (_itemHeight + dividY);
    contentSize.height = self.headerHeight + height;
    return contentSize;
}
/**
 *  返回对应于indexPath的位置的追加视图的布局属性，如果没有追加视图可不重载
 *
 *  @param elementKind
 *  @param indexPath
 *
 *  @return
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader]) {
        //去除存储的header
        UICollectionViewLayoutAttributes *attrbute = _itemAttributes.firstObject;
        attrbute.frame = CGRectMake(0, 0, viewWidth(), self.headerHeight);
        return attrbute;
    }else{
        return nil;
    }
    
}

/**
 *  返回对应于indexPath的位置的cell的布局属性
 *
 *  @param indexPath
 *
 *  @return
 */
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (self.itemAttributes)[indexPath.item];
}

/**
 *  初始的layout的外观将由该方法返回的UICollectionViewLayoutAttributes来决定。
 *
 *  @param rect
 *
 *  @return
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [self.itemAttributes filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(UICollectionViewLayoutAttributes *evaluatedObject, NSDictionary *bindings){
//        判断一个CGRect是否包含再另一个CGRect里面,常用与测试给定的对象之间是否又重叠
        return CGRectIntersectsRect(rect, [evaluatedObject frame]);
    }]];
    
}
/**
 *  当边界发生改变时，是否应该刷新布局。如果YES则在边界变化（一般是scroll到其他地方）时，将重新计算需要的布局信息。
 *
 *  @param newBounds
 *
 *  @return
 */
- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return NO;
}

@end
