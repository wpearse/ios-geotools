//
//  GTBoundingBox.m
//  iOS GeoTools
//
//  Created by Will Pearse on 8/05/13.
//  Copyright (c) 2013 MobileNet Limited. All rights reserved.
//

#import "GTBoundingBox.h"

@implementation GTBoundingBox

- (id)init {
    
    if (self = [super init]) {
        [self reset];
    }
    return self;
}

- (void)reset {
    
    mCoordinateCount = 0;
    mCoordinateNorthWest = CLLocationCoordinate2DMake(-90, -180);
    mCoordinateSouthEast = CLLocationCoordinate2DMake(90, 180);
}

- (void)expandToIncludeCoordinate:(CLLocationCoordinate2D)coordinate {
    
    // shift the NW point
    if (coordinate.latitude > mCoordinateNorthWest.latitude) {
        mCoordinateNorthWest.latitude = coordinate.latitude;
    }
    if (coordinate.longitude > mCoordinateNorthWest.longitude) {
        mCoordinateNorthWest.longitude = coordinate.longitude;
    }
    
    // shift the SE point
    if (coordinate.latitude < mCoordinateSouthEast.latitude) {
        mCoordinateSouthEast.latitude = coordinate.latitude;
    }
    if (coordinate.longitude < mCoordinateSouthEast.longitude) {
        mCoordinateSouthEast.longitude = coordinate.longitude;
    }
    
    // increment the number of points
    mCoordinateCount++;
}

- (int)numberOfCoordinates {
    
    return mCoordinateCount;
}

- (CLLocationCoordinate2D)center {

    NSAssert(mCoordinateCount > 0, @"Need at least one coordinate to calculate the center of this bounding box.");
    
    CLLocationDegrees latitude = (mCoordinateNorthWest.latitude + mCoordinateSouthEast.latitude) / 2;
    CLLocationDegrees longitude = (mCoordinateNorthWest.longitude + mCoordinateSouthEast.longitude) / 2;
    
    return CLLocationCoordinate2DMake(latitude, longitude);
}

@end
