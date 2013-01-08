//
//  SZRichTextEditorViewController.m
//  SZRichTextEditor
//
//  Created by Zongxuan Su on 13-1-8.
//
//

#import "SZRichTextEditorViewController.h"

@interface SZRichTextEditorViewController ()

@end

@implementation SZRichTextEditorViewController

- (void)loadView
{
    editorView = [[SZRichTextEditorView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view = editorView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
