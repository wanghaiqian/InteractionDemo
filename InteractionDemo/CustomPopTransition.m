//
//  CustomPopTransition.m
//  InteractionDemo
//
//  Created by 王海堑 on 2017/2/7.
//  Copyright © 2017年 DSHD network technology co.,. All rights reserved.
//

#import "CustomPopTransition.h"
#import "HomeViewController.h"
#import "DetailViewController.h"
#import "AvatarCollectionViewCell.h"

@implementation CustomPopTransition

#pragma mark - UIViewControllerAnimatedTransitioning
- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 0.3;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    DetailViewController *detailVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    HomeViewController *homeVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    UIImageView *snapshot = [[UIImageView alloc] initWithImage:detailVC.avatarImageView.image];
    snapshot.frame = [containerView convertRect:detailVC.avatarImageView.frame fromView:detailVC.view];
    detailVC.avatarImageView.hidden = YES;
    
    homeVC.view.frame = [transitionContext finalFrameForViewController:homeVC];
    homeVC.view.alpha = 0.0;
    AvatarCollectionViewCell *cell = (AvatarCollectionViewCell *)[homeVC.customCollectionView cellForItemAtIndexPath:[[homeVC.customCollectionView indexPathsForSelectedItems] firstObject]];
    cell.avatarImageView.hidden = YES;
    [containerView addSubview:homeVC.view];
    [containerView addSubview:snapshot];
    
    [UIView animateWithDuration:0.3 animations:^{
        homeVC.view.alpha = 1.0;
        CGRect frame = [containerView convertRect:cell.avatarImageView.frame fromView:cell.avatarImageView.superview];
        snapshot.frame = frame;
    } completion:^(BOOL finished) {
        cell.avatarImageView.hidden = NO;
        detailVC.avatarImageView.hidden = NO;
        [snapshot removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
