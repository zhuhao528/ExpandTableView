//
//  CustomTableViewCell.m
//  SampleApp
//
//  Created by haozhu on 2019/8/29.
//  Copyright © 2019 朱浩. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.provinceKey = [[UILabel alloc] initWithFrame:CGRectMake(50, 5, 100, 20)];
        [self.contentView addSubview:self.provinceKey];
        
        self.provinceValue = [[UILabel alloc] initWithFrame:CGRectMake(160, 5, 150, 20)];
        [self.contentView addSubview:self.provinceValue];
        
        self.nameKey = [[UILabel alloc] initWithFrame:CGRectMake(50, 30, 100, 20)];
        [self.contentView addSubview:self.nameKey];
        
        self.nameValue = [[UILabel alloc] initWithFrame:CGRectMake(160, 30, 150, 20)];
        [self.contentView addSubview:self.nameValue];

        self.idKey = [[UILabel alloc] initWithFrame:CGRectMake(50, 55, 100, 20)];
        [self.contentView addSubview:self.idKey];
        
        self.idValue = [[UILabel alloc] initWithFrame:CGRectMake(160, 55, 150, 20)];
        [self.contentView addSubview:self.idValue];
    }
    return self;
}


@end
