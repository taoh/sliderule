//
//  AnnotationView.m
//  UIWork
//
//  Created by Jared Carlson on 11/9/10.
//  Copyright 2010 GoToTheBoard. All rights reserved.
//

#import "AnnotationView.h"


@implementation AnnotationView

@synthesize numberOfMajorTicks, textColor;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		[self setBackgroundColor:[UIColor clearColor]];
		
		if ( textColor == nil ) {
			self.textColor = [UIColor whiteColor];
		}
		
		numberOfMajorTicks = 10;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
	
	/* Now add the annotations */
	int i=0, len; 
	CGFloat x, y = self.frame.size.height / 2;
	CGContextRef context = UIGraphicsGetCurrentContext();
	char buffer[20];
	CGFloat width = self.frame.size.width;
	CGFloat height = self.frame.size.height;
	
	CGContextSetStrokeColorWithColor(context, textColor.CGColor);
	sprintf(buffer,"Testing!");
	CGContextSetRGBFillColor(context,1,1,1,1);
    CGContextSelectFont(context,"Helvetica",10,kCGEncodingMacRoman);
	CGContextTranslateCTM(context, 0, height);
	CGContextScaleCTM(context, 1.0, -1.0);
  //  CGContextShowTextAtPoint(context,self.frame.size.width/2,self.frame.size.height/2,buffer,strlen(buffer)-1);
	
	
	for (i=0; i<=numberOfMajorTicks; i++)
	{
		sprintf(buffer,"%d",i);
		NSString * temp = [NSString stringWithFormat:@"%s",buffer];
		CGSize sizeOfString = [temp sizeWithFont:[UIFont fontWithName:@"Helvetica" size:10] constrainedToSize:CGSizeMake(100, 100)];
		len = strlen(buffer);
		CGFloat offset = sizeOfString.width/2;
		x = i*(width/2/numberOfMajorTicks)+width/4;
#define OFFSET 15.0f
		CGContextShowTextAtPoint(context, x-offset, height/2 - OFFSET, buffer, strlen(buffer));
	}
	 
	
	// NSString * testing = @"Test works!";
	// [testing drawAtPoint:CGPointMake(self.frame.size.width/2, self.frame.size.height/2) withFont:[UIFont systemFontOfSize:10]];

	[super drawRect:rect];
}


- (void)dealloc {
    [super dealloc];
}


@end
