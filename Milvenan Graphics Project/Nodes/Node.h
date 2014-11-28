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

@interface Node : NSObject

@property (nonatomic, strong) Shader *shader;
@property (nonatomic, assign) GLKVector3 position;
@property (nonatomic) float rotateX;
@property (nonatomic) float rotateY;
@property (nonatomic) float rotateZ;
@property (nonatomic) float scale;
@property (nonatomic) GLuint texture;

@property (nonatomic, strong) NSMutableArray *children;


- (instancetype)initWithName:(char *)name shader:(Shader *)shader vertices:(SceneVertex *)vertices vertexCount:(unsigned int)vertexCount;
- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix;
- (GLKMatrix4)modelMatrix;
- (void)updateWithDelta:(NSTimeInterval)dt;
- (void)loadTexture:(NSString *)filename;

@end