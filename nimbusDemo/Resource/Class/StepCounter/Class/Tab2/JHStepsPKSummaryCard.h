//
//  JHStepsPKSummaryCard.h
//  测试Demo
//
//  Created by Shenjinghao on 16/7/19.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHCardView.h"
#import "PKItem.h"

@protocol StepsPKSummaryCardDelegate <NSObject>

- (void)stepsPKDetailCardHided;

- (void)stepsPKDetailCardOnDelete;

@end

@interface JHStepsPKSummaryCard : JHCardView

+ (JHStepsPKSummaryCard *)sharedInstance;

- (void)updateWithData:(PKItem *)pkItem;

// flipContainer already contained the view to be exchanged with
- (void)showFlipWithView:(UIView *)flipContainer;

- (void)hide;

- (void)hideWithoutAnimation;

@property (nonatomic, weak) id<StepsPKSummaryCardDelegate> summaryCardDelegate;

@property (nonatomic) BOOL showing;

@end
