//
//  WXCell.m
//  医院查询Demo
//
//  Created by 孙云 on 16/5/4.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "WXCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define K_Border 15
#define K_Distance 10
#define K_Width [UIScreen mainScreen].bounds.size.width
@implementation WXCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //标题
        self.titleLabel = [[UILabel alloc]init];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        self.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:self.titleLabel];
        //图片
        self.icon = [[UIImageView alloc]init];
        self.icon.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:self.icon];
        //来源
        self.sourceLabel = [[UILabel alloc]init];
        self.sourceLabel.textAlignment = NSTextAlignmentRight;
        self.sourceLabel.font = [UIFont systemFontOfSize:12];
        [self.contentView addSubview:self.sourceLabel];
    }
    return self;
}
- (void)setModel:(WXModel *)model{

    _model = model;
    
    self.titleLabel.text = model.title;
    //title位置大小
    CGSize titleSize = [model.title boundingRectWithSize:CGSizeMake(K_Width - 60 - 2 * K_Border, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    self.titleLabel.frame = CGRectMake(K_Border, K_Border, titleSize.width, titleSize.height);
    
    //图片位置大小
//    __weak typeof(self)weakSelf = self;
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//        
//        NSURL *url = [NSURL URLWithString:model.firstImg];
//        NSData *data = [NSData dataWithContentsOfURL:url];
//        
//        dispatch_async(dispatch_get_main_queue(), ^{
//            weakSelf.icon.image = [UIImage imageWithData:data];
//            weakSelf.icon.frame = CGRectMake(K_Width - 60 - K_Border, K_Border, 60, self.titleLabel.frame.size.height);
//        });
//    });
    
    [self.icon sd_setImageWithURL:[NSURL URLWithString:model.firstImg]];
     self.icon.frame = CGRectMake(K_Width - 60 - K_Border, K_Border, 60, self.titleLabel.frame.size.height);
    //来源
    self.sourceLabel.text = model.source;
    
    self.sourceLabel.frame = CGRectMake(K_Width - 200, self.titleLabel.frame.size.height + self.titleLabel.frame.origin.y + K_Distance, 200 - K_Border,20);
}
/**
 *  单元格高度
 *
 *  @param model <#model description#>
 *
 *  @return <#return value description#>
 */
+ (CGFloat)cellHeightFromWxModel:(WXModel *)model{
    
    //title位置大小
    CGSize titleSize = [model.title boundingRectWithSize:CGSizeMake(K_Width - 60 - 2 * K_Border, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;

    return K_Border + titleSize.height + K_Distance + 20 + K_Border;
}
@end
