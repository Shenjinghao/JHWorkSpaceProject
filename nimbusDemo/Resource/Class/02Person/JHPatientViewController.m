//
//  JHPatientViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 15/12/28.
//  Copyright © 2015年 Shenjinghao. All rights reserved.
//

#import "JHPatientViewController.h"
#import "JHCollectionViewFlowLayout.h"
#import "JHCollectionViewCell.h"

#define kOwnViewLayoutHeaderHeight 90
static NSString* cellID = @"collectionCell";

@interface JHPatientViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) JHCollectionViewFlowLayout *layout;

@property (nonatomic, strong) UICollectionView *ownCollectionView;

@property (nonatomic, strong) NSArray* dataArray;

@end

@implementation JHPatientViewController

- (id)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        
        self.hidesBottomBarWhenPushed = NO;
        
        _dataArray = [NSArray array];
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"患者";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.hidesBackButton = YES;
    //创建collectionview
    self.layout = [[JHCollectionViewFlowLayout alloc] initWithHeaderHeight:kOwnViewLayoutHeaderHeight];
    _ownCollectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:self.layout];
    _ownCollectionView.delegate = self;
    _ownCollectionView.dataSource = self;
//    cell
    [_ownCollectionView registerClass:[JHCollectionViewCell class] forCellWithReuseIdentifier:cellID];
//    header
    [_ownCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
    
    _ownCollectionView.showsVerticalScrollIndicator = NO;
    _ownCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _ownCollectionView.backgroundColor = COLOR_A9;
    [self.view addSubview:_ownCollectionView];
    
    //获取数据
    [self loadLocalCollectionList];
    _dataArray = [JHUtility userDefaultObjectForKey:@"Collection_List"];
}

- (void)loadLocalCollectionList
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Collection_List" ofType:@"plist"];
    NSMutableArray *pathData = [NSMutableArray arrayWithContentsOfFile:path];
    
    //将读取到的列表存放在NSUserDefaults中，以此保证createClinicView逻辑的正确性
    NSUserDefaults *collectionInfo = [NSUserDefaults standardUserDefaults];
    [collectionInfo setObject:pathData forKey:@"Collection_List"];
    [collectionInfo synchronize];
    
}

#pragma mark -
#pragma mark - collection view delegate & data source
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.view.frame.size.width, self.layout.headerHeight);
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    JHCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    if (indexPath.item < _dataArray.count) {
        NSDictionary *info = _dataArray[indexPath.item];
        NSInteger collectionId = [info[@"clinic_no"] integerValue];
        NSString* iconImageName = [NSString stringWithFormat:@"clinic_%02zi_icon_c.png", collectionId];
        NSString* title = info[@"clinic_name"];
        
//        NSString *bundlePath = NIPathForBundleResource(nil, iconImageName);
        cell.collectionImage.image = [UIImage imageNamed:iconImageName];
        cell.collectionName.text = title;
    }
    return cell;
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    JHCollectionViewCell* cell = (JHCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    [cell.contentView setBackgroundColor:[UIColor lightGrayColor]];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath {
    JHCollectionViewCell* cell = (JHCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell.contentView setBackgroundColor:[UIColor whiteColor]];
}
//header
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableView = [[UICollectionReusableView alloc] init];
    reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
    reusableView.backgroundColor = COLOR_A5;
    return reusableView;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *alertText = _dataArray[indexPath.item][@"clinic_name"];
    if (IOSOVER(8)) {
        
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"触发" message:alertText preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"好" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertVC addAction:action];
        [self presentViewController:alertVC animated:YES completion:nil];
    }else{
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"触发" message:alertText delegate:self cancelButtonTitle:@"好" otherButtonTitles:@"", nil];
        [alertView show];
        
    }
    
}

- (NSString *)tabTitle {
    return @"患者";
}

- (NSString *)tabImageName {
    return @"tabbar_patient_disable";
}

- (NSString *)tabImageNameSel {
    return @"tabbar_patient";
}


@end
