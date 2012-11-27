//
//  TGJSBridge.h
//  TGJSBridge
//
//  Created by Chao Shen on 12-3-1.
//  Copyright (c) 2012年 Hangzhou Jiuyan Technology Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TGJSBridge;

//委托
@protocol TGJSBridgeDelegate <UIWebViewDelegate>

-(void)jsBridge:(TGJSBridge *)bridge 
didReceivedNotificationName:(NSString*)name    
        userInfo:(NSDictionary*)userInfo 
     fromWebView:(UIWebView*)webview;

@end

//接口
@interface TGJSBridge : NSObject <UIWebViewDelegate>
{
    NSMutableDictionary *_infoList;
}

@property (nonatomic, assign) IBOutlet id <TGJSBridgeDelegate> delegate;

+ (id)jsBridgeWithDelegate:(id <TGJSBridgeDelegate>)delegate;

- (void)postNotificationName:(NSString *)name
                    userInfo:(NSDictionary*)userInfo
                   toWebView:(UIWebView *)webView;


- (BOOL)isReadyForWebView:(UIWebView*)webView;
- (void)dispatchNotification:(NSString*)notificationString 
                 fromWebView:(UIWebView*)webView;
- (NSDictionary*)fetchNotificationWithId:(NSString*)notificationId 
                             fromWebView:(UIWebView*)webView;
- (NSMutableArray*)notificationQueueForWebView:(UIWebView*)webView;
- (void)triggerJSEvent:(NSString *)name
              userInfo:(NSDictionary*)userInfo
             toWebView:(UIWebView *)webView;


@end
