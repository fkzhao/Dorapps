//
//  NWSegmentedControl.h
//  Dorapps
//
//  Created by Anselz on 14-7-16.
//  Copyright (c) 2014年 NeoWork. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^IndexChangeBlock)(NSInteger index);

typedef enum {
    NWSegmentedControlSelectionStyleTextWidthStripe, // Indicator width will only be as big as the text width
    NWSegmentedControlSelectionStyleFullWidthStripe, // Indicator width will fill the whole segment
    NWSegmentedControlSelectionStyleBox, // A rectangle that covers the whole segment
    NWSegmentedControlSelectionStyleArrow // An arrow in the middle of the segment pointing up or down depending on `NWSegmentedControlSelectionIndicatorLocation`
} NWSegmentedControlSelectionStyle;

typedef enum {
    NWSegmentedControlSelectionIndicatorLocationUp,
    NWSegmentedControlSelectionIndicatorLocationDown,
	NWSegmentedControlSelectionIndicatorLocationNone // No selection indicator
} NWSegmentedControlSelectionIndicatorLocation;

typedef enum {
    NWSegmentedControlSegmentWidthStyleFixed, // Segment width is fixed
    NWSegmentedControlSegmentWidthStyleDynamic, // Segment width will only be as big as the text width (including inset)
} NWSegmentedControlSegmentWidthStyle;

enum {
    NWSegmentedControlNoSegment = -1   // Segment index for no selected segment
};

typedef enum {
    NWSegmentedControlTypeText,
    NWSegmentedControlTypeImages,
	NWSegmentedControlTypeTextImages
} NWSegmentedControlType;

@interface NWSegmentedControl : UIControl
@property (nonatomic, strong) NSArray *sectionTitles;
@property (nonatomic, strong) NSArray *sectionImages;
@property (nonatomic, strong) NSArray *sectionSelectedImages;

/*
 Provide a block to be executed when selected index is changed.
 
 Alternativly, you could use `addTarget:action:forControlEvents:`
 */
@property (nonatomic, copy) IndexChangeBlock indexChangeBlock;

/*
 Font for segments names when segmented control type is `NWSegmentedControlTypeText`
 
 Default is [UIFont fontWithName:@"STHeitiSC-Light" size:18.0f]
 */
@property (nonatomic, strong) UIFont *font;

/*
 Text color for segments names when segmented control type is `NWSegmentedControlTypeText`
 
 Default is [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor *textColor;

/*
 Text color for selected segment name when segmented control type is `NWSegmentedControlTypeText`
 
 Default is [UIColor blackColor]
 */
@property (nonatomic, strong) UIColor *selectedTextColor;

/*
 Segmented control background color.
 
 Default is [UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *backgroundColor;

/*
 Color for the selection indicator stripe/box
 
 Default is R:52, G:181, B:229
 */
@property (nonatomic, strong) UIColor *selectionIndicatorColor;

/*
 Specifies the style of the control
 
 Default is `NWSegmentedControlTypeText`
 */
@property (nonatomic, assign) NWSegmentedControlType type;

/*
 Specifies the style of the selection indicator.
 
 Default is `NWSegmentedControlSelectionStyleTextWidthStripe`
 */
@property (nonatomic, assign) NWSegmentedControlSelectionStyle selectionStyle;

/*
 Specifies the style of the segment's width.
 
 Default is `NWSegmentedControlSegmentWidthStyleFixed`
 */
@property (nonatomic, assign) NWSegmentedControlSegmentWidthStyle segmentWidthStyle;

/*
 Specifies the location of the selection indicator.
 
 Default is `NWSegmentedControlSelectionIndicatorLocationUp`
 */
@property (nonatomic, assign) NWSegmentedControlSelectionIndicatorLocation selectionIndicatorLocation;

/*
 Default is NO. Set to YES to allow for adding more tabs than the screen width could fit.
 
 When set to YES, segment width will be automatically set to the width of the biggest segment's text or image,
 otherwise it will be equal to the width of the control's frame divided by the number of segments.
 
 As of v 1.4 this is no longer needed. The control will manage scrolling automatically based on tabs sizes.
 */
@property(nonatomic, getter = isScrollEnabled) BOOL scrollEnabled DEPRECATED_ATTRIBUTE;

/*
 Default is YES. Set to NO to deny scrolling by dragging the scrollView by the user.
 */
@property(nonatomic, getter = isUserDraggable) BOOL userDraggable;

/*
 Default is YES. Set to NO to deny any touch events by the user.
 */
@property(nonatomic, getter = isTouchEnabled) BOOL touchEnabled;


/*
 Index of the currently selected segment.
 */
@property (nonatomic, assign) NSInteger selectedSegmentIndex;

/*
 Height of the selection indicator. Only effective when `NWSegmentedControlSelectionStyle` is either `NWSegmentedControlSelectionStyleTextWidthStripe` or `NWSegmentedControlSelectionStyleFullWidthStripe`.
 
 Default is 5.0
 */
@property (nonatomic, readwrite) CGFloat selectionIndicatorHeight;

/*
 Inset left and right edges of segments. Only effective when `scrollEnabled` is set to YES.
 
 Default is UIEdgeInsetsMake(0, 5, 0, 5)
 */
@property (nonatomic, readwrite) UIEdgeInsets segmentEdgeInset;

/*
 Default is YES. Set to NO to disable animation during user selection.
 */
@property (nonatomic) BOOL shouldAnimateUserSelection;

- (id)initWithSectionTitles:(NSArray *)sectiontitles;
- (id)initWithSectionImages:(NSArray *)sectionImages sectionSelectedImages:(NSArray *)sectionSelectedImages;
- (instancetype)initWithSectionImages:(NSArray *)sectionImages sectionSelectedImages:(NSArray *)sectionSelectedImages titlesForSections:(NSArray *)sectiontitles;
- (void)setSelectedSegmentIndex:(NSUInteger)index animated:(BOOL)animated;
- (void)setIndexChangeBlock:(IndexChangeBlock)indexChangeBlock;

@end
