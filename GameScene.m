//
//  MyScene.m
//  Bubble Baller
//
//  Created by Brandon Houghton on 10/26/13.
//  Copyright (c) 2013 Big Head Apps. All rights reserved.
//

#import "GameScene.h"
#import "MenuScene.h"
//#import "SimpleAudioEngine.h"
#define kScoreHudName @"scoreHud"


@implementation GameScene{
    SKSpriteNode *ball;
    SKSpriteNode *btnLeft;
    SKSpriteNode *btnRight;
    SKLabelNode *scoreLabel;
    float scoreNum;
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
        //Modify gravity values, defaults to 0.0, -9.8
        self.physicsWorld.gravity = CGVectorMake(0.0,-2.0);
        
        
        //Should accelerat along the x-axis, leaving -2.0 as the default y-axis.
        self.physicsWorld.gravity = CGVectorMake(_motionManager.accelerometerData.acceleration.x, -2.0);
        
        
        //Add background
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"Default"];
        background.position = CGPointMake(size.width/2, size.height/2);
        background.name = @"background";
        [self addChild:background];
        
        //Adding border box for scene
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        //Add hoop
        SKSpriteNode *hoop = [SKSpriteNode spriteNodeWithImageNamed:@"Hoop"];
        hoop.name=@"hoop";
        hoop.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:hoop];
        
        //Add Ball
        //ball = [SKSpriteNode spriteNodeWithImageNamed:@"Basketball"];
        ball = [SKSpriteNode spriteNodeWithImageNamed:@"Default-Ball"];

        ball.name = @"ball";
        ball.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:ball.size.width/2];
        ball.physicsBody.dynamic = YES;
        ball.position = CGPointMake(size.width/2, 0);
        ball.physicsBody.density = 1.0;
        ball.physicsBody.friction = 0.6;
        ball.physicsBody.restitution = 0.4;
        [self addChild:ball];
        
        //Add hoop
        SKSpriteNode *hoopFront = [SKSpriteNode spriteNodeWithImageNamed:@"HoopFront"];
        hoopFront.name=@"hoopFront";
        hoopFront.position = CGPointMake(size.width/2, size.height/2-46);
        [self addChild:hoopFront];
        
        //Left Hoop Top Limit
        SKSpriteNode *hoopLimitLeft = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(5, 5)];
        hoopLimitLeft.position = CGPointMake(size.width/2-35, size.height/2-15);
        hoopLimitLeft.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5];
        hoopLimitLeft.physicsBody.dynamic = NO;
        hoopLimitLeft.name = @"hoopLeft";
        [self addChild:hoopLimitLeft];
        
        //Right Hoop Top Limit
        SKSpriteNode *hoopLimitRight = [SKSpriteNode spriteNodeWithColor:[SKColor yellowColor] size:CGSizeMake(5, 5)];
        hoopLimitRight.position = CGPointMake(size.width/2+35, size.height/2-15);
        hoopLimitRight.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5];
        hoopLimitRight.physicsBody.dynamic = NO;
        [self addChild:hoopLimitRight];
        
        //Second call for bubbles to have in front of elements
        [self addChild:[self loadEmitterNode:@"Bubbles"]];
        
        //Add Pause Button
        SKSpriteNode *btnPause = [SKSpriteNode spriteNodeWithImageNamed:@"btnPause.png"];
        btnPause.position = CGPointMake(20, size.height-20);
        btnPause.size = CGSizeMake(30, 30);
        btnPause.name = @"btnPause";
        [self addChild:btnPause];
        
        //Accelerometer
        self.motionManager = [[CMMotionManager alloc] init];
        self.motionManager.accelerometerUpdateInterval = .2;
        
        [self.motionManager startAccelerometerUpdatesToQueue:[NSOperationQueue currentQueue]
                                                 withHandler:^(CMAccelerometerData  *accelerometerData, NSError *error) {
                                                     [self outputAccelertionData:accelerometerData.acceleration];
                                                     if(error)
                                                     {
                                                         NSLog(@"%@", error);
                                                     }
                                                 }];
        
        [self setupHud];
                //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"TinySeal.caf" loop:YES];
        
    }
    return self;
}

//Check all touches events on scene here
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    /* Called when a touch begins */
    
    //check if they touched our Restart Label
    for (UITouch *touch in touches) {
        //determines position of touch
        CGPoint pos = [touch locationInView: [UIApplication sharedApplication].keyWindow];
        SKNode *n = [self nodeAtPoint:[touch locationInNode:self]];
        if (n != self && [n.name isEqual: @"btnPause"]) {
            [self menuScene];
        } else {            
            if (pos.x < self.size.width/2) {
                [ball.physicsBody applyImpulse:CGVectorMake(20, arc4random()%50)];
            } else {
                [ball.physicsBody applyImpulse:CGVectorMake(-20, arc4random()%50)];
              }
            }
        }
    }


//Scoring
-(void)setupHud {
    
    scoreNum = 0;
    
    scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Courier"];
    
    scoreLabel.name = kScoreHudName;
    scoreLabel.fontSize = 15;

    scoreLabel.fontColor = [SKColor greenColor];
    scoreLabel.text = [NSString stringWithFormat:@"Score: %04u", 0];

    scoreLabel.position = CGPointMake(self.size.width/2, self.size.height - (20 + scoreLabel.frame.size.height/2));
    
    [self addChild:scoreLabel];
}

//Display menu seen
-(void)menuScene{
    MenuScene *menuScene = [[MenuScene alloc] initWithSize:self.size];
    [self.view presentScene:menuScene transition:[SKTransition fadeWithDuration:0.5]];
}


//Display particle generator for bubbles
- (SKEmitterNode *)loadEmitterNode:(NSString *)emitterFileName
{
    NSString *emitterPath = [[NSBundle mainBundle] pathForResource:emitterFileName ofType:@"sks"];
    SKEmitterNode *emitterNode = [NSKeyedUnarchiver unarchiveObjectWithFile:emitterPath];
    
    emitterNode.particlePosition = CGPointMake(self.size.width/2.0, 0);
    
    return emitterNode;
}

-(void)outputAccelertionData:(CMAcceleration)acceleration
{
    currentMaxAccelX = 0;
    currentMaxAccelY = 0;
    
    if(fabs(acceleration.x) > fabs(currentMaxAccelX))
    {
        currentMaxAccelX = acceleration.x;
    }
    if(fabs(acceleration.y) > fabs(currentMaxAccelY))
    {
        currentMaxAccelY = acceleration.y;
    }
}

-(void)update:(CFTimeInterval)currentTime {
    
    float newX = 0;
    
    if(currentMaxAccelX > 0.05){
        newX = currentMaxAccelX;
    }
    else if(currentMaxAccelX < -0.05){
        newX = currentMaxAccelX;
    }
    else{
        newX = currentMaxAccelX;
    }
    
    //ball.position = CGPointMake(newX, newY);
    
    self.physicsWorld.gravity = CGVectorMake(newX,-2.0);
    
}

-(void)updateScore{
    
    scoreNum = scoreNum + 10;
    
    scoreLabel.text = [NSString stringWithFormat:@"Score: %f", scoreNum];
}

@end
