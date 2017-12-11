//
//  LSBookCell.m
//  eReader
//
//  Created by banwang on 2017/12/11.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSBookCell.h"

@interface LSBookCell()
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *discrib;

@end

@implementation LSBookCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(LSReadModel *)model{
    _model = model;
    _title.text = model.title;
    _author.text = model.author;
    _discrib.text = model.discripe;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
