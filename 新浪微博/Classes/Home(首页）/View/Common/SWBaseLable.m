//
//  SWBaseLable.m
//  新浪微博
//
//  Created by xc on 15/3/19.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SWBaseLable.h"
#import "SWLink.h"
#define SWLinkBackgroundTag 100
@interface SWBaseLable()

@property(nonatomic, weak) UITextView *textView;
@property (nonatomic, strong) NSMutableArray *links;

@end
@implementation SWBaseLable

/**
 *  懒加载数据：主要提升性能问题
 *
 *  @return 返回所有
 */
- (NSMutableArray *)links
{
    if (!_links) {
        NSMutableArray *links = [NSMutableArray array];
        
        // 搜索所有的链接
        [self.attributedText enumerateAttributesInRange:NSMakeRange(0, self.attributedText.length) options:0 usingBlock:^(NSDictionary *attrs, NSRange range, BOOL *stop) {
            NSString *linkText = attrs[SWLinkAttr];
            
            if (linkText == nil) return;
            
            // 创建一个链接
            SWLink *link = [[SWLink alloc] init];
            link.text = linkText;
            link.range = range;
            
            // 处理矩形框
            NSMutableArray *rects = [NSMutableArray array];
            // 设置选中的字符范围
            self.textView.selectedRange = range;
            // 算出选中的字符范围的边框
            NSArray *selectionRects = [self.textView selectionRectsForRange:self.textView.selectedTextRange];
            for (UITextSelectionRect *selectionRect in selectionRects) {
                if (selectionRect.rect.size.width == 0 || selectionRect.rect.size.height == 0) continue;
                [rects addObject:selectionRect];
            }
            link.rects = rects;
            
            [links addObject:link];
        }];
        
        
        
        self.links = links;
    }
    return _links;
}

/**
 0.查找出所有的链接（用一个数组存放所有的链接）
 
 1.在touchesBegan方法中，根据触摸点找出被点击的链接
 
 2.在被点击链接的边框范围内添加一个有颜色的背景
 
 3.在touchesEnded或者touchedCancelled方法中，移除所有的链接背景
 */

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. 创建一个现实文本textview
        UITextView *textView = [[UITextView alloc] init];
        textView.editable = NO;
        textView.scrollEnabled = NO;
        textView.userInteractionEnabled =NO;
        // 设置文字的内边距
        textView.textContainerInset = UIEdgeInsetsMake(0, -5, 0, -5);
        textView.backgroundColor = [UIColor clearColor];
        self.textView = textView;
        [self addSubview:textView];
        
        
        
    }
    return self;
}



- (void)layoutSubviews
{
    [super layoutSubviews];
    self.textView.frame = self.bounds;
    
}
#pragma mark - 公共接口
- (void)setAttributedText:(NSAttributedString *)attributedText
{
    _attributedText = attributedText;
    
    self.textView.attributedText = attributedText;
    self.links = nil;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    // 得出被点击的那个链接
    SWLink *touchingLink = [self touchingLinkWithPoint:point];
    
    // 设置链接选中的背景
    [self showLinkBackground:touchingLink];
    
    
}
- (void) sendNoticationWithTouchLink:(SWLink *) touchingLink
{
    if (touchingLink) {
        
        switch (self.noticationType) {
            case SWBaseLableEventNoticationTypeStatus:
                // 说明手指在某个链接上面抬起来, 发出通知
                [[NSNotificationCenter defaultCenter] postNotificationName:SWStatusLinkDidSelectedNotification object:nil userInfo:@{SWLinkAttr : touchingLink.text}];
                break;
            case SWBaseLableEventNoticationTypeComment:
                // 说明手指在某个链接上面抬起来, 发出通知
                [[NSNotificationCenter defaultCenter] postNotificationName:SWCommentLinkDidSelectedNotification object:nil userInfo:@{SWLinkAttr : touchingLink.text}];
                break;
            default:
                break;
        }
    }else{
        
        switch (self.noticationType) {
            case SWBaseLableEventNoticationTypeStatus:
                //触摸普通文本
                [[NSNotificationCenter defaultCenter] postNotificationName:SWStatusNormalTextDidSelectedNotification object:nil];
                break;
            case SWBaseLableEventNoticationTypeComment:
                // 说明手指在某个链接上面抬起来, 发出通知
                [[NSNotificationCenter defaultCenter] postNotificationName:SWCommentNormalTextDidSelectedNotification object:nil userInfo:@{SWLinkAttr : touchingLink.text}];
                break;
            default:
                break;
        }
   
    }

}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    
    // 得出被点击的那个链接
    SWLink *touchingLink = [self touchingLinkWithPoint:point];
    [self sendNoticationWithTouchLink:touchingLink];
    // 相当于触摸被取消
    [self touchesCancelled:touches withEvent:event];}
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeAllLinkBackground];
    });
}

#pragma mark - 链接背景处理
/**
 *  根据触摸点找出被触摸的链接
 *
 *  @param point 触摸点
 */
- (SWLink *)touchingLinkWithPoint:(CGPoint)point
{
    __block SWLink *touchingLink = nil;
    [self.links enumerateObjectsUsingBlock:^(SWLink *link, NSUInteger idx, BOOL *stop) {
        for (UITextSelectionRect *selectionRect in link.rects) {
            if (CGRectContainsPoint(selectionRect.rect, point)) {
                touchingLink = link;
                break;
            }
        }
    }];
    return touchingLink;
}
/**
 *  显示链接的背景
 *
 *  @param link 需要显示背景的link
 */
- (void)showLinkBackground:(SWLink *)link
{
    for (UITextSelectionRect *selectionRect in link.rects) {
        UIView *bg = [[UIView alloc] init];
        bg.tag = SWLinkBackgroundTag;
        bg.layer.cornerRadius = 3;
        bg.frame = selectionRect.rect;
        bg.backgroundColor = SWColor(177, 214, 255);
        [self insertSubview:bg atIndex:0];
    }
}

- (void)removeAllLinkBackground
{
    for (UIView *child in self.subviews) {
        if (child.tag == SWLinkBackgroundTag) {
            [child removeFromSuperview];
        }
    }
}


@end
