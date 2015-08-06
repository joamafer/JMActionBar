//
//  JMActionBar.m
//  JMActionBar
//
//  Created by JOSE ANTONIO MARTINEZ FERNANDEZ on 06/08/2015.
//  Copyright (c) 2015 jamartinez. All rights reserved.
//

#import "JMActionBar.h"

@interface JMActionBar()
@property (nonatomic, strong) NSLayoutConstraint *lineLeftConstraint;
@property (nonatomic, strong) NSMutableArray *buttons;
@end

@implementation JMActionBar

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    self.backgroundColor = self.backgroundColor;
    
    UIButton *previousElement;
    for (int i = 0 ; i < self.tabs.count; i++) {
        UIButton *button = [self configureButtonWithTag:i title:self.tabs[i]];
        [self addSubview:button];
        
        if (self.tabs.count > 1) {
            if (i == 0) { // first element
                NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                                     attribute:NSLayoutAttributeLeading
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:self
                                                                                     attribute:NSLayoutAttributeLeading
                                                                                    multiplier:1.0
                                                                                      constant:0];
                NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                                 attribute:NSLayoutAttributeTop
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:self
                                                                                 attribute:NSLayoutAttributeTop
                                                                                multiplier:1.0
                                                                                  constant:0];
                NSLayoutConstraint *bottomConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                                    attribute:NSLayoutAttributeBottom
                                                                                    relatedBy:NSLayoutRelationEqual
                                                                                       toItem:self
                                                                                    attribute:NSLayoutAttributeBottom
                                                                                   multiplier:1.0
                                                                                     constant:0];
                [self addConstraints:@[leadingConstraint, topConstraint, bottomConstraint]];
                
                // line
                UIView *line = [UIView new];
                line.translatesAutoresizingMaskIntoConstraints = NO;
                line.backgroundColor = self.lineColor;
                [self addSubview:line];
                
                self.lineLeftConstraint = [NSLayoutConstraint constraintWithItem:line
                                                                       attribute:NSLayoutAttributeLeft
                                                                       relatedBy:NSLayoutRelationEqual
                                                                          toItem:self
                                                                       attribute:NSLayoutAttributeLeft
                                                                      multiplier:1.0
                                                                        constant:0];
                NSLayoutConstraint *lineBottomConstraint = [NSLayoutConstraint constraintWithItem:line
                                                                                        attribute:NSLayoutAttributeBottom
                                                                                        relatedBy:NSLayoutRelationEqual
                                                                                           toItem:self
                                                                                        attribute:NSLayoutAttributeBottom
                                                                                       multiplier:1.0
                                                                                         constant:0];
                NSLayoutConstraint *lineEqualWidthConstraint = [NSLayoutConstraint constraintWithItem:line
                                                                                            attribute:NSLayoutAttributeWidth
                                                                                            relatedBy:NSLayoutRelationEqual
                                                                                               toItem:nil
                                                                                            attribute:NSLayoutAttributeWidth
                                                                                           multiplier:1.0
                                                                                             constant:100];
                NSLayoutConstraint *lineHeightConstraint = [NSLayoutConstraint constraintWithItem:line
                                                                                        attribute:NSLayoutAttributeHeight
                                                                                        relatedBy:NSLayoutRelationEqual
                                                                                           toItem:nil
                                                                                        attribute:NSLayoutAttributeHeight
                                                                                       multiplier:1.0
                                                                                         constant:2];
                [self addConstraints:@[self.lineLeftConstraint, lineBottomConstraint, lineEqualWidthConstraint, lineHeightConstraint]];
                
                
            } else { // next elements
                NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                                     attribute:NSLayoutAttributeLeading
                                                                                     relatedBy:NSLayoutRelationEqual
                                                                                        toItem:previousElement
                                                                                     attribute:NSLayoutAttributeTrailing
                                                                                    multiplier:1.0
                                                                                      constant:0];
                NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                                 attribute:NSLayoutAttributeTop
                                                                                 relatedBy:NSLayoutRelationEqual
                                                                                    toItem:previousElement
                                                                                 attribute:NSLayoutAttributeTop
                                                                                multiplier:1.0
                                                                                  constant:0];
                NSLayoutConstraint *equalWidthConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                                       attribute:NSLayoutAttributeWidth
                                                                                       relatedBy:NSLayoutRelationEqual
                                                                                          toItem:previousElement
                                                                                       attribute:NSLayoutAttributeWidth
                                                                                      multiplier:1.0
                                                                                        constant:0];
                NSLayoutConstraint *equalHeightConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                                        attribute:NSLayoutAttributeHeight
                                                                                        relatedBy:NSLayoutRelationEqual
                                                                                           toItem:previousElement
                                                                                        attribute:NSLayoutAttributeHeight
                                                                                       multiplier:1.0
                                                                                         constant:0];
                [self addConstraints:@[leadingConstraint, topConstraint, equalWidthConstraint, equalHeightConstraint]];
                
                if (i == self.tabs.count - 1) { // last element
                    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:button
                                                                                          attribute:NSLayoutAttributeTrailing
                                                                                          relatedBy:NSLayoutRelationEqual
                                                                                             toItem:self
                                                                                          attribute:NSLayoutAttributeTrailing
                                                                                         multiplier:1.0
                                                                                           constant:0];
                    [self addConstraint:trailingConstraint];
                }
            }
        } else {
            NSAssert(self.tabs.count <= 1, @"Number of tabs must be greater than 1");
        }
        
        previousElement = button;
    }
}

- (UIButton *)configureButtonWithTag:(NSInteger)tag title:(NSString *)title {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.selected = tag == 0;
    button.titleLabel.font = self.font;
    [button setTitleColor:self.deselectedFontColor forState:UIControlStateNormal];
    [button setTitleColor:self.selectedFontColor forState:UIControlStateSelected];
    button.translatesAutoresizingMaskIntoConstraints = NO;
    button.tag = tag;
    [button setTitle:title forState:UIControlStateNormal];
    [button addTarget:self action:@selector(actionButtonWasTapped:) forControlEvents:UIControlEventTouchUpInside];
    
    return button;
}

# pragma mark -
# pragma mark Actions and Selectors

- (void)actionButtonWasTapped:(UIButton *)sender {
    [self deselectButtonsExceptingButtonWithTag:sender.tag];
    self.lineLeftConstraint.constant = sender.frame.origin.x;
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
    [self.delegate didTapTabWithTag:sender.tag];
}

# pragma mark -
# pragma mark Utils

- (void)deselectButtonsExceptingButtonWithTag:(NSInteger)tag {
    for (id view in self.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            ((UIButton *)view).selected = ((UIButton *)view).tag == tag;
        }
    }
}

@end
