//
//  ERViewController.m
//  ERComponent
//
//  Created by jialianghappy1314@163.com on 10/09/2017.
//  Copyright (c) 2017 jialianghappy1314@163.com. All rights reserved.
//

#import "ERViewController.h"
#import "Base.h"
#import "ERCirclePicView.h"
#import "UIImageView+Extension.h"
@interface CircleImageModel:NSObject<ERCircleModelProtocol>

@end


@implementation CircleImageModel
@synthesize ERImgURL;
@synthesize clickBlock;

@end

@interface ERViewController ()

@end

@implementation ERViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        CircleImageModel *imageModel = [[CircleImageModel alloc]init];
        if (i==0) {
               imageModel.ERImgURL = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507700997644&di=3955e38eace469492190cb2f0533795c&imgtype=0&src=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F17%2F66%2F84%2F01c58PIC6uk_1024.jpg"];
        }else{
            imageModel.ERImgURL = [NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507700997645&di=0e26f6fff2bddfdbbd68cef8e148bc77&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F12%2F01%2F38%2F01bOOOPIC1a_1024.jpg"];
        }
        
        __weak typeof(imageModel) weakSelf = imageModel;
        imageModel.clickBlock = ^{
            NSLog(@"点击了%@",weakSelf.ERImgURL);
        };
        
        [imageArray addObject:imageModel];
    }

    ERCirclePicView *picView = [ERCirclePicView initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200) PicModels:imageArray LoadImageBlock:^(UIImageView *imageView, NSURL *url) {
        [imageView setURLImageWithURL:url placeHoldImage:nil isCircle:NO];
    }];
    
    [self.view addSubview:picView];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
