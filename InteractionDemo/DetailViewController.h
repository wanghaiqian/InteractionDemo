//
//  DetailViewController.h
//  InteractionDemo
//
//  Created by 王海堑 on 2017/2/7.
//  Copyright © 2017年 DSHD network technology co.,. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (nonatomic, strong) UIImageView *avatarImageView;

@property (nonatomic, strong) UILabel *contentLabel;

- (instancetype)initWithImageName:(NSString *)imageName content:(NSString *)content;

@end
