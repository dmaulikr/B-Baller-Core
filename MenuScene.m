//
//  MenuScene.m
//  Bubble Baller
//
//  Created by Brandon Houghton on 11/6/13.
//  Copyright (c) 2013 Big Head Apps. All rights reserved.
//
@import AVFoundation;

#import "MenuScene.h"
#import "GameScene.h"
#import "SettingsScene.h"


@implementation MenuScene{
    GameScene *_scene;
}
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        
        
        //Add background
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"Background"];
        background.position = CGPointMake(size.width/2, size.height/2);
        background.name = @"background";
        [self addChild:background];
        
        //Add bubbles particle generator
        [self addChild:[self loadEmitterNode:@"Bubbles"]];
        
        //Add Play Button
        SKSpriteNode *btnPlay = [SKSpriteNode spriteNodeWithImageNamed:@"btnPlay-Iphone.png"];
        btnPlay.position = CGPointMake(size.width/2, size.height/2+150);
        btnPlay.name = @"btnPlay";
        [self addChild:btnPlay];
        
        //Add Setting Button
        SKSpriteNode *btnSettings = [SKSpriteNode spriteNodeWithImageNamed:@"btnSettings-Iphone.png"];
        btnSettings.position = CGPointMake(size.width/2, size.height/2+90);
        btnSettings.name = @"btnSettings";
        [self addChild:btnSettings];
        
        //Add Exit Button
        SKSpriteNode *btnExit = [SKSpriteNode spriteNodeWithImageNamed:@"btnExit-Iphone.png"];
        btnExit.position = CGPointMake(size.width/2, size.height/2+30);
        btnExit.name = @"btnExit";
        [self addChild:btnExit];
        
    }
    return self;
}

//Check all touches events on scene here
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    //check if they touched our Restart Label
    for (UITouch *touch in touches) {
        SKNode *n = [self nodeAtPoint:[touch locationInNode:self]];
        
        //If play btn touched, return game scene
        if (n != self && [n.name isEqual: @"btnPlay"]) {
            [self gameScene];
            return;
        }
        
        //If settings btn touched, return settings scene
        else if(n != self && [n.name isEqual: @"btnSettings"]){
            [self settingsScene];
            return;
        }
        
        //If Exit btn touched, exit app.
        //NOTE: Not needed.
        else if(n != self && [n.name isEqual: @"btnExit"]){
            [self exitScene];
            return;
        }
    }
}

/* Screen Transitions */

//To Play
-(void)gameScene{
    GameScene * gameScene = [[GameScene alloc] initWithSize:self.size];
    [self.view presentScene:gameScene transition:[SKTransition fadeWithDuration:1.0]];
}
//To Settings
-(void)settingsScene{
    SettingsScene * settingScene = [[SettingsScene alloc] initWithSize:self.size];
    [self.view presentScene:settingScene transition:[SKTransition doorsOpenHorizontalWithDuration:1.0]];
}
//Exit game
-(void)exitScene{
    //Exit game
}
- (SKEmitterNode *)loadEmitterNode:(NSString *)emitterFileName
{
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:emitterFileName ofType:@"sks"];
    SKEmitterNode *emitterNode = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    
    //do some view specific tweaks
    emitterNode.particlePosition = CGPointMake(self.size.width/2.0, 0);
    //emitterNode.particlePositionRange = CGVectorMake(self.size.width+100, self.size.height);
    
    return emitterNode;
}
@end
