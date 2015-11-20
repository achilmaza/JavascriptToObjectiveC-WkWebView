//
//  ViewController.h
//  JavascriptToObjectiveC
//
//  Created by Angie Chilmaza on 9/16/15.
//  Copyright (c) 2015 Angie Chilmaza. All rights reserved.
//

#import <JavaScriptCore/JSExport.h>
#import <JavaScriptCore/JSContext.h>
#import <UIKit/UIKit.h>

@import WebKit;

@interface ViewController : UIViewController <WKScriptMessageHandler, WKNavigationDelegate>

@end

