//
//  PKItem.h
//  测试Demo
//
//  Created by Shenjinghao on 16/7/19.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PKItem : NSObject

//- (id)initWithStepsPKItem:(StepsPKItem *)item;

- (UIImage *)waitingImage;

- (UIImage *)ongoingImage;

- (UIImage *)wakeupImage;

- (UIImage *)resultNotReadyImage;

- (NSString *)resultNotReadyMsg;

- (NSString *)ongoingMsg;

- (NSString *)waitingMsg;

@property (nonatomic, readonly) BOOL pkFinished;

@property (nonatomic, readonly) NSString *unionId;

@property (nonatomic, readonly) BOOL pkNotBeginYet;

@property (nonatomic, readonly) NSDate *date;

@property (nonatomic, readonly) NSString *friendFigure;

//@property (nonatomic, readonly) TrophyType friendTrophyType;

@property (nonatomic, readonly) NSInteger steps0;

@property (nonatomic, readonly) NSInteger steps1;

@property (nonatomic, readonly) NSString *nickName;

@property (nonatomic, readonly) NSString *displayDate;

@property (nonatomic, readonly) NSString *action;

@property (nonatomic, readonly) NSString *actionText;

@property (nonatomic, readonly) NSString *msg;
@property (nonatomic, readonly) NSString *img;

@property (nonatomic, readonly) BOOL pkResultReady;

@property (nonatomic, readonly) BOOL wakeup;

@end
