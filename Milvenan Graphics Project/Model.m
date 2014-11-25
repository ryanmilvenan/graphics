//
//  Model.m
//  Milvenan Graphics Project
//
//  Created by Wind on 11/24/14.
//  Copyright (c) 2014 Ryan Milvenan. All rights reserved.
//

#import "Model.h"
#import "Shader.h"

@implementation Model {
    char *_name;
    GLuint _vao;
    GLuint _vertexBuffer;
    GLuint _indexBuffer;
    unsigned int _vertexCount;
    unsigned int _indexCount;
    Shader *_shader;
}

- (instancetype)initWithName:(char *)name shader:(Shader *)shader vertices:(SceneVertex *)vertices vertexCount:(unsigned int)vertexCount indices:(GLubyte *)indices indexCount:(unsigned int)indexCount {
    if (self = [super init]) {
        _name = name;
        _vertexCount = vertexCount;
        _indexCount = indexCount;
        _shader = shader;
        self.position = GLKVector3Make(0, 0, 0);
        self.rotateX = 0;
        self.rotateY = 0;
        self.rotateZ = 0;
        self.scale = 1.0;
        
        glGenVertexArraysOES(1, &_vao);
        glBindVertexArrayOES(_vao);
        
        glGenBuffers(1, &_vertexBuffer);
        glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
        glBufferData(GL_ARRAY_BUFFER, vertexCount * sizeof(SceneVertex), vertices, GL_STATIC_DRAW);
        
        glGenBuffers(1, &_indexBuffer);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indexBuffer);
        glBufferData(GL_ELEMENT_ARRAY_BUFFER, indexCount * sizeof(GLubyte), indices, GL_STATIC_DRAW);
        
        glEnableVertexAttribArray(SceneVertexAttribPosition);
        glVertexAttribPointer(SceneVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), (const GLvoid *) offsetof(SceneVertex, Position));
        
        glEnableVertexAttribArray(SceneVertexAttribColor);
        glVertexAttribPointer(SceneVertexAttribColor, 4, GL_FLOAT, GL_FALSE, sizeof(SceneVertex), (const GLvoid *) offsetof(SceneVertex, Color));
        
        glBindVertexArrayOES(0);
        glBindBuffer(GL_ARRAY_BUFFER, 0);
        glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);
        
    }
    return self;
}

- (GLKMatrix4)modelMatrix {
    GLKMatrix4 modelMatrix = GLKMatrix4Identity;
    modelMatrix = GLKMatrix4Translate(modelMatrix, self.position.x, self.position.y, self.position.z);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotateX, 1, 0, 0);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotateY, 0, 1, 0);
    modelMatrix = GLKMatrix4Rotate(modelMatrix, self.rotateZ, 0, 0, 1);
    modelMatrix = GLKMatrix4Scale(modelMatrix, self.scale, self.scale, self.scale);

    return modelMatrix;
}

- (void)renderWithParentModelViewMatrix:(GLKMatrix4)parentModelViewMatrix {
    
    GLKMatrix4 modelViewMatrix = GLKMatrix4Multiply(parentModelViewMatrix, [self modelMatrix]);
    
    _shader.modelViewMatrix = modelViewMatrix;
    [_shader useProgram];
    
    glBindVertexArrayOES(_vao);
    glDrawElements(GL_TRIANGLES, _indexCount, GL_UNSIGNED_BYTE, 0);
    glBindVertexArrayOES(0);
}

- (void)updateWithDelta:(NSTimeInterval)dt {
    
}

@end
