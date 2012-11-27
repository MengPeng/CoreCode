//
//  RTRichEditor.h
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TGJSBridge.h"

//获取文本内容代理，使用者需要实现此代理
@protocol RTRichEditorDelegate <NSObject>

- (void)GetHTMLContent:(NSString *)content;

@end

@interface RTRichEditor : UIWebView<TGJSBridgeDelegate>
{
    TGJSBridge *jsBridge;
    UIActivityIndicatorView *waiting;
}

@property (assign,nonatomic)  id<RTRichEditorDelegate> EditorDelegate;

-(void) load:(NSString *)strServerUrl;

//在代理中获取内容
-(void)GetContent;
-(void)SetContent:(NSString *)strHTMLContent;
-(void)SetVideoContent:(NSString *)src;
-(void)SetAudioContent:(NSString *)src;
-(void)SetImageContent:(NSString *)src;
@end
