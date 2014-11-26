//
//  Shader.h
//  Milvenan Graphics Project
//
//  Created by Wind on 11/24/14.
//  Copyright (c) 2014 Ryan Milvenan. All rights reserved.
//

#import <Foundation/Foundation.h>

@import GLKit;
@interface Shader : NSObject

@property (nonatomic, assign) GLuint program;
@property (nonatomic, assign) GLKMatrix4 modelViewMatrix;
@property (nonatomic, assign) GLKMatrix4 projectionMatrix;
@property (assign) GLuint texture;

- (id)initWithVertexShader:(NSString *)vertexShader
            fragmentShader:(NSString *)fragmentShader;

- (void)useProgram;

@end