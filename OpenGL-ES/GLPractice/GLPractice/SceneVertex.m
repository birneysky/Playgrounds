//
//  SceneVertex.m
//  GLPractice
//
//  Created by birneysky on 2019/8/5.
//  Copyright © 2019 Grocery. All rights reserved.
//

#import "SceneVertex.h"
#include <math.h>
#import <GLKit/GLKit.h>

GLfloat AVector3Length(const GLKVector3 aVector) {
    GLfloat length = 0.0f;
    GLfloat lengthSquared =
    (aVector.x * aVector.x) +
    (aVector.y * aVector.y) +
    (aVector.z * aVector.z);
    if (lengthSquared > FLT_EPSILON) {
        length = sqrtf(lengthSquared);
    }
    return length;
}
/// return a unit vector with the same direction as aVector
GLKVector3 AVector3Normalize(const GLKVector3 aVector) {
    const GLfloat length = AVector3Length(aVector);
    float oneOverLength = 0.0f;
    
    if (length > FLT_EPSILON) {
        oneOverLength = 1.0f / length;
    }
    
    GLKVector3 result = {
        aVector.x * oneOverLength,
        aVector.y * oneOverLength,
        aVector.z * oneOverLength
    };
    return result;
}

GLKVector3 AVector3CrossProduct(const GLKVector3 aVector, const GLKVector3 bVector) {
    GLKVector3 result = {
        aVector.y * bVector.z - aVector.z * bVector.y,
        aVector.z * bVector.x - aVector.x * bVector.z,
        aVector.x * bVector.y - aVector.y * bVector.x
    };
    return result;
}

/// return a unit vector in the same direction as the cross product of aVector and bVector
GLKVector3 AVector3UnitNormal(const GLKVector3 aVector, const GLKVector3 bVector) {
    return AVector3Normalize(AVector3CrossProduct(aVector, bVector));
}
