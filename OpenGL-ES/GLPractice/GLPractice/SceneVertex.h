//
//  SceneVertice.h
//  GLPractice
//
//  Created by birneysky on 2019/7/24.
//  Copyright © 2019 Grocery. All rights reserved.
//

#ifndef SceneVertice_h
#define SceneVertice_h
#import <GLKit/GLKMathTypes.h>


/**
 带有位置坐标的顶点
 vertex with position coordinates
 */
typedef struct {
    GLKVector3 postionCoords; /// x,y,z
} Vertex;

/**
 带有纹理坐标的顶点
 vertex with texture coordinates
 */
typedef struct {
    GLKVector3 positionCoords;
    GLKVector2 textureCoords;
} TextureVertex;


/**
 带有法线的顶点
 vertex with normal
 */
typedef struct {
    GLKVector3 position;
    GLKVector3 normal;
} NormalVertex;


/**
 each vertex of a triangle has a normal
 */
typedef struct {
    NormalVertex vertices[3];
} NormalTriangle;


/// retrun the length of vector
GLfloat AVector3Length(const GLKVector3 aVector);

/// return a unit vector with the same direction as aVector
GLKVector3 AVector3Normalize(const GLKVector3 aVector);

/// return the cross product aVector X bVector
GLKVector3 AVector3CrossProduct(const GLKVector3 aVector, const GLKVector3 bVector);

/// return a unit vector in the same direction as the cross product of aVector and bVector
GLKVector3 AVector3UnitNormal(const GLKVector3 aVector, const GLKVector3 bVector);


NormalTriangle normalTriangleMake(const NormalVertex vertextA,
                                  const NormalVertex vertextB,
                                  const NormalVertex vertextC);

#endif /* SceneVertice_h */
