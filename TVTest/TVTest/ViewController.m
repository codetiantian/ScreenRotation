//
//  ViewController.m
//  TVTest
//
//  Created by 这个夏天有点冷 on 2017/2/14.
//  Copyright © 2017年 YLT. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *changeButton;
- (IBAction)changeButtonClicked:(UIButton *)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addNotification];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 试试分支的创建与合并
#pragma mark - 分支合并成功


#pragma mark - 添加通知
- (void)addNotification
{
    //  设备旋转
    [[UIDevice currentDevice] beginGeneratingDeviceOrientationNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onDeviceOrientationChange) name:UIDeviceOrientationDidChangeNotification object:nil];
    

}

- (void)onDeviceOrientationChange
{
    UIDeviceOrientation orientation = [UIDevice currentDevice].orientation;
    
    UIInterfaceOrientation ori = (UIInterfaceOrientation)orientation;
    
    switch (ori) {
        case UIInterfaceOrientationPortrait:
            NSLog(@"正竖屏");
            break;
            
        case UIInterfaceOrientationPortraitUpsideDown:
            NSLog(@"逆竖屏");
            break;
            
        case UIInterfaceOrientationLandscapeLeft:
            NSLog(@"左横屏");
            break;
            
        case UIInterfaceOrientationLandscapeRight:
            NSLog(@"右横屏");
            break;
            
        case UIInterfaceOrientationUnknown:
            NSLog(@"未知方向");
            break;
            
        default:
            break;
    }
    
}

- (IBAction)changeButtonClicked:(UIButton *)sender {
    UIInterfaceOrientation orientation = (UIInterfaceOrientation)[UIDevice currentDevice].orientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft || orientation == UIInterfaceOrientationLandscapeRight || orientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        [self changeCurrentOprentation:UIInterfaceOrientationPortrait];
    } else {
        [self changeCurrentOprentation:UIInterfaceOrientationLandscapeRight];
    }
}

#pragma mark - 改变屏幕方向
- (void)changeCurrentOprentation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] respondsToSelector:@selector(setOrientation:)]) {
        SEL seletor = NSSelectorFromString(@"setOrientation:");
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:[UIDevice instanceMethodSignatureForSelector:seletor]];
        [invocation setSelector:seletor];
        [invocation setTarget:[UIDevice currentDevice]];
        [invocation setArgument:&interfaceOrientation atIndex:2];
        [invocation invoke];
    }
}

- (void)dealloc
{
    [[UIDevice currentDevice] endGeneratingDeviceOrientationNotifications];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];
}

@end
