//
//  DDTLocationManager.m
//  iPhone
//
//  Created by Cui Tong on 29/03/2012.
//  Copyright (c) 2012 diandian.com. All rights reserved.
//

#import "DDTLocationManager.h"
#import "SynthesizeSingleton.h"

@interface DDTLocationManager ()


@end

@implementation DDTLocationManager

#pragma mark -
#pragma mark Properties
SYNTHESIZE_SINGLETON_FOR_CLASS(DDTLocationManager);
@synthesize delegate = _delegate;
@synthesize locationManager = _locationManager;
@synthesize didUpdateLocation = _didUpdateLocation;

- (void)dealloc {
    self.delegate = nil;
}

#pragma mark -
#pragma mark Accessors
- (CLLocationManager *)locationManager {
    if (nil == _locationManager) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.delegate = self;
    }
    return _locationManager;
}

- (CLLocationCoordinate2D)lastSuccCoordinate {
    return _lastSuccCoordinate;
}

#pragma mark -
#pragma mark Life cycle


#pragma mark -
#pragma mark Logic
+ (BOOL)locationServicesEnabled {
    return [CLLocationManager locationServicesEnabled];
}

+ (BOOL)locationStatusAuthorized {
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        if ( kCLAuthorizationStatusAuthorizedWhenInUse == [CLLocationManager authorizationStatus] || kCLAuthorizationStatusAuthorized == [CLLocationManager authorizationStatus]) {
            return YES;
        }
    }
    return (kCLAuthorizationStatusAuthorized == [CLLocationManager authorizationStatus]);
}

- (void)touch {
    [self startUpdateLocation];
    [self stopUpdateLocation];
}

- (BOOL)startUpdateLocation {
    self.didUpdateLocation = NO;
    if (![self overMinimalInterval]){
        if ([self.delegate respondsToSelector:@selector(locationDidFetched:)] && !self.didUpdateLocation) {
            [self.delegate locationDidFetched:self];
        }
        return YES;
    }
    else {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
            [self.locationManager requestWhenInUseAuthorization];
            [self.locationManager stopUpdatingLocation];
            [self.locationManager startUpdatingLocation];
            return YES;
        }
        else {
            if ([CLLocationManager locationServicesEnabled]) {
                [self.locationManager stopUpdatingLocation];
                [self.locationManager startUpdatingLocation];
                return YES;
            }
        }
    }
    return NO;
}

- (void)stopUpdateLocation {
    [self.locationManager stopUpdatingLocation];
}


#pragma mark - 
#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    [self.locationManager startUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {
//    LBLog(@"Location : %f, %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
    
    self.lastUpdateDate = [NSDate date];
    self.lastSuccCoordinate = newLocation.coordinate;
    self.didFirstFetchedLocation = YES;
    if ([self.delegate respondsToSelector:@selector(locationDidFetched:)] && !self.didUpdateLocation) {
        [self.delegate locationDidFetched:self];
    }
    if (!self.didUpdateLocation) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_Location_Fetched object:self];
    }
    self.didUpdateLocation = YES;
    [self stopUpdateLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    if ([[error domain] isEqualToString: kCLErrorDomain] && [error code] == kCLErrorDenied) {
        if ([self.delegate respondsToSelector:@selector(locationDidDenied:)]) {
            [self.delegate locationDidDenied:self];
        }
    } else {
        if ([self.delegate respondsToSelector:@selector(locationDidFailed:)]) {
            [self.delegate locationDidFailed:self];
        }
    }
}

#define kGuides_Location_Interval                           (600)

- (BOOL)overMinimalInterval {
    if (self.lastUpdateDate != nil && [[NSDate date] timeIntervalSinceDate:self.lastUpdateDate] < kGuides_Location_Interval) {
        return NO;
    }
    return YES;
}

- (CLLocation *)currentLocation {
    return self.locationManager.location;
}

- (double)distanceWithLatitude:(double)latitude longitude:(double)longitude {
    double dd = M_PI/180;
    double x1=self.lastSuccCoordinate.latitude*dd,x2=latitude*dd;
    double y1=self.lastSuccCoordinate.longitude*dd,y2=longitude*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //km  返回
    //     return  distance*1000;
    
    //返回 m
    return   distance;
}

+(double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2{
    double dd = M_PI/180;
    double x1=lat1*dd,x2=lat2*dd;
    double y1=lng1*dd,y2=lng2*dd;
    double R = 6371004;
    double distance = (2*R*asin(sqrt(2-2*cos(x1)*cos(x2)*cos(y1-y2) - 2*sin(x1)*sin(x2))/2));
    //km  返回
    //     return  distance*1000;
    
    //返回 m
    return   distance;
    
}

@end
