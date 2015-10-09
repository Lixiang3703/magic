//
//  DDTLocationManager.h
//  iPhone
//
//  Modify from Spaceli (old project)
//
//  Created by Cui Tong on 29/03/2012.
//  Copyright (c) 2012 diandian.com. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@class DDTLocationManager;
@protocol DDTLocationManagerDelegate <NSObject>
@optional
- (void)locationDidFetched:(DDTLocationManager *)caller;
- (void)locationDidDenied:(DDTLocationManager *)caller;
- (void)locationDidFailed:(DDTLocationManager *)caller;

@end

/**
 * 需要及时获得位置变化的对象，监听LocationUpdatedNotification消息即可
 */
@interface DDTLocationManager : NSObject <CLLocationManagerDelegate>{
    id <DDTLocationManagerDelegate> __weak _delegate;
    CLLocationManager *_locationManager;
    BOOL _didUpdateLocation;
    CLLocationCoordinate2D _lastSuccCoordinate;
}

@property (nonatomic, weak) id delegate;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, assign) BOOL didUpdateLocation;
@property (nonatomic, assign) BOOL didFirstFetchedLocation;
@property (nonatomic, strong) NSDate *lastUpdateDate;
@property (nonatomic, assign) CLLocationCoordinate2D lastSuccCoordinate;

+ (DDTLocationManager *)getInstance;
+ (BOOL)locationServicesEnabled;
+ (BOOL)locationStatusAuthorized;

- (BOOL)startUpdateLocation;
- (void)stopUpdateLocation;

- (void)touch;

- (BOOL)overMinimalInterval;
- (CLLocation *)currentLocation;

- (double)distanceWithLatitude:(double)latitude longitude:(double)longitude;

+(double)distanceBetweenOrderBy:(double)lat1 :(double)lat2 :(double)lng1 :(double)lng2;
@end
