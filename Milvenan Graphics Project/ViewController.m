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
#import "Triangle.h"

@interface ViewController ()

@end


@implementation ViewController {
    Shader *_shader;
    Triangle *_triangle;
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
    
    GLKMatrix4 viewMatrix = GLKMatrix4MakeTranslation(0, -1, -5);
    [_triangle renderWithParentModelViewMatrix:viewMatrix];
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
    _triangle = [[Triangle alloc]initWithShader:_shader];
    _shader.projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(85.0), self.view.bounds.size.width/self.view.bounds.size.height, 1, 150);
}

- (void)update{
    [_triangle updateWithDelta:self.timeSinceLastUpdate];
}

@end
