# iOS GeoTools

iOS GeoTools is an open source collection of Objective-C classes that make GIS on iOS easier.
Functionality includes:

## Bounding box

A bounding box represents a rectangular area, defined by two corners (north-west and south-east). You would typically use a bounding box for hit-testing a feature or zooming a map.

To zoom a map using `GTBoundingBox`:

    GTBoundingBox bbox = [[GTBoundingBox alloc] init];
    
    for (CLLocationCoordinate2D coordinate in ...) {
        [bbox expandToIncludeCoordinate:coordinate];
    }
    
    [myMapView setRegion:[bbox coordinateRegion] animated:YES];
    
To hit-test a point:

    BOOL coordinateInRegion = [regionBoundingBox containsCoordinate:someCoordinate];

# Get started

* Checkout the source: `git clone git://github.com/wpearse/ios-geotools.git`
* Add the `GeoTools` folder to your project
* Read the examples (above)