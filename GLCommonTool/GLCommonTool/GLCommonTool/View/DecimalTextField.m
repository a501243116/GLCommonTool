//
//  DecimalTextField.m
//  EasyToVote
//
//  Created by gu on 2017/2/23.
//  Copyright © 2017年 yp. All rights reserved.
//

#import "DecimalTextField.h"

@interface DecimalTextField ()<UITextFieldDelegate>

@end

@implementation DecimalTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.delegate = self;
    self.keyboardType = UIKeyboardTypeDecimalPad;
    _decimalLength = 2;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length > 0 && string.length > 0) {
        NSRange r = [textField.text rangeOfString:@"."];
        if (r.length > 0 && ([textField.text substringFromIndex:r.location + 1].length >= _decimalLength || [string isEqualToString:@"."])) {
            return NO;
        }
    }else if (textField.text.length == 0 && [string isEqualToString:@"."]) {
        return NO;
    }
    return YES;
}


@end
