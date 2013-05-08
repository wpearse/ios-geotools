//
//  GTBoundingBox.h
//  iOS GeoTools
//
//  Created by Will Pearse on 8/05/13.
//  Copyright (c) 2013 MobileNet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface GTBoundingBox : NSObject {
    
    CLLocationCoordinate2D mCoordinateNorthWest;
    CLLocationCoordinate2D mCoordinateSouthEast;
    
    int mCoordinateCount;
    
}

// clears the bounding box to its virginal state
- (void)reset;

// increases the size of the bounding box by the minimum required to include this new coordinate
// the number of coordinates counter will be incremented by one
- (void)expandToIncludeCoordinate:(CLLocationCoordinate2D)coordinate;

// returns the number of coordinates used to build this bounding box
// this bounding box must include at least one coordinate in order to find the center
- (int)numberOfCoordinates;

// the center of the bounding box
- (CLLocationCoordinate2D)center;

@end
