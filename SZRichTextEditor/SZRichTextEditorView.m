//
//  SZRichEditView.m
//  SZRichTextEditor
//
//  Created by Zongxuan Su on 13-1-8.
//
//

#import "SZRichTextEditorView.h"
#import <objc/runtime.h> 

@implementation SZRichTextEditorView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSBundle *bundle = [NSBundle mainBundle];
        NSURL *indexFileURL = [bundle URLForResource:@"template" withExtension:@"htm"];
        [self loadRequest:[NSURLRequest requestWithURL:indexFileURL]];
        [self changeWebViewInputAccessoryView];
    }
    return self;
}

- (void)changeWebViewInputAccessoryView
{
    /**
     2   * 找到UIWebBrowserView的对象
     3  */
    UIView *browserView = nil;
    for (UIView *subview in [self.subviews[0] subviews]) {
        if ([NSStringFromClass([subview class]) hasPrefix:@"UIWebBrowserView"]) {
            browserView = subview;
            break;
        }
    }
    // 拷贝 browserView 中的UIWebBrowserViewMinusAccessoryView
    Class newClass = objc_duplicateClass([browserView class], "UIWebBrowserViewMinusAccessoryView", 0);
    
    // 编写自己的实现方法accessoryViewImp
    IMP accessoryViewImp = [self methodForSelector:@selector(inputAccessoryView)];
    
    // 替换系统的inputAccessoryView方法 ，@@: 是type coding ，下面会讲到
    class_replaceMethod(newClass, @selector(inputAccessoryView), accessoryViewImp, "@@:");
    
    //注册类
    objc_registerClassPair(newClass);
    
    //重新设计browserView对象的类
    object_setClass(browserView, newClass);
    
    //载入自己的inputAccessoryView
    [browserView reloadInputViews];
}

- (id)inputAccessoryView {
    [self performSelector:@selector(setValue:forKey:) withObject:[NSNumber numberWithBool:YES] withObject:@"inputViewObeysDOMFocus"];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 0)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}

- (void)dealloc
{
    
}

@end
