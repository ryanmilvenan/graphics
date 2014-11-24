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

@interface ViewController ()

@end




@implementation ViewController {
    GLuint _vertexBuffer;
    GLuint _indexBuffer;
    Shader *_shader;
    GLsizei _indexCount;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    GLKView *view = (GLKView *)self.view;
    [self setupContext:view];
    [self setupShader];
    [self setupVBOs];
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect {
    glClearColor(0, 104.0/255.0, 55.0/255.0, 1.0);
    glClear(GL_COLOR_BUFFER_BIT);
    
    [_shader useProgram];
    
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    
    glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0);
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

- (void)setupShader {
    _shader = [[Shader alloc]initWithVertexShader:@"SimpleVertex" fragmentShader:@"SimpleFragment"];
}


- (void)setupVBOs {
    
    const SceneVertex vertices[] = {
        {{-1, -1, 0}, {1, 1, 1, 1}},
        {{1, -1, 0}, {1, 1, 1, 1}},
        {{0, 0, 0}, {1, 1, 1, 1}},
    };
    
    const GLubyte indices[] = {
        0, 1, 2
    };
    
    _indexCount = sizeof(indices)/sizeof(indices[0]);
    
    glGenBuffers(1, &_vertexBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
    
    glEnableVertexAttribArray(SceneVertexAttribPosition);
    glVertexAttribPointer(SceneVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), (const GLvoid *) offsetof(SceneVertex, Position));
    
    glEnableVertexAttribArray(SceneVertexAttribColor);
    glVertexAttribPointer(SceneVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), (const GLvoid *) offsetof(SceneVertex, Color));
    
    glGenBuffers(1, &_indexBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices, GL_STATIC_DRAW);
}


/************************************
 *                                  *
 *          Helper Functions        *
 *                                  *
 ************************************/


@end
