//
//  ViewController.m
//  HSCircularProgressIndicator
//
//  Created by huashan on 16/7/26.
//  Copyright © 2016年 LiHuashan. All rights reserved.
//

#import "ViewController.h"
#import "HSCircularProgressIndicator.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/SDImageCache.h>

@interface ViewController () {
    
    UIImageView *_imageView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 50, self.view.frame.size.width - 2 * 5, 280)];
    [self.view addSubview:_imageView];
    _imageView.image = [UIImage imageNamed:@"placeholderImage"];
    
    UIButton *downloadImageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:downloadImageButton];
    downloadImageButton.backgroundColor = [UIColor blueColor];
    downloadImageButton.frame = CGRectMake(15, CGRectGetMaxY(_imageView.frame) + 50, self.view.frame.size.width - 2 * 15, 60);
    [downloadImageButton setTitle:@"下载图片" forState:UIControlStateNormal];
    [downloadImageButton addTarget:self action:@selector(downloadImageButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *clearImageCacheButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.view addSubview:clearImageCacheButton];
    clearImageCacheButton.backgroundColor = [UIColor blueColor];
    clearImageCacheButton.frame = CGRectMake(15, CGRectGetMaxY(downloadImageButton.frame) + 10, self.view.frame.size.width - 2 * 15, 60);
    [clearImageCacheButton setTitle:@"清除缓存" forState:UIControlStateNormal];
    [clearImageCacheButton addTarget:self action:@selector(clearImageCacheButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    HSCircularProgressIndicator *circularProgressIndicator = [[HSCircularProgressIndicator alloc] initWithFrame:_imageView.bounds];
    [_imageView addSubview:circularProgressIndicator];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)downloadImageButtonDidClick:(UIButton *)sender {
    
    HSCircularProgressIndicator *circularProgressIndicator = _imageView.subviews[0];
    
    [_imageView sd_setImageWithPreviousCachedImageWithURL:[NSURL URLWithString:[@"http://d.hiphotos.baidu.com/zhidao/pic/item/3b87e950352ac65c1b6a0042f9f2b21193138a97.jpg" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]] placeholderImage:[UIImage imageNamed:@"placeholderImage"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
        circularProgressIndicator.progress = (CGFloat)receivedSize / (CGFloat)expectedSize;
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
        [circularProgressIndicator revealAnimation];
    }];
}

- (void)clearImageCacheButtonDidClick:(UIButton *)sender {
    
    NSUInteger cacheSize = [SDImageCache sharedImageCache].getSize;
    NSString *alertString = cacheSize > 52428.8 ? [NSString stringWithFormat:@"本次清除内存%.1fM", cacheSize / 1024.0 / 1024.0] : [NSString stringWithFormat:@"本次清除内存%.1fK", cacheSize / 1024.0];
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"缓存清除" message:alertString preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:nil];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:YES completion:nil];
    
    HSCircularProgressIndicator *circularProgressIndicator = _imageView.subviews[0];
    [circularProgressIndicator reset];
}

@end
