//
//  UIPlaceHolderTextView.h
//  CentreCourt
//
//  Created by Sierra on 17/04/17.
//  Copyright © 2017 CIS. All rights reserved.
//

#import <UIKit/UIKit.h>
IB_DESIGNABLE

@interface UIPlaceHolderTextView : UITextView
@property (nonatomic, retain) IBInspectable NSString *placeholder;
@property (nonatomic, retain) IBInspectable UIColor *placeholderColor;
@property (nonatomic, retain) UILabel *placeHolderLabel;
@property (nonatomic, assign) BOOL isCenterPlaceholder;

-(void)textChanged:(NSNotification*)notification;
@end
