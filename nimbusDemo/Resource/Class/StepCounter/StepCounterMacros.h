//
//  StepCounterMacros.h
//  测试Demo
//
//  Created by Shenjinghao on 16/7/19.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#ifndef StepCounterMacros_h
#define StepCounterMacros_h



#define kStepsPKPageTop 22
#define kStepsPKPageLeft 22

#define kPageWidthRatio (viewWidth() / 320)
#define kPageHeightRatio pow(kPageWidthRatio, 0.9)

#define kStepsPKPage5sHeight (IS_iPhone4 ? 350 : 396)
#define kStepsPKPageHeight (kStepsPKPage5sHeight * kPageHeightRatio)


#endif /* StepCounterMacros_h */
