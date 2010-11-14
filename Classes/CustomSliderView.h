//
//  CustomSliderView.h
//  UIWork
//
//  Created by Jared Carlson on 11/8/10.
//  Copyright 2010 GoToTheBoard. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GradientView;
@class LineView;
@class AnnotationView;



@interface CustomSliderView : UIScrollView 
<UIScrollViewDelegate>
{

	GradientView * backgroundGradient;
	CGFloat _minValue;
	CGFloat _maxValue;
	unsigned int ticksInMinorInterval;
	unsigned int ticksInMajorInterval;
	UIColor * lineColor;
	UIColor * textColor;
	UIColor * borderColor;
	NSArray * gradientColors;
	
	LineView * _line;
	AnnotationView * _annotations;

}

@property(nonatomic,retain) GradientView * backgroundGradient;
@property(readwrite) CGFloat minValue;
@property(readwrite) CGFloat maxValue;
@property(readwrite) unsigned int ticksInMinorInterval;
@property(readwrite) unsigned int ticksInMajorInerval;
@property(nonatomic,retain) UIColor * lineColor;
@property(nonatomic,retain) UIColor * textColor;
@property(nonatomic,retain) UIColor * borderColor;
@property(nonatomic,retain) NSArray * gradientColors;

@end
