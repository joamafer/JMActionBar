//
//  JMActionBar.h
//  JMActionBar
//
//  Created by JOSE ANTONIO MARTINEZ FERNANDEZ on 06/08/2015.
//  Copyright (c) 2015 jamartinez. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMActionBarDelegate <NSObject>
- (void)didTapTabWithTag:(NSInteger)tag;
@end

@interface JMActionBar : UIView
@property (nonatomic) UIFont *font;
@property (nonatomic) UIColor *selectedFontColor;
@property (nonatomic) UIColor *deselectedFontColor;
@property (nonatomic) UIColor *lineColor;
@property (nonatomic) NSArray *tabs;
@property (nonatomic, weak) id<JMActionBarDelegate> delegate;
@end
