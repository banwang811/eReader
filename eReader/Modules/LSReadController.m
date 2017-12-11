//
//  LSReadController.m
//  eReader
//
//  Created by banwang on 2017/12/9.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSReadController.h"

@interface LSReadController ()
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end

@implementation LSReadController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://transcoder.baiducontent.com/tc?srd=1&dict=32&h5ad=1&bdenc=1&lid=12007323811518316276&title=%E7%99%BE%E7%82%BC%E6%88%90%E4%BB%99%E6%9C%80%E6%96%B0%E7%AB%A0%E8%8A%82_%E7%99%BE%E7%82%BC%E6%88%90%E4%BB%99%E6%9C%80%E6%96%B0%E7%AB%A0%E8%8A%82%E5%88%97%E8%A1%A8_%E7%AC%94%E8%B6%A3%E9%98%81&nsrc=IlPT2AEptyoA_yixCFOxXnANedT62v3IEROF_ytZ0D7fpE_tf4zkHd2rW88wL8LTUS46sGuCxBt8wWGdWWUe7BUor0dmpKhttps://transcoder.baiducontent.com/tc?srd=1&dict=32&h5ad=1&bdenc=1&lid=12007323811518316276&title=%E7%99%BE%E7%82%BC%E6%88%90%E4%BB%99%E6%9C%80%E6%96%B0%E7%AB%A0%E8%8A%82_%E7%99%BE%E7%82%BC%E6%88%90%E4%BB%99%E6%9C%80%E6%96%B0%E7%AB%A0%E8%8A%82%E5%88%97%E8%A1%A8_%E7%AC%94%E8%B6%A3%E9%98%81&nsrc=IlPT2AEptyoA_yixCFOxXnANedT62v3IEROF_ytZ0D7fpE_tf4zkHd2rW88wL8LTUS46sGuCxBt8wWGdWWUe7BUor0dmpKhttps://transcoder.baiducontent.com/tc?srd=1&dict=32&h5ad=1&bdenc=1&lid=12007323811518316276&title=%E7%99%BE%E7%82%BC%E6%88%90%E4%BB%99%E6%9C%80%E6%96%B0%E7%AB%A0%E8%8A%82_%E7%99%BE%E7%82%BC%E6%88%90%E4%BB%99%E6%9C%80%E6%96%B0%E7%AB%A0%E8%8A%82%E5%88%97%E8%A1%A8_%E7%AC%94%E8%B6%A3%E9%98%81&nsrc=IlPT2AEptyoA_yixCFOxXnANedT62v3IEROF_ytZ0D7fpE_tf4zkHd2rW88wL8LTUS46sGuCxBt8wWGdWWUe7BUor0dmpK"]];
    [self.webview loadRequest:request];
    // Do any additional setup after loading the view from its nib.
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
