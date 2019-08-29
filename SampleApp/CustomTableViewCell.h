//
//  CustomTableViewCell.h
//  SampleApp
//
//  Created by haozhu on 2019/8/29.
//  Copyright © 2019 朱浩. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CustomTableViewCell : UITableViewCell

@property (strong, nonatomic)  UILabel *provinceKey;
@property (strong, nonatomic)  UILabel *provinceValue;

@property (strong, nonatomic)  UILabel *nameKey;
@property (strong, nonatomic)  UILabel *nameValue;

@property (strong, nonatomic)  UILabel *idKey;
@property (strong, nonatomic)  UILabel *idValue;

@end

NS_ASSUME_NONNULL_END
