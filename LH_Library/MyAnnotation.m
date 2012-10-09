//
//  MyAnnotation.m
//  SimpleMapView
//
//  Created by Mayur Birari .

//

#import "MyAnnotation.h"


@implementation MyAnnotation
@synthesize annotationType;
@synthesize title;
@synthesize subtitle;
@synthesize coordinate;
@synthesize atag;
@synthesize url;
- (void)dealloc 
{
	self.title = nil;
	self.subtitle = nil;
	self.atag=0;
	[url release];
	[super dealloc];
	
}
-(id) initWithCoordinate:(CLLocationCoordinate2D)_coordinate 
		  annotationType:(MyAnnotationType) _annotationType
				   title:(NSString*)_title subTitle:(NSString*)_subTitle withTag:(NSInteger)_tag
{
	self = [super init];
	self.coordinate = _coordinate;
	self.title      = _title;
	self.annotationType = _annotationType;
	self.subtitle=_subTitle;
	self.atag=_tag;
	return self;
}
@end