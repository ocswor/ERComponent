//
//  ERViewController.m
//  ERComponent
//
//  Created by jialianghappy1314@163.com on 10/09/2017.
//  Copyright (c) 2017 jialianghappy1314@163.com. All rights reserved.
//

#import "ERViewController.h"
#import "ERCirclePicView.h"
#import "UIImageView+Extension.h"
#import "NSString+ERDownloader.h"
#import "ERDownLoaderTool.h"


@interface CircleImageModel:NSObject<ERCircleModelProtocol>

@end


@implementation CircleImageModel
@synthesize ERImgURL;
@synthesize clickBlock;

@end

@interface ERViewController ()
@property (weak, nonatomic) IBOutlet UILabel *progressLabel;
@property(nonatomic,strong)ERDownLoaderTool *tool;
@end

@implementation ERViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
  
     NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
     NSLog(@"%@",[paths firstObject]);
    
}


-(ERDownLoaderTool *)tool{
    if (!_tool) {
        _tool = [[ERDownLoaderTool alloc] init];
    }
    return _tool;
}

- (IBAction)testStartDownload:(id)sender {
    
    
    
    
    if (self.tool.state == ERDownLoaderStateDowning) {
         [self.tool pause];
    }else{
      
        __weak UILabel *progressLabel = _progressLabel;
        [self.tool downloadWithURL:[NSURL URLWithString:@"http://service.stormor.ai/assistant-backend/v2/operation/bluetooth/update/"] toPathDir:nil];
        self.tool.downLoadProgress = ^(float progress){
            NSLog(@"%f",progress);
            progressLabel.text = [NSString stringWithFormat:@"%f",progress];
        };
        self.tool.downLoadStateChange = ^(ERDownLoaderState state) {
            NSLog(@"ERDownLoaderState %lu",(unsigned long)state);
        };
    }

}




-(void)testCircleCarousel{
    NSArray *imageNameArr = @[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507700997644&di=3955e38eace469492190cb2f0533795c&imgtype=0&src=http%3A%2F%2Fpic.qiantucdn.com%2F58pic%2F17%2F66%2F84%2F01c58PIC6uk_1024.jpg",@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1507700997645&di=0e26f6fff2bddfdbbd68cef8e148bc77&imgtype=0&src=http%3A%2F%2Fpic2.ooopic.com%2F12%2F01%2F38%2F01bOOOPIC1a_1024.jpg",@"http://upload-images.jianshu.io/upload_images/195046-9d5e2db9773e0ed1.jpg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",@"http://upload-images.jianshu.io/upload_images/195046-6633cefdb7545c01.JPG?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240",@"http://upload-images.jianshu.io/upload_images/4093530-84f3ff6468f9a09d.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"];
    NSMutableArray *imageArray = [NSMutableArray array];
    for (int i=0; i<5; i++) {
        CircleImageModel *imageModel = [[CircleImageModel alloc]init];
        
        imageModel.ERImgURL = [NSURL URLWithString:imageNameArr[i]];
        
        
        __weak typeof(imageModel) weakSelf = imageModel;
        imageModel.clickBlock = ^{
            NSLog(@"点击了%@",weakSelf.ERImgURL);
        };
        
        [imageArray addObject:imageModel];
    }
    
    ERCirclePicView *picView = [ERCirclePicView initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200) LoadImageBlock:^(UIImageView *imageView, NSURL *url) {
        [imageView setURLImageWithURL:url placeHoldImage:nil isCircle:NO];
    }];
    
    picView.picModels = imageArray;
    [self.view addSubview:picView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
