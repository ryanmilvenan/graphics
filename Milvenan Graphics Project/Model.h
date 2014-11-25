//
//  Model.h
//  Milvenan Graphics Project
//
//  Created by Wind on 11/24/14.
//  Copyright (c) 2014 Ryan Milvenan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SceneVertex.h"

@import GLKit;
@import OpenGLES;
@class Shader;

@interface Model : NSObject

@property (nonatomic, strong) Shader *shader;

- (instancetype)initWithName:(char *)name shader:(Shader *)shader vertices:(SceneVertex *)vertices vertexCount:(unsigned int)vertexCount indices:(GLubyte *)indices indexCount:(unsigned int)indexCount;
- (void)render;

@end
