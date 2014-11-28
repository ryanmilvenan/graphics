//
//  Propeller.m
//  Milvenan Graphics Project
//
//  Created by Wind on 11/25/14.
//  Copyright (c) 2014 Ryan Milvenan. All rights reserved.
//

#import "Propeller.h"

const SceneVertex prop_vertices[] = {
    //Top
    {{0, 0, 0}, {1, 0, 0, 1}, {0, 0}}, //0
    {{-.25, .5, 0}, {0, 1, 0, 1}, {0, 0}},//1
    {{.25, .5, 0}, {0, 0, 1, 1}, {0, 0}},//2
    
    //Right
    {{0, 0, 0}, {1, 0, 0, 1}, {0, 0}},//0
    {{.5, .25, 0}, {0, 1, 0, 1}, {0, 0}},//3
    {{.5, -.25, 0}, {1, 0, 0, 1}, {0, 0}},//4
    
    
    //Bottom
    {{0, 0, 0}, {1, 0, 0, 1}, {0, 0}},
    {{.25, -.5, 0}, {0, 0, 1, 1}, {0, 0}},//5
    {{-.25, -.5, 0},{1, 0, 0, 1}, {0, 0}},//6
    
    //Left
    {{0, 0, 0}, {1, 0, 0, 1}, {0, 0}},
    {{-.5, -.25, 0}, {0, 0, 1, 1}, {0, 0}},//8
    {{-.5, .25, 0},{0, 1, 0, 1}, {0, 0}},//7
    
};
    

@implementation Propeller

- (instancetype)initWithShader:(Shader *)shader {
    if (self = [super initWithName:"propeller" shader:shader vertices:(SceneVertex *)prop_vertices vertexCount:sizeof(prop_vertices)/sizeof(prop_vertices[0])]) {
        self.position = GLKVector3Make(0, -1.5, 0);
        self.rotateX = GLKMathDegreesToRadians(-90);
        self.scale = .5;
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {    
    self.rotateZ += M_PI * dt;
}

@end
