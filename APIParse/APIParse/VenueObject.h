//
//  VenueObject.h
//  APIParse
//
//  Created by MasterRyuX on 5/25/13.
//  Copyright (c) 2013 MasterRyuX. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface VenueObject : NSObject <MKAnnotation>

@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) NSString *placeID;
@property (strong, nonatomic) NSString *subtitle;
@property (strong, nonatomic) NSString *address;
@property (strong, nonatomic) NSString *placeLatitude;
@property (strong, nonatomic) NSString *placeLongitude;
@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (strong, nonatomic) NSString *distance;
@property(strong, nonatomic) NSString *rating;
@property(strong, nonatomic) NSString *hours;

@property(strong, nonatomic) NSString *additionalInfo;
@property(strong, nonatomic) NSMutableDictionary *hugeDictionary;



@end
