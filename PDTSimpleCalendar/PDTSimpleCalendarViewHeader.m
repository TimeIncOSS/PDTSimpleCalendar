//
//  PDTSimpleCalendarViewHeader.m
//  PDTSimpleCalendar
//
//  Created by Jerome Miglino on 10/8/13.
//  Copyright (c) 2013 Producteev. All rights reserved.
//

#import "PDTSimpleCalendarViewHeader.h"

const CGFloat PDTSimpleCalendarHeaderTextSize = 12.0f;

@implementation PDTSimpleCalendarViewHeader

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _titleLabel = [[UILabel alloc] init];
        [_titleLabel setFont:self.textFont];
        [_titleLabel setTextColor:self.textColor];
        [_titleLabel setBackgroundColor:[UIColor clearColor]];

        UIView *headerContainerView = [[UIView alloc] init];
        [headerContainerView setBackgroundColor:[UIColor colorWithRed:235.f/255.f green:236.f/255.f blue:237.f/255.f alpha:1]];
        [self addSubview:headerContainerView];
        [headerContainerView setTranslatesAutoresizingMaskIntoConstraints:NO];

        [self addSubview:_titleLabel];
        [_titleLabel setTranslatesAutoresizingMaskIntoConstraints:NO];

        UIView *topSeparatorView = [[UIView alloc] init];
        [topSeparatorView setBackgroundColor:self.separatorColor];
        [self addSubview:topSeparatorView];
        [topSeparatorView setTranslatesAutoresizingMaskIntoConstraints:NO];

        UIView *bottomSeparatorView = [[UIView alloc] init];
        [bottomSeparatorView setBackgroundColor:self.separatorColor];
        [self addSubview:bottomSeparatorView];
        [bottomSeparatorView setTranslatesAutoresizingMaskIntoConstraints:NO];

        CGFloat onePixel = 1.0f / [UIScreen mainScreen].scale;
        NSDictionary *metricsDictionary = @{@"onePixel" : [NSNumber numberWithFloat:onePixel]};
        NSDictionary *viewsDictionary = @{@"headerContainerView": headerContainerView, @"titleLabel" : self.titleLabel, @"topSeparatorView" : topSeparatorView, @"bottomSeparatorView" : bottomSeparatorView};

        UILabel *previousLabel = nil;
        CGFloat labelWidth = [UIScreen mainScreen].bounds.size.width / 7;
        for (NSString *weekday in @[@"S", @"M", @"T", @"W", @"T", @"F", @"S"]) {
            UILabel *weekdayLabel = [[UILabel alloc] init];
            weekdayLabel.text = weekday;
            weekdayLabel.textAlignment = NSTextAlignmentCenter;
            weekdayLabel.font = self.textFont;
            weekdayLabel.textColor = [UIColor colorWithWhite:0 alpha:0.54];
            [self addSubview:weekdayLabel];
            [weekdayLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
            if (previousLabel != nil) {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:weekdayLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:previousLabel attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0]];
            } else {
                [self addConstraint:[NSLayoutConstraint constraintWithItem:weekdayLabel attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeLeft multiplier:1.0 constant:0.0]];
            }
            [self addConstraint:[NSLayoutConstraint constraintWithItem:weekdayLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:bottomSeparatorView attribute:NSLayoutAttributeBottom multiplier:1.0 constant:10.0]];
            [weekdayLabel addConstraint:[NSLayoutConstraint constraintWithItem:weekdayLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:20]];
            [weekdayLabel addConstraint:[NSLayoutConstraint constraintWithItem:weekdayLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:labelWidth]];
            previousLabel = weekdayLabel;
        }

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-(==10)-[titleLabel]-(==10)-|" options:0 metrics:nil views:viewsDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[titleLabel]-(30)-|" options:0 metrics:nil views:viewsDictionary]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[topSeparatorView]|" options:0 metrics:nil views:viewsDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[titleLabel][bottomSeparatorView(==onePixel)]" options:0 metrics:metricsDictionary views:viewsDictionary]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[bottomSeparatorView]|" options:0 metrics:nil views:viewsDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[topSeparatorView(==onePixel)]" options:0 metrics:metricsDictionary views:viewsDictionary]];

        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|[headerContainerView]|" options:0 metrics:nil views:viewsDictionary]];
        [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[headerContainerView]-(30)-|" options:0 metrics:nil views:viewsDictionary]];
    }

    return self;
}


#pragma mark - Colors

- (UIColor *)textColor
{
    if(_textColor == nil) {
        _textColor = [[[self class] appearance] textColor];
    }

    if(_textColor != nil) {
        return _textColor;
    }

    return [UIColor grayColor];
}

- (UIFont *)textFont
{
    if(_textFont == nil) {
        _textFont = [[[self class] appearance] textFont];
    }

    if(_textFont != nil) {
        return _textFont;
    }

    return [UIFont systemFontOfSize:PDTSimpleCalendarHeaderTextSize];
}

- (UIColor *)separatorColor
{
    if(_separatorColor == nil) {
        _separatorColor = [[[self class] appearance] separatorColor];
    }

    if(_separatorColor != nil) {
        return _separatorColor;
    }

    return [UIColor lightGrayColor];
}


@end
