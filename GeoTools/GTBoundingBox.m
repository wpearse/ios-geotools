//
//  GTBoundingBox.m
//  iOS GeoTools
//
//  Created by Will Pearse on 8/05/13.
//  Copyright (c) 2013 MobileNet Limited. All rights reserved.
//

#import "GTBoundingBox.h"

#define GTClamp(x, low, high)  (((x) > (high)) ? (high) : (((x) < (low)) ? (low) : (x)))

@implementation GTBoundingBox

- (id)init {
    
    if (self = [super init]) {
        
        [self reset];
        
        mMinimumWidthDegrees = GTBoundingBoxDefaultMinimumWidth;
        
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

- (CLLocationCoordinate2D)centerCoordinate {

    NSAssert(mCoordinateCount > 0, @"Need at least one coordinate to calculate the center of this bounding box.");
    
    CLLocationDegrees latitude = (mCoordinateNorthWest.latitude + mCoordinateSouthEast.latitude) / 2;
    CLLocationDegrees longitude = (mCoordinateNorthWest.longitude + mCoordinateSouthEast.longitude) / 2;
    
    return CLLocationCoordinate2DMake(latitude, longitude);
}

- (MKCoordinateRegion)coordinateRegion {
    
    return [self coordinateRegionWithPadding:0];
}

- (MKCoordinateRegion)coordinateRegionWithPadding:(CLLocationDegrees)paddingDegrees {
    
    NSAssert(mCoordinateCount > 0, @"Need at least one coordinate to calculate the region of this bounding box.");
    
    CLLocationDegrees latitudeDelta = mCoordinateNorthWest.latitude - mCoordinateSouthEast.latitude;
    CLLocationDegrees longitudeDelta = mCoordinateNorthWest.longitude - mCoordinateSouthEast.longitude;
    
    latitudeDelta = GTClamp(latitudeDelta, mMinimumWidthDegrees, latitudeDelta) + (paddingDegrees * 2);
    longitudeDelta = GTClamp(longitudeDelta, mMinimumWidthDegrees, longitudeDelta) + (paddingDegrees * 2);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(latitudeDelta, longitudeDelta);
    
    MKCoordinateRegion region = MKCoordinateRegionMake([self centerCoordinate], span);
    
    return region;
}

- (void) setMinimumWidth:(CLLocationDegrees)minimumWidth {

    NSAssert(minimumWidth >= 0, @"Minimum width must be a positive value");
    
    mMinimumWidthDegrees = minimumWidth;
}

- (BOOL) containsCoordinate:(CLLocationCoordinate2D)coordinate {
    
    NSAssert(mCoordinateCount > 1, @"Need at least two coordinates to hit-test in this bounding box.");
    
    BOOL withinLatitudeBounds = coordinate.latitude <= mCoordinateNorthWest.latitude
                             && coordinate.latitude >= mCoordinateSouthEast.latitude;
    
    BOOL withinLongitudeBounds = coordinate.longitude <= mCoordinateNorthWest.longitude
                              && coordinate.longitude >= mCoordinateSouthEast.longitude;
    
    return withinLatitudeBounds && withinLongitudeBounds;
}

@end
