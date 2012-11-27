//
//  UICustomHTMLEditor.m
//

#import "RTRichEditor.h"

@implementation RTRichEditor


-(id) initWithCoder:(NSCoder *)aDecoder
{
    if(self=[super initWithCoder:aDecoder])
    {
        self.backgroundColor = [UIColor blueColor];

        int width = 32, height = 32;

        int x = self.frame.size.width;

        int y = self.frame.size.height;


        CGRect frame = CGRectMake((x - width) / 2, (y - height) / 2, width, height);

        waiting = [[UIActivityIndicatorView alloc] initWithFrame:frame];
        waiting.hidesWhenStopped=true;
        waiting.activityIndicatorViewStyle=UIActivityIndicatorViewStyleWhiteLarge;
        [self addSubview:waiting];
        
        //[self performSelectorInBackground:@selector(load:) withObject:@""];
    }
    return self;
}

-(void) load:(NSString *)strServerUrl{
    //实例化OC与JS之间通信桥梁
    jsBridge = [TGJSBridge jsBridgeWithDelegate:self];
    self.delegate = jsBridge;
    
    NSString *strKindEditorPath = strServerUrl;
    //本地HTML编辑器路径
    //NSString *strKindEditorPath= [[NSBundle mainBundle] pathForResource:@"RichEditor" ofType:@"html" inDirectory:@"KindEditor/"];

    
    strKindEditorPath= [strKindEditorPath stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //strServerUrl = [strServerUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:strKindEditorPath];
    NSURLRequest * request=[NSURLRequest requestWithURL:url];
    [self loadRequest:request];
}

//----------------------------------webHTMLEditor----------------------------------
-(void)webViewDidStartLoad:(UIWebView *)webView
{
    [waiting startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%@",webView.request.URL.description);
    [waiting stopAnimating];
    
    [jsBridge postNotificationName:@"SetWebHTMLEditorContent" userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"",@"HTMLContent", nil] toWebView:self];
        

}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error;
{
    NSLog(@"%@",error.description);
}
//TGJSBridge delegate
-(void)jsBridge:(TGJSBridge *)bridge didReceivedNotificationName:(NSString *)name userInfo:(NSDictionary *)userInfo fromWebView:(UIWebView *)webview
{
    if ([name isEqualToString:@"GetWebHTMLEditorContent"]) {
    //NSLog(@"%@",[userInfo objectForKey:@"HTMLContent"]);
        if (self.EditorDelegate && [self.EditorDelegate respondsToSelector:@selector(GetHTMLContent:)]) {
                [self.EditorDelegate GetHTMLContent:[userInfo objectForKey:@"HTMLContent"]];
        }
    }
    
}


//提供接口函数以供外部使用 GET SET
//Set
-(void)SetContent:(NSString *)strHTMLContent
{
    
    [jsBridge postNotificationName:@"SetWebHTMLEditorContent" userInfo:[NSDictionary dictionaryWithObjectsAndKeys:strHTMLContent,@"HTMLContent", nil] toWebView:self];
}
-(void)SetVideoContent:(NSString *)src
{
    NSString *strHTML =[NSString stringWithFormat:@"<embed src=\"%@\" width=\"80\" height=\"80\" autostart=\"false\" loop=\"true\" />",src];
    [self SetContent:strHTML];
}
-(void)SetAudioContent:(NSString *)src
{
    NSString *strHTML =[NSString stringWithFormat:@"<embed src=\"%@\" width=\"80\" height=\"80\" autostart=\"false\" loop=\"true\" />",src];
    [self SetContent:strHTML];
}
-(void)SetImageContent:(NSString *)src
{
    NSString *strHTML =[NSString stringWithFormat:@"<embed src=\"%@\" width=\"80\" height=\"80\" autostart=\"false\" loop=\"true\" />",src];
    [self SetContent:strHTML];
}
//Get
-(void)GetContent
{
    [jsBridge postNotificationName:@"GetWebHTMLEditorContent" userInfo:[NSDictionary dictionaryWithObjectsAndKeys:@"click by uibutton",@"HTMLContent", nil] toWebView:self];
}


@end
