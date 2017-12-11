//
//  LSLibraryCell.m
//  eReader
//
//  Created by banwang on 2017/12/11.
//  Copyright © 2017年 guanqun. All rights reserved.
//

#import "LSLibraryCell.h"

@interface LSLibraryCell()

@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation LSLibraryCell


- (void)setModel:(LSChapterModel *)model{
    _model = model;
    _title.text = model.title;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
