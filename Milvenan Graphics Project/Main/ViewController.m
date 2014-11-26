//
//  ViewController.m
//  Milvenan Graphics Project
//
//  Created by Wind on 11/20/14.
//  Copyright (c) 2014 Ryan Milvenan. All rights reserved.
//

#import "ViewController.h"
#import "Shader.h"
#import "SceneVertex.h"
#import "Cube.h"
#import "Propeller.h"

@interface ViewController ()

@end


@implementation ViewController {
    Shader *_shader;
    Cube *_cube;
    Propeller *_prop;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *view = (GLKView *)self.view;
    [self setupContext:view];
    [self setupScene];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    glEnable(GL_CULL_FACE);
    glEnable(GL_BLEND);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
    
    GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(0, 0, -5);
    viewMatrix = GLKMatrix4Rotate(viewMatrix, GLKMathDegreesToRadians(20), 1, 0, 0);
    [_cube renderWithParentModelViewMatrix:viewMatrix];
    //[_prop renderWithParentModelViewMatrix:viewMatrix];
}

/************************************
 *                                  *
 *      Configuration Functions     *
 *                                  *
 ************************************/

- (void)setupContext:(GLKView *)view {
    EAGLContext* context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    view.context = context;
    
    [EAGLContext setCurrentContext:view.context];
    
   
}

- (void)setupScene {
    _shader = [[Shader alloc]initWithVertexShader:@"SimpleVertex" fragmentShader:@"SimpleFragment"];
    _cube = [[Cube alloc]initWithShader:_shader];
    //_cube.position = GLKVector3Make(0, 0, -10);
    //_prop = [[Propeller alloc] initWithShader:_shader];
    //_prop.position = GLKVector3Make(0, 0, -7.9);
    _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width/self.view.bounds.size.height, 1, 150);
}

- (void)update{
    [_cube updateWithDelta:self.timeSinceLastUpdate];
    [_prop updateWithDelta:self.timeSinceLastUpdate];
}

@end
