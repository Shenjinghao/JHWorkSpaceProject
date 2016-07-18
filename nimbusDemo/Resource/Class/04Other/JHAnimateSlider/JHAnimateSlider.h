//
//  JHAnimateSlider.h
//  测试Demo
//
//  Created by Shenjinghao on 16/6/20.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^JHAnimationInvokeBlock)(void);

typedef NS_ENUM(NSInteger, SliderState){
    kSliderStateUnFinished,
    kSliderStateFinished,
    
    kSliderStateInCheckAnimation,			// private state
};

@interface JHAnimateSlider : UISlider

@property (nonatomic, strong) NSString* text;			// set the text in label.

@property (nonatomic) SliderState sliderState;			// public state contain finished & unfinished.

@property (nonatomic, strong) JHAnimationInvokeBlock tapBlock;	// tap event invoke this block to do something.

@property (nonatomic, strong) JHAnimationInvokeBlock finishBlock;	// invoke when the sliderstate change to Finished

@end


@interface JHLoadingMaskView : UIView

@property (nonatomic) CGFloat progress;			// it has the same range with RRAnimateSlider's value

- (void)invokeDrawAnimation:(CGFloat)value;

@end




