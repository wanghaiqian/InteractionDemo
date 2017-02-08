//
//  HomeViewController.m
//  InteractionDemo
//
//  Created by 王海堑 on 2017/2/7.
//  Copyright © 2017年 DSHD network technology co.,. All rights reserved.
//

#import "HomeViewController.h"
#import "AvatarCollectionViewCell.h"
#import "DetailViewController.h"
#import "CustomPushTransition.h"

@interface HomeViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate>

{
    CGFloat screenWidth;
    CGFloat screenHeight;
}

@property (nonatomic, strong) NSArray *dataArray;

@end

@implementation HomeViewController

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
    self.title = @"Home";
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    screenWidth = [UIScreen mainScreen].bounds.size.width;
    screenHeight = [UIScreen mainScreen].bounds.size.height;
//    self.navigationController.navigationItem.title = @"Home";
    [self initCustomCollectionView];
    [self initData];
}

- (void)initCustomCollectionView{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    self.customCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64, screenWidth, screenHeight - 64) collectionViewLayout:flowLayout];
    self.customCollectionView.alwaysBounceVertical = YES;
    self.customCollectionView.backgroundColor = [UIColor whiteColor];
    self.customCollectionView.dataSource = self;
    self.customCollectionView.delegate = self;
    [self.customCollectionView registerClass:[AvatarCollectionViewCell class] forCellWithReuseIdentifier:@"AvatarCollectionViewCell"];
    [self.view addSubview:self.customCollectionView];
}

- (void)initData{
    self.dataArray = @[@"img1", @"img2", @"img3", @"img4"];
    [self.customCollectionView reloadData];
}

#pragma mark - UINavigationControllerDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC{
    //检查一下是不是自定义的过渡动画的情景
    if (fromVC == self && [toVC isKindOfClass:[DetailViewController class]]) {
        return [[CustomPushTransition alloc] init];
    }else{
        return nil;
    }
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AvatarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AvatarCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.row < self.dataArray.count) {
        cell.avatarImageView.image = [UIImage imageNamed:self.dataArray[indexPath.row]];
        cell.nameLabel.text = self.dataArray[indexPath.row];
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row < self.dataArray.count) {
        NSString *imgName = self.dataArray[indexPath.row];
        DetailViewController *detailVC = [[DetailViewController alloc] initWithImageName:imgName content:imgName];
        [self.navigationController pushViewController:detailVC animated:YES];
    }
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((screenWidth - 30) / 2, (screenWidth - 30) / 2 + 35);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
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
