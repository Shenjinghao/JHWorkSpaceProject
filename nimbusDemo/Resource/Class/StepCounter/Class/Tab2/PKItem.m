//
//  PKItem.m
//  测试Demo
//
//  Created by Shenjinghao on 16/7/19.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "PKItem.h"

@implementation PKItem
{
    NSString *_nickName;
    
    NSInteger _steps0;
    NSInteger _steps1;
    BOOL _pkFinished;
    NSString *_img;
}

- (id)init{
    self = [super init];
    if (self) {
//        _unionId = item.pkFriend.unionId;
//        _friendFigure = item.pkFriend.figureURL;
//        _nickName = item.pkFriend.nickname;
//        _friendTrophyType = item.pkFriend.badgeType;
//        _date = item.date;
        _steps0 = 1000;
        _steps1 = 500;
        _msg = @"哈哈";
        _img = @"steps-pk-current-leading.png";
        _pkFinished = NO;
        
        _action = @"wakeup";
        _actionText = @"唤醒好友";
    }
    return self;
}

- (NSString *)nickName {

    return @"春雨君";

}

- (NSInteger)steps0 {

    return _steps0;
}

- (NSInteger)steps1 {
    return _steps1;
}

- (NSString *)waitingMsg {
    if (self.steps0 > self.steps1) {
        return @"连胜就在我眼前，万事俱备，只等开战!";
    }
    else if (self.steps0 < self.steps1) {
        return @"明天快点到来，复仇的火焰已经吞噬了我!";
    }
    else {
        return @"今天居然打平了？明天一定要赢下来!";
    }
}

- (NSString *)ongoingMsg {
    if (self.steps0 > self.steps1) {
        return [NSString stringWithFormat:@"你已领先%zi步，%@被甩在身后！", self.steps0 - self.steps1, self.nickName];
    }
    else if (self.steps0 < self.steps1) {
        return [NSString stringWithFormat:@"%@领先你%zi步，出去溜达溜达灭了TA！", self.nickName, self.steps1 - self.steps0];
    }
    else {
        return [NSString stringWithFormat:@"居然势均力敌？快趁%@不注意超过TA吧!", self.nickName];
    }
}

- (NSString *)resultNotReadyMsg {
    return @"比赛结果被堵在路上，未知胜负。";
}

- (UIImage *)resultNotReadyImage {
    return [UIImage load:@"steps-pk-waiting-result.png"];
}

- (UIImage *)wakeupImage {
    return [UIImage load:@"steps-pk-friend-sleep.png"];
}

- (UIImage *)ongoingImage {
    if (self.steps0 > self.steps1) {
        return [UIImage load:@"steps-pk-current-leading.png"];
    }
    else {
        return [UIImage load:@"steps-pk-current-behind.png"];
    }
}

- (UIImage *)waitingImage {
    if (self.steps0 > self.steps1) {
        return [UIImage load:@"steps-pk-waiting-win.png"];
    }
    else if (self.steps0 < self.steps1) {
        return [UIImage load:@"steps-pk-waiting-lose.png"];
    }
    else {
        return [UIImage load:@"steps-pk-waiting-tie.png"];
    }
}

- (NSString *)img {
    return _img;
}

//- (BOOL)pkResultReady {
//    // 服务器返回了氛围图，才认为比赛结果好了
//    if (_img && [_img isNonEmpty]) {
//        return YES;
//    }
//    else {
//        return NO;
//    }
//}

- (BOOL)wakeup {
    return [self.action isEqualToString:@"wakeup"];
}

//- (BOOL)pkFinished {
//    if (_pkFinished) {
//        return YES; // 在StepsPKCardModel中人为设置的finished
//    }
//    
//    // 实时计算，因为今天的结束状态会变
//    if ([self.date isSameDayAsToday]) {
//        // 到了9点就认为结束了
//        return [[StepsPKDB sharedInstance] pkFinished];
//    }
//    else {
//        return [self.date compareDateOnly:[NSDate date]] == NSOrderedAscending;
//    }
//}
//
//// 只有在有明天卡片时有效，是否有明天卡片，在StepsPKCardModel里控制
//- (BOOL)pkNotBeginYet {
//    return [[self.date yesterday] isSameDayAsToday];
//}
//
//- (NSString *)displayDate {
//    if ([self.date isSameDayAsToday]) {
//        return @"今天";
//    }
//    else if ([[self.date yesterday] isSameDayAsToday]) {
//        return @"明天";
//    }
//    else {
//        NSDateComponents *comps = [self.date components];
//        return [NSString stringWithFormat:@"%zi月%zi日", comps.month, comps.day];
//    }
//}

@end
