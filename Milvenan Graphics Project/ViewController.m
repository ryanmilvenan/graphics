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
    
    [_triangle render];
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
}



@end
