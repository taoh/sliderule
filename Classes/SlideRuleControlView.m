//
//  SlideRuleControlView.m
//  UIWork
//
//  Created by Jared Carlson on 11/14/10.
//  Copyright 2010 GoToTheBoard.com. All rights reserved.
//

#import "SlideRuleControlView.h"
#import "GradientCoverView.h"
#import "CustomSliderView.h"
#import "IndicatorCoverView.h"
#import "CustomSliderTheme.h"

@implementation SlideRuleControlView

@synthesize slideDelegate, value;

- (id)initWithFrame:(CGRect)frame params:(SliderParam*)params
{
	if ( (self = [super initWithFrame:frame]) )
	{
		// initialization code
		slider = [[CustomSliderView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) params:params];
		[self addSubview:slider];
		slider.maxValue = params->maxValue;
		slider.minValue = params->minValue;
		[slider setSliderDelegate:self];
		
		cover = [[GradientCoverView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[self addSubview:cover];
		[cover setUserInteractionEnabled:NO];
		[cover release];
		
		indicator = [[IndicatorCoverView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[self addSubview:indicator];
		[indicator setUserInteractionEnabled:NO];
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
		
		slider = [[CustomSliderView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[self addSubview:slider];
		slider.maxValue = 20.0;
		slider.minValue = 0.0;
		[slider setSliderDelegate:self];
		
		cover = [[GradientCoverView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[self addSubview:cover];
		[cover setUserInteractionEnabled:NO];
		[cover release];
		
		indicator = [[IndicatorCoverView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
		[self addSubview:indicator];
		[indicator setUserInteractionEnabled:NO];
		
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
	
	[indicator release];
	[cover release];
	[slider release];
    [super dealloc];
}


- (IBAction) valueDidChange:(UIEvent*)event
{
	if ( slideDelegate )
	{
		[slideDelegate slideValueChanged:self];
	}
	
	CGFloat value = [self currentValue];
	NSLog(@"The current value is %f",value);
}

#pragma mark -
#pragma mark Setters
- (void) applyTheme:(CustomSliderTheme*)theme
{
	// set the indicator color
	NSLog(@"indicator color %@",theme.indicatorColor);
	[indicator setIndicatorColor:theme.indicatorColor];
	
	// set the gradient colors
	[slider setGradientColors:theme.gradientColors];
	
	// apply the line color
	[slider setLineColor:theme.lineColor];
	
	// apply the text color 
	[slider setTextColor:theme.textColor];
	
	// apply the background color
	[slider setBackgroundColorChart:theme.backgroundColor];
	[slider setBackgroundColor:theme.backgroundColor];
	
	// done...
	[slider setNeedsDisplay];
}

- (CGFloat) currentValue
{

	CGFloat width = slider.frame.size.width;
	CGFloat x = slider.contentOffset.x;
	CGFloat w = slider.contentSize.width - width;
	CGFloat temp = ( x / w ) * ( slider.maxValue - slider.minValue ) + slider.minValue;
	value = temp;
	return value;
}

- (void) setCurrentValue:(float)_val
{
	CGFloat width = slider.frame.size.width;
	CGFloat w     = slider.contentSize.width - width;
	CGFloat range = (slider.maxValue - slider.minValue);
	CGFloat temp  = ( _val - slider.minValue) / range;
	CGFloat x     = temp * w;
	CGPoint offset = CGPointMake(x, 0);
	[slider setContentOffset:offset];
	// done
}

+ (SliderParam*) createParametersMin:(float)min max:(float)max scale:(float)scale
					numberMajorTicks:(unsigned int)numberMajorTicks
					numberMinorTicks:(unsigned int)numberMinorTicks 
							  factor:(unsigned int)factor
{
	SliderParam * params = (SliderParam*) malloc( sizeof(SliderParam) * 1 );
	params->minValue = min;
	params->maxValue = max;
	params->scale    = scale;
	params->numberMinorTicks = numberMinorTicks;
	params->numberIntervals  = numberMajorTicks;
	params->s = factor;
#define LOW_FACTOR_LIMIT 2.0f
	if ( params->s < LOW_FACTOR_LIMIT ) {
		params->s = LOW_FACTOR_LIMIT;
	}
	
	return params;
}
@end
