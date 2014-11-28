//
//  Aquarium.m
//  Milvenan Graphics Project
//
//  Created by Wind on 11/26/14.
//  Copyright (c) 2014 Ryan Milvenan. All rights reserved.
//

#import "Aquarium.h"
#import "Sub.h"

@implementation Aquarium {
    Sub *_sub;
}

- (instancetype)initWithShader:(Shader *)shader {
    if (self = [super initWithName:"Aquarium" shader:shader vertices:nil vertexCount:0]) {
        _sub = [[Sub alloc]initWithShader:shader];
        [self.children addObject:_sub];
        
        self.position = GLKVector3Make(0, -1, -5);
    }
    return self;
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    for (Node *child in self.children) {
        [child updateWithDelta:dt];
    }
}

@end
