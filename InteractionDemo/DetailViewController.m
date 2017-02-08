//
//  DetailViewController.m
//  InteractionDemo
//
//  Created by 王海堑 on 2017/2/7.
//  Copyright © 2017年 DSHD network technology co.,. All rights reserved.
//

#import "DetailViewController.h"
#import "CustomPopTransition.h"
#import "HomeViewController.h"

@interface DetailViewController ()<UINavigationControllerDelegate>
{
    CGFloat screenWidth;
    CGFloat screenHeight;
}

@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, strong) UIPercentDrivenInteractiveTransition *interactionPopTransition;

@end

@implementation DetailViewController

- (instancetype)initWithImageName:(NSString *)imageName content:(NSString *)content
{
    self = [super init];
    if (self) {
        self.imageName = imageName;
        self.content = content;
    }
    return self;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = self;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (self.navigationController.delegate == self) {
        self.navigationController.delegate = nil;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Detail";
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self initAvatarImageView];
    [self initContentLabel];
    //返回手势
    UIScreenEdgePanGestureRecognizer *popRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePopRecognizer:)];
    popRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:popRecognizer];
}

- (void)handlePopRecognizer:(UIScreenEdgePanGestureRecognizer *)recognizer{
    CGFloat progress = [recognizer translationInView:self.view].x / (self.view.bounds.size.width * 1.0);
    progress = MIN(1.0, MAX(0.0, progress));
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        //创建过渡对象,弹出viewController
        self.interactionPopTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
        [self.navigationController popViewControllerAnimated:YES];
    }else if (recognizer.state == UIGestureRecognizerStateChanged){
        //更新 interactive transition的进度
        [self.interactionPopTransition updateInteractiveTransition:progress];
    }else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled){
        //完成或者取消过渡
        if (progress > 0.5) {
            [self.interactionPopTransition finishInteractiveTransition];
        }else{
            [self.interactionPopTransition cancelInteractiveTransition];
        }
        self.interactionPopTransition = nil;
    }
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    //检查一下是不是自定义的过渡动画的情景
    if (fromVC == self && [toVC isKindOfClass:[HomeViewController class]]) {
        return [[CustomPopTransition alloc] init];
    }else{
        return nil;
    }
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController{
    //检查是否是自定义过渡
    if ([animationController isKindOfClass:[CustomPopTransition class]]) {
        return self.interactionPopTransition;
    }else{
        return nil;
    }
}

- (void)initAvatarImageView{
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenWidth)];
    self.avatarImageView.image = [UIImage imageNamed:self.imageName];
    [self.view addSubview:self.avatarImageView];
}

- (void)initContentLabel{
    self.contentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, screenWidth + 79, screenHeight, 50)];
    self.contentLabel.font = [UIFont systemFontOfSize:15];
    self.contentLabel.textColor = [UIColor grayColor];
    self.contentLabel.text = self.content;
    [self.view addSubview:self.contentLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
