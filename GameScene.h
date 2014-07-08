//
//  GameScene.h
//  Bubble Baller
//

//  Copyright (c) 2013 Big Head Apps. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <CoreMotion/CoreMotion.h>

@interface GameScene : SKScene <UIAccelerometerDelegate>{
    double currentMaxAccelX;
    double currentMaxAccelY;
    CGFloat screenHeight;
    CGFloat screenWidth;
}
@property (strong, nonatomic) CMMotionManager *motionManager;

@end
