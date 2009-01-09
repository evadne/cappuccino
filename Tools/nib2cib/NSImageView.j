/*
 * NSImageView.j
 * nib2cib
 *
 * Created by Francisco Tolmasky.
 * Copyright 2008, 280 North, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

@import <AppKit/CPImageView.j>


@implementation CPImageView (NSCoding)

- (id)NS_initWithCoder:(CPCoder)aCoder
{
    self = [super NS_initWithCoder:aCoder];
    
    if (self)
    {
        var cell = [aCoder decodeObjectForKey:@"NSCell"];
        
        _imageScaling = [cell imageScaling];
    }
    
    return self;
}

@end

@implementation NSImageView : CPImageView
{
}

- (id)initWithCoder:(CPCoder)aCoder
{
    return [super NS_initWithCoder:aCoder];
}

- (Class)classForKeyedArchiver
{
    return [CPImageView class];
}

@end

// NSImageCell

NSImageAlignCenter      = 0;
NSImageAlignTop         = 1;
NSImageAlignTopLeft     = 2;
NSImageAlignTopRight    = 3;
NSImageAlignLeft        = 4;
NSImageAlignBottom      = 5;
NSImageAlignBottomLeft  = 6;
NSImageAlignBottomRight = 7;
NSImageAlignRight       = 8;


NSImageScaleProportionallyDown      = 0;
NSImageScaleAxesIndependently       = 1;
NSImageScaleNone                    = 2;
NSImageScaleProportionallyUpOrDown  = 3;

NSImageFrameNone        = 0;
NSImageFramePhoto       = 1;
NSImageFrameGrayBezel   = 2;
NSImageFrameGroove      = 3;
NSImageFrameButton      = 4;

var NSImageScalingToCPImageScaling = {};

NSImageScalingToCPImageScaling[NSImageScaleProportionallyDown]      = CPScaleProportionally;
NSImageScalingToCPImageScaling[NSImageScaleAxesIndependently]       = CPScaleToFit;
NSImageScalingToCPImageScaling[NSImageScaleNone]                    = CPScaleNone;
NSImageScalingToCPImageScaling[NSImageScaleProportionallyUpOrDown]  = CPScaleProportionally;

@implementation NSImageCell : NSCell
{
    BOOL                _animates       @accessors; 
    NSImageAlignmenr    _imageAlignment @accessors;
    NSImageScaling      _imageScaling   @accessors(readonly, getter=imageScaling);
    NSImageFrameStyle   _frameStyle     @accessors;
}

- (id)initWithCoder:(CPCoder)aCoder 
{
    self = [super initWithCoder:aCoder]; 
    
    if (self)
    {
        _animates = [aCoder decodeBoolForKey:@"NSAnimates"]; 
        _imageAlignment = [aCoder decodeIntForKey:@"NSAlign"]; 
        _imageScaling = NSImageScalingToCPImageScaling[[aCoder decodeIntForKey:@"NSScale"]]; 
        _frameStyle = [aCoder decodeIntForKey:@"NSStyle"];
    }
    
    return self;
}

@end
