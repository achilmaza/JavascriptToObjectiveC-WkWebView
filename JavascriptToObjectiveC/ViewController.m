//
//  ViewController.m
//  JavascriptToObjectiveC
//
//  Created by Angie Chilmaza on 9/16/15.
//  Copyright (c) 2015 Angie Chilmaza. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) JSContext * jsContext;
@property (nonatomic, strong) WKWebView * webView;
@property (nonatomic, strong) WKWebViewConfiguration * webViewConfig;
@property (weak, nonatomic) IBOutlet UIView *parentWebView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * indexFile = [[NSBundle mainBundle] pathForResource:@"index" ofType:@"html" inDirectory:@"www"];
    
    self.webView= [[WKWebView alloc] initWithFrame:self.parentWebView.frame configuration:self.webViewConfig];
    self.webView.frame = self.parentWebView.frame;
    self.webView.navigationDelegate = self;
    [self.parentWebView addSubview:self.webView];
    
    
    NSURL * url = [NSURL fileURLWithPath:indexFile];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
}

-(WKWebViewConfiguration*) webViewConfig {
    
    if(!_webViewConfig){
        
        _webViewConfig = [[WKWebViewConfiguration alloc] init];
    
        WKUserContentController * userController = [[WKUserContentController alloc] init];
        
        NSString* js =[NSString stringWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"notifications" ofType:@"js" ] encoding:NSUTF8StringEncoding error:nil];
    
        WKUserScript * userScript = [[WKUserScript alloc] initWithSource:js
                                                       injectionTime:WKUserScriptInjectionTimeAtDocumentEnd
                                                    forMainFrameOnly:NO];
    
        [userController addUserScript:userScript];
        [userController addScriptMessageHandler:self name:@"buttonClicked"];
    
        _webViewConfig.userContentController = userController;
    }
    
    return _webViewConfig;
}

-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    
    
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    NSLog(@"webView error = %@ \n", error.description);
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    
    
}

-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    NSLog(@"message.name = %@ \n", message.name);
    NSLog(@"message.body = %@ \n", message.body);
    
    if([message.name isEqualToString:@"buttonClicked"]){
        
        NSLog(@"Button has been clicked\n");
    }
    
}

- (IBAction)alertNotification:(id)sender {

    [self.webView evaluateJavaScript:@"displayNotification();"
                   completionHandler:^(id response, NSError * error) {
        NSLog(@"Javascript executed \n");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
