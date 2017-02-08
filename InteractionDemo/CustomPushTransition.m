//
//  CustomTransition.m
//  InteractionDemo
//
//  Created by 王海堑 on 2017/2/7.
//  Copyright © 2017年 DSHD network technology co.,. All rights reserved.
//

#import "CustomPushTransition.h"
#import "HomeViewController.h"
#import "DetailViewController.h"
#import "AvatarCollectionViewCell.h"

@implementation CustomPushTransition

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    //获取跳转前后视图
    HomeViewController *homeVC = (HomeViewController *)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    DetailViewController *detailVC = (DetailViewController *)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //获取containerView
    UIView *containerView = [transitionContext containerView];
    //获取collectionViewCell上图片的截图
    AvatarCollectionViewCell *cell = (AvatarCollectionViewCell *)[homeVC.customCollectionView cellForItemAtIndexPath:[[homeVC.customCollectionView indexPathsForSelectedItems] firstObject]];
//    UIView *snapshot = [cell.avatarImageView snapshotViewAfterScreenUpdates:YES];
    UIImageView *snapshot = [[UIImageView alloc] initWithImage:cell.avatarImageView.image];
    snapshot.frame = [containerView convertRect:cell.avatarImageView.frame fromView:cell.avatarImageView.superview];
    cell.avatarImageView.hidden = YES;    
    //初始化toViewController
    detailVC.view.frame = [transitionContext finalFrameForViewController:detailVC];
    detailVC.view.alpha = 0.0;
    detailVC.avatarImageView.hidden = YES;
    [containerView addSubview:detailVC.view];
    [containerView addSubview:snapshot];
    //动画
    [UIView animateWithDuration:0.3 animations:^{
        detailVC.view.alpha = 1.0;
        CGRect frame = [containerView convertRect:detailVC.avatarImageView.frame fromView:detailVC.view];
        snapshot.frame = frame;
    } completion:^(BOOL finished) {
        detailVC.avatarImageView.hidden = NO;
        cell.avatarImageView.hidden = NO;
        [snapshot removeFromSuperview];
        //声明过渡结束
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
