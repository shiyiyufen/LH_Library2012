//
//  MyAnnotation.h
//  SimpleMapView
//
//  Created by Mayur Birari.

//

#import <Foundation/Foundation.h>
#import"BMKAnnotation.h"
#import <MapKit/MapKit.h>
// types of annotations for which we will provide annotation views. 
typedef enum {
	MyAnnotationTypeStart = 0,
	MyAnnotationTypeEnd   = 1,
	MyAnnotationTypeImage = 2
} MyAnnotationType;
@interface MyAnnotation : NSObject<BMKAnnotation> {
	MyAnnotationType    annotationType;
	CLLocationCoordinate2D	coordinate;
	NSString*				title;
	NSString*				subtitle;
	NSInteger               atag;
	NSURL*                  url;
}
@property MyAnnotationType    annotationType;
@property (nonatomic, assign)	CLLocationCoordinate2D	coordinate;
@property (nonatomic, copy)		NSString*				title;
@property (nonatomic, copy)		NSString*				subtitle;
@property (nonatomic,assign)    NSInteger               atag;
@property (nonatomic, retain)   NSURL* url;

-(id) initWithCoordinate:(CLLocationCoordinate2D)_coordinate 
annotationType:(MyAnnotationType) _annotationType
				   title:(NSString*)_title subTitle:(NSString*)_subTitle withTag:(NSInteger)_tag;
@end