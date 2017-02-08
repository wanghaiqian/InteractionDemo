//
//  AvatarCollectionViewCell.m
//  InteractionDemo
//
//  Created by 王海堑 on 2017/2/7.
//  Copyright © 2017年 DSHD network technology co.,. All rights reserved.
//

#import "AvatarCollectionViewCell.h"

@implementation AvatarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height - 35)];
        [self addSubview:self.avatarImageView];
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height - 25, frame.size.width, 15)];
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        self.nameLabel.textColor = [UIColor grayColor];
        self.nameLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:self.nameLabel];
    }
    return self;
}

@end
