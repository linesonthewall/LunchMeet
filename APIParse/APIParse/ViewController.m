//
//  ViewController.m
//  APIParse
//
//  Created by MasterRyuX on 5/25/13.
//  Copyright (c) 2013 MasterRyuX. All rights reserved.
//

#import "ViewController.h"
#import "VenueAnnotation.h"
#import "VenueObject.h"

@interface ViewController ()

{
    NSDictionary* firstDictionary;
    NSArray* itemArray;
    NSDictionary *itemDictionary;
    NSDictionary* subDict1;
    NSMutableArray* subArray1;
    NSMutableDictionary* listVenue;
    VenueObject* oneVenue;

    
}

@end

@implementation ViewController
@synthesize tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.mapView.delegate = self;
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(41.894032, -87.634589);
    MKCoordinateSpan span = MKCoordinateSpanMake(.05, .05);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    self.mapView.region = region;
    
    NSString *urlString = @"https://api.foursquare.com/v2/venues/search?ll=41.894032,%20-87.634589&query=coffee%20or%20library%20&oauth_token=R0LICVP1OPDRVUGDTBAY4YQDCCRZKQ20BLR4SNG5XVKZ5T5M";
    NSLog(@"The search URL is%@", urlString);
    
    NSURL *url = [NSURL URLWithString: urlString];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue: [NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *urlResponse, NSData *data, NSError *error)
     
     {
         
         
         NSDictionary *bigDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
         
         NSDictionary * venueDictionary = [bigDictionary objectForKey:@"response"];
        
         NSArray *groupsArray = [venueDictionary objectForKey:@"groups"];
    
         NSDictionary* subgroupDictionary = [groupsArray objectAtIndex:0];
         itemArray = [subgroupDictionary objectForKey:@"items"];
       
         //for (NSMutableDictionary* listVenue in itemArray)
             for (listVenue in itemArray)
             
         {
             oneVenue = [[VenueObject alloc]init] ;
             
             
             oneVenue.title = [listVenue objectForKey:@"name"];
             NSLog(@"%@", oneVenue.title);
             oneVenue.placeID = [listVenue objectForKey:@"id"];
             NSLog(@"%@", oneVenue.placeID);
             oneVenue.subtitle = listVenue [@"location"][@"address"];
             oneVenue.placeLatitude = listVenue [@"location"][@"lat"];
             oneVenue.placeLongitude = listVenue [@"location"][@"lng"];
             oneVenue.coordinate = CLLocationCoordinate2DMake([oneVenue.placeLatitude floatValue], [oneVenue.placeLongitude floatValue]);
             oneVenue.distance = listVenue[@"location"][@"distance"];
             oneVenue.hugeDictionary = listVenue
             ;
             
             [self.mapView addAnnotation:oneVenue];
             [tableView reloadData];
             
             
             
             //  [arrayOfObjects addObject:object];
                 //NSLog(@"%@",listVenue);
         }
         //end of fast enumeration
         
         
         
         //NSLog(@"%@",listVenue);
     }];
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    NSLog(@"%@", itemArray);
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return itemArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"reuseList";
    // cell = [[UITableViewCell alloc]initwithStyle:UITableViewCellStyleSubtitle;
    UITableViewCell *cell =
    [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier: @"cell"];
    }
    itemDictionary = itemArray[indexPath.row];
    NSLog(@"%@", itemDictionary);
   // cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
    cell.textLabel.font = [UIFont fontWithName:@"Optima" size:16.0];
    
    
    cell.textLabel.text = [itemDictionary objectForKey:@"name"];
    NSLog(@"%@", cell.textLabel.text);
    cell.detailTextLabel.text = itemDictionary[@"location"][@"address"];
    //cell.textLabel.text = itemDictionary[@"user"][@"username"];
    
    
    //  if (cell == nil) {
    //    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    //}
    
    return cell;
}

/*
//-(MKAnnotationView* )mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
//{
//    NSString *reuseIdentifier = @"reuseIdentifier";
//    MKAnnotationView * annotationView =[mapView dequeueReusableAnnotationViewWithIdentifier:reuseIdentifier];

//    if (annotationView == nil) {
        annotationView = [[VenueAnnotation alloc] initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
        
        annotationView.canShowCallout = YES;
        annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    else {
        annotationView.annotation = annotation;
    }
    return annotationView;
}
*/

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   itemDictionary = itemArray[indexPath.row];
  
    
}

-(void)mapView:(MKMapView*)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
