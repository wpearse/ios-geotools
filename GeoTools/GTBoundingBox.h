//
//  GTBoundingBox.h
//  iOS GeoTools
//
//  Created by Will Pearse on 8/05/13.
//  Copyright (c) 2013 MobileNet Limited. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

#define GTBoundingBoxDefaultMinimumWidth 0.1 // 0.1 degrees ~ 11 km ~ 7 miles

@interface GTBoundingBox : NSObject {
    
    CLLocationCoordinate2D mCoordinateNorthWest;
    CLLocationCoordinate2D mCoordinateSouthEast;
    
    // the number of coordinates that were used to inflate this bounding box
    int mCoordinateCount;
    
    // when the bounding box has been inflated by one coordinate only this value
    // controls the minimum size of the bounding box. this value defaults to
    // GTBoundingBoxDefaultMinimumWidth. adjust this value using setMinimumWidth:
    double mMinimumWidthDegrees;
    
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
- (CLLocationCoordinate2D)centerCoordinate;

// can be used to zoom a MKMapView to this bounding box
- (MKCoordinateRegion)coordinateRegion;

- (MKCoordinateRegion)coordinateRegionWithPadding:(CLLocationDegrees)paddingDegrees;

// the minimum width and height of the bounding box
- (void) setMinimumWidth:(CLLocationDegrees)minimumWidth;

// hit-test inside this bounding box
- (BOOL) containsCoordinate:(CLLocationCoordinate2D)coordinate;

@end
