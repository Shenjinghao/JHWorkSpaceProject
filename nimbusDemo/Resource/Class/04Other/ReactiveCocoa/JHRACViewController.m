//
//  JHRACViewController.m
//  测试Demo
//
//  Created by Shenjinghao on 16/1/11.
//  Copyright © 2016年 Shenjinghao. All rights reserved.
//

#import "JHRACViewController.h"
#import "JHRACKittenViewController.h"

#import <ReactiveCocoa.h>

@interface JHRACViewController ()


@property (nonatomic) BOOL passwordIsValid;
@property (nonatomic) BOOL usernameIsValid;

@property (nonatomic,strong) UITextField *usernameTextField;
@property (nonatomic,strong) UITextField *passwordTextField;
@property (nonatomic,strong) UIButton *signInButton;

@property (nonatomic,strong) UILabel *signInFailureText;
@property (nonatomic,strong) JHRACKittenViewController *VC;

@end

@implementation JHRACViewController
{
    
}

- (id)initWithQuery:(NSDictionary *)query
{
    self = [super initWithQuery:query];
    if (self) {
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated
{
   
    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"ReactiveCocoa";
//    [self updateUIState];
    
    [self creatView];
    
    [self useReactiveCocoa];
    
}

- (void) useReactiveCocoa
{
    //begin ReactiveCocoa
    //1
    [_usernameTextField.rac_textSignal subscribeNext:^(id x) {
        NIDPRINT(@"%@",x);
    }];
    //2 filter,限定条件（过滤器）
    [[_usernameTextField.rac_textSignal filter:^BOOL(id value) {
        NSString *text = value;
        //返回bool
        return text.length > 3;
    }] subscribeNext:^(id x) {
        NIDPRINT(@"%@",x);
    }];
    //3 直接修改形参类型
    [[_usernameTextField.rac_textSignal filter:^BOOL(NSString* text) {
        
        //返回bool
        return text.length > 3;
    }] subscribeNext:^(id x) {
        NIDPRINT(@"%@",x);
    }];
    //4 map转换参数类型
    [[[_usernameTextField.rac_textSignal map:^id(NSString* text) {
        return @(text.length);
    }] filter:^BOOL(NSNumber* length) {
        return [length floatValue] > 3;
    }] subscribeNext:^(id x) {
        NIDPRINT(@"%@",x);
    }];
    
    [self createFooterButton];
    
    WEAK_VAR(self);
    //ReactiveCocoa   NSNumber封装的布尔值
    
    RACSignal *validUsernameSignal = [_usernameTextField.rac_textSignal map:^id(NSString* text) {
        return @([_self isValidUsername:text]);
    }];
    
    RACSignal *validPasswordSignal = [_passwordTextField.rac_textSignal map:^id(NSString* text) {
        return @([_self isValidPassword:text]);
    }];
    //RAC（对象，属性）
    RAC(_usernameTextField,backgroundColor) = [validUsernameSignal map:^id(NSNumber* usernameValid) {
        return[usernameValid boolValue] ? [UIColor clearColor]:[UIColor greenColor];
    }];
    RAC(_passwordTextField,backgroundColor) = [validPasswordSignal map:^id(NSNumber* passwordValid) {
        return[passwordValid boolValue] ? [UIColor clearColor]:[UIColor greenColor];
    }];
    //聚合信号
    RACSignal *signUpActiveSignal = [RACSignal combineLatest:@[validUsernameSignal,validPasswordSignal] reduce:^id(NSNumber*usernameValid, NSNumber *passwordValid){
        return @([usernameValid boolValue] && [passwordValid boolValue]);
    }];
    //button绑定
    [signUpActiveSignal subscribeNext:^(NSNumber*signupActive) {
        _self.signInButton.enabled = [signupActive boolValue];
    }];
    //    //flattenMap
    //    [[[_signInButton rac_signalForControlEvents:UIControlEventTouchUpInside] flattenMap:^RACStream *(id value){
    //        return [self signInSignal];
    //
    //    }] subscribeNext:^(NSNumber*signedIn) {
    //        BOOL success = [signedIn boolValue];
    //        _signInButton.enabled = YES;
    //        _signInFailureText.hidden = success;
    //        if (success) {
    //            [self.navigationController pushViewController:_VC animated:YES];
    //
    //        }
    //    }];
    //最终合体版
    [[[[_self.signInButton rac_signalForControlEvents:UIControlEventTouchUpInside] doNext:^(id x) {
        _self.signInButton.enabled = NO;
        _self.signInFailureText.hidden = YES;
    }] flattenMap:^RACStream *(id value) {
        return [_self signInSignal];
    }] subscribeNext:^(NSNumber*signedIn) {
        BOOL success = [signedIn boolValue];
        _self.signInButton.enabled = YES;
        _self.signInFailureText.hidden = success;
        if (success) {
            [_self.navigationController pushViewController:_self.VC animated:YES];
            
        }
    }];
}

- (RACSignal *)signInSignal {
    WEAK_VAR(self);
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber){
        _self.signInButton.enabled = NO;
        _self.signInFailureText.hidden = YES;
        _VC = [[JHRACKittenViewController alloc] initWithQuery:@{@"title":@"Kitty"}];
        [_VC signInWithUsername:_usernameTextField.text
         password:_passwordTextField.text
         complete:^(BOOL success){
             [subscriber sendNext:@(success)];
             [subscriber sendCompleted];
         }];
        return nil;
    }];
}

- (void) creatView
{
    WEAK_VAR(self);
    _usernameTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 100, viewWidth() - 90, 40)];;
    _usernameTextField.placeholder = @"用户名";
    _usernameTextField.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_usernameTextField];
    
    _passwordTextField = [[UITextField alloc] initWithFrame:CGRectMake(45, 150, viewWidth() - 90, 40)];;
    _passwordTextField.placeholder = @"密码";
    _passwordTextField.borderStyle = UITextBorderStyleBezel;
    [self.view addSubview:_passwordTextField];
    
    _self.signInButton = [[UIButton alloc] initWithFrame:CGRectMake(viewWidth() - 100, 200, 70, 40)];
    [_self.signInButton setTitle:@"登录" forState:UIControlStateNormal];
    _self.signInButton.backgroundColor = COLOR_A1;
    [_self.signInButton setTitle:@"登录中" forState:UIControlStateDisabled];
//    [_signInButton addTarget:self action:@selector(signInButtonTouched:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_self.signInButton];
    
    
    // handle text changes for both text fields
//    [_usernameTextField addTarget:self action:@selector(usernameTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
//    [_passwordTextField addTarget:self action:@selector(passwordTextFieldChanged) forControlEvents:UIControlEventEditingChanged];
   
    
    _usernameTextField.backgroundColor = [UIColor yellowColor];
    _passwordTextField.backgroundColor = [UIColor yellowColor];
    
    _self.signInFailureText = [UILabel labelWithFrame:CGRectMake(45, 200, 170, 40) fontSize:15 fontColor:COLOR_A12 text:@"登录失败"];
    _self.signInFailureText.hidden = YES;
    [self.view addSubview:_self.signInFailureText];
}

- (void) createFooterButton
{
    CGRect frame = self.view.frame;
    
    frame.size.height -= 50.0f;
    JHFilledColorButton *_btn = [[JHFilledColorButton alloc] initWithFrame:CGRectMake(10, frame.size.height, viewWidth()-20, 44) color:RGBCOLOR_HEX(0x2693dd) highlightedColor:RGBCOLOR_HEX(0x9d9d9d) enabledColor:RGBCOLOR_HEX(0xd3d7dc) textColor:RGBCOLOR_HEX(0xffffff) enabledTextColor:RGBCOLOR_HEX(0xffffff) title:@"ReactiveCocoa" fontSize:16 isBold:NO];
    
    WEAK_VAR(self);
    [[[_btn rac_signalForControlEvents:UIControlEventTouchUpInside] takeUntil:_btn.rac_willDeallocSignal] subscribeNext:^(id x) {
        
        _self.VC = [[JHRACKittenViewController alloc] initWithQuery:@{@"title":@"Kitty"}];
        [_self.navigationController pushViewController:_self.VC animated:YES];
    }];
    [self.view addSubview:_btn];
}

- (IBAction)signInButtonTouched:(id)sender
{
    WEAK_VAR(self);
    _self.signInButton.enabled = NO;
    _self.signInFailureText.hidden = YES;
    _VC = [[JHRACKittenViewController alloc] initWithQuery:@{@"title":@"Kitty"}];

    [_VC signInWithUsername:_usernameTextField.text password:_passwordTextField.text complete:^(BOOL success) {
        _self.signInButton.enabled = YES;
        _self.signInFailureText.hidden = success;
        
        if (success) {
            
            [_self.navigationController pushViewController:_self.VC animated:YES];
        }
    }];
    
}


// updates the enabled state and style of the text fields based on whether the current username
// and password combo is valid
- (void)updateUIState {
    
//    _usernameTextField.backgroundColor = self.usernameIsValid ? [UIColor clearColor] : [UIColor yellowColor];
//    _passwordTextField.backgroundColor = self.passwordIsValid ? [UIColor clearColor] : [UIColor yellowColor];
    self.signInButton.enabled = self.usernameIsValid && self.passwordIsValid;
}

- (BOOL)isValidUsername:(NSString *)username {
    return username.length > 3;
}

- (BOOL)isValidPassword:(NSString *)password {
    return password.length > 3;
}

- (void)usernameTextFieldChanged {
    self.usernameIsValid = [self isValidUsername:_usernameTextField.text];
    [self updateUIState];
}

- (void)passwordTextFieldChanged {
    self.passwordIsValid = [self isValidPassword:_passwordTextField.text];
    [self updateUIState];
}

-(void)dealloc
{
    
}

@end
