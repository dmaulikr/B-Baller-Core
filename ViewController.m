//
//  ViewController.m
//  Bubble Baller
//
//  Created by Brandon Houghton on 10/26/13.
//  Copyright (c) 2013 Big Head Apps. All rights reserved.
//

#import "ViewController.h"
#import "MenuScene.h"

@implementation ViewController{
    SKSpriteNode *ball;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Configure the view.
    SKView * skView = (SKView *)self.view;
    
    // Create and configure the scene.
    SKScene * scene = [MenuScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

//Remove status bar from top
-(BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
