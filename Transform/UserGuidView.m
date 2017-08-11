//
//  LVMUserGuidViewController.m
//  Secoo-iPhone
//
//  Created by tuhaisheng on 16/12/28.
//  Copyright © 2016年 tuhaisheng. All rights reserved.
//

#import "UserGuidView.h"
#import "UIColor+Appearance.h"

#define kMDFScreenWidth [UIScreen mainScreen].bounds.size.width
#define kMDFScreenHeight [UIScreen mainScreen].bounds.size.height
static NSInteger const kGuidPageNumber = 4;
static CGFloat const LVMUserGuid1Tag  = 1000;
static CGFloat const LVMUserGuid2Tag  = 2000;
static CGFloat const LVMUserGuid3Tag  = 3000;

static inline CGFloat LVMUserGuidEnterButtonHeight() {
    return 40.0/667*kMDFScreenHeight;
};
static inline CGFloat LVMUserGuidEnterButtonMaginY() {
    return 51.0/667*kMDFScreenHeight;
};
static inline CGFloat LVMUserGuidZipperImageWidth() {
    return 335.0/375*kMDFScreenWidth;
};
static inline CGFloat LVMUserGuidZipperImageHeight() {
    return 52.5/667*kMDFScreenHeight;
};
static inline CGFloat LVMUserGuidZipperImageMargin() {
    return 90.0/667*kMDFScreenHeight;
};
static inline CGFloat LVMUserGuidZipperOpenImageWidth() {
    return 325.0/375*kMDFScreenWidth;
};
static inline CGFloat LVMUserGuidZipperHeadImageWidth() {
    return 110.0/375*kMDFScreenWidth;
};
static inline CGFloat LVMUserGuidZipperHeadImageHeight() {
    return 325.0/667*kMDFScreenWidth;
};
static inline CGFloat LVMUserGuidZipperHeadImageMaginX() {
    return kMDFScreenWidth - 40.0/375*kMDFScreenWidth -LVMUserGuidZipperHeadImageWidth() ;
};
static inline CGFloat LVMUserGuidZipperHeadImageMaginY() {
    return 12.0/375*kMDFScreenWidth;
};

@interface UserGuidView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIPageControl * pageController;
@property (nonatomic, weak) UIScrollView *lvm_scrollView;
@property (nonatomic, weak) UIImageView *lvm_zipperCloseImageView;
@property (nonatomic, weak) UIImageView *lvm_zipperOpenImageView;
@property (nonatomic, weak) UIImageView *lvm_zipperHeadImageView;
@property (nonatomic, weak) UIView *viewClip;
@property (nonatomic, strong) NSTimer *animTimer;
@property (nonatomic, assign) float lastXOffset;
@property (nonatomic, assign) int currentPage;

@end

@implementation UserGuidView

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    [self setupUserGuidView];
    return self;
}
- (void)setupUserGuidView {
    _lastXOffset = 0;
    _currentPage = 1;
    
    self.backgroundColor = [UIColor mdf_colorForKey:@"0c0a0b"];
    CGFloat originY = kMDFScreenHeight - 40;

    UIButton *buttonCover;
    for (int i = 0; i < kGuidPageNumber; i++) {
        //背景图片
        NSString * imageName = [NSString stringWithFormat:@"guid-%d.jpg", i + 1];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0 * kMDFScreenWidth, 0, kMDFScreenWidth, kMDFScreenHeight)];
        imageView.backgroundColor = [UIColor mdf_colorForKey:@"0c0a0b"];
        imageView.userInteractionEnabled = YES;
        imageView.tag = i+1;
        imageView.alpha = (i==0)?1:0;
        imageView.clipsToBounds = YES;
        [self addSubview:imageView];
        if (i==0) {
            imageView.image = [UIImage imageNamed:imageName];
            CGRect frame = CGRectMake(65, kMDFScreenHeight - kMDFScreenHeight*0.45, kMDFScreenWidth * 1.5, kMDFScreenHeight*0.45);
            UIImageView *imageViewMoveOne = [[UIImageView alloc]initWithFrame:frame];
            [imageViewMoveOne setImage:[UIImage imageNamed:@"guid-1-star"]];
            imageViewMoveOne.tag = 1 + LVMUserGuid1Tag;
            
            frame = CGRectMake(12, kMDFScreenHeight - 25 - kMDFScreenHeight*0.38, kMDFScreenHeight*0.24, kMDFScreenHeight*0.38);
            UIImageView *imageViewMoveTwo = [[UIImageView alloc]initWithFrame:frame];
            [imageViewMoveTwo setImage:[UIImage imageNamed:@"guid-1-biao"]];
            imageViewMoveTwo.tag = 2 + LVMUserGuid1Tag;
            
            [imageView addSubview:imageViewMoveOne];
            [imageView addSubview:imageViewMoveTwo];
        }else if (i==1) {
            CGRect frame = CGRectMake(15, kMDFScreenHeight - 43 - kMDFScreenHeight*0.2 , kMDFScreenHeight*0.22 , kMDFScreenHeight*0.2);
            UIImageView *imageViewTitle = [[UIImageView alloc]initWithFrame:frame];
            [imageViewTitle setImage:[UIImage imageNamed:@"guid-2-title.jpg"]];
            
            frame = CGRectMake(kMDFScreenWidth-kMDFScreenHeight*0.42 - 20, 0, kMDFScreenHeight*0.42 , kMDFScreenHeight);
            UIImageView *imageViewMoveOne = [[UIImageView alloc]initWithFrame:frame];
            [imageViewMoveOne setImage:[UIImage imageNamed:@"guid-2-fenmo.jpg"]];
            imageViewMoveOne.tag = 1 + LVMUserGuid2Tag;
            
            frame = CGRectMake(kMDFScreenWidth*0.4,  kMDFScreenHeight*0.18 , kMDFScreenHeight*0.25, kMDFScreenHeight*0.19);
            UIImageView *imageViewMoveTwo = [[UIImageView alloc]initWithFrame:frame];
            [imageViewMoveTwo setImage:[UIImage imageNamed:@"guid-2-tiane"]];
            imageViewMoveTwo.tag = 2 + LVMUserGuid2Tag;
            
            [imageView addSubview:imageViewMoveOne];
            [imageView addSubview:imageViewMoveTwo];
            [imageView addSubview:imageViewTitle];
            
        }else if (i==2) {
            CGRect frame = CGRectMake(20, 30 , kMDFScreenHeight*0.18, kMDFScreenHeight*0.3);
            UIImageView *imageViewTitle = [[UIImageView alloc]initWithFrame:frame];
            [imageViewTitle setImage:[UIImage imageNamed:@"guid-3-title.jpg"]];
            
            frame = CGRectMake(kMDFScreenWidth*0.32, 0, kMDFScreenHeight*0.26, kMDFScreenHeight - 200);
            UIImageView *imageViewMoveOne = [[UIImageView alloc]initWithFrame:frame];
            [imageViewMoveOne setImage:[UIImage imageNamed:@"guid-3-fenmo"]];
            imageViewMoveOne.tag = 1 + LVMUserGuid3Tag;
            
            frame = CGRectMake(kMDFScreenWidth*0.32, 0, kMDFScreenHeight*0.26, kMDFScreenHeight - 50);
            UIImageView *imageViewMoveTwo = [[UIImageView alloc]initWithFrame:frame];
            [imageViewMoveTwo setImage:[UIImage imageNamed:@"guid-3-suo.jpg"]];
            imageViewMoveTwo.tag = 2 + LVMUserGuid3Tag;
            
            
            [imageView addSubview:imageViewMoveTwo];
            [imageView addSubview:imageViewMoveOne];
            [imageView addSubview:imageViewTitle];
            
        }else if(i == kGuidPageNumber - 1) {
            imageView.image = [UIImage imageNamed:imageName];
            
            UIImageView *zipperCloseImageViewBK = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_userGuid_zipper_close"]];
            zipperCloseImageViewBK.frame =  CGRectMake(0,0,
                                                       LVMUserGuidZipperImageWidth(),
                                                       LVMUserGuidZipperImageHeight());
            [imageView addSubview:zipperCloseImageViewBK];
            
            UIImageView *zipperOpenImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_userGuid_zipper_open"]];
            zipperOpenImageView.frame = CGRectMake((kMDFScreenWidth - LVMUserGuidZipperImageWidth() )/2.0,
                                                   originY - LVMUserGuidEnterButtonHeight()-LVMUserGuidEnterButtonMaginY()  - LVMUserGuidZipperImageMargin(),
                                                   LVMUserGuidZipperOpenImageWidth(),
                                                   LVMUserGuidZipperImageHeight());
            
            self.lvm_zipperOpenImageView = zipperOpenImageView;
            
            [imageView addSubview:zipperOpenImageView];
            UIView *viewClip = [[UIView alloc] initWithFrame:CGRectMake((kMDFScreenWidth - LVMUserGuidZipperOpenImageWidth() )/2.0
                                                                       ,originY - LVMUserGuidEnterButtonHeight()-LVMUserGuidEnterButtonMaginY()  - LVMUserGuidZipperImageMargin(),
                                                                       LVMUserGuidZipperOpenImageWidth(),
                                                                       LVMUserGuidZipperImageHeight())];
            self.viewClip = viewClip;
            self.viewClip.clipsToBounds = YES;
            self.lvm_zipperCloseImageView = zipperCloseImageViewBK;
            [viewClip addSubview:zipperCloseImageViewBK];
            [imageView addSubview:viewClip];
            
            UIImageView *zipperHeadImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"img_userGuid_zipper_head"]];
            zipperHeadImageView.frame = CGRectMake((kMDFScreenWidth - LVMUserGuidZipperImageWidth() )/2.0 +
                                                   LVMUserGuidZipperHeadImageMaginX(),
                                                   CGRectGetMinY(viewClip.frame)+LVMUserGuidZipperHeadImageMaginY() ,
                                                   LVMUserGuidZipperHeadImageWidth(),
                                                   LVMUserGuidZipperHeadImageHeight());
            [imageView addSubview:zipperHeadImageView];
            self.lvm_zipperHeadImageView = zipperHeadImageView;
        }
    }
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kMDFScreenWidth, kMDFScreenHeight)];
    scrollView.contentSize = CGSizeMake(kMDFScreenWidth * kGuidPageNumber, kMDFScreenHeight);
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.userInteractionEnabled =YES;
    scrollView.pagingEnabled = YES;
    scrollView.panGestureRecognizer.delaysTouchesBegan = YES;
    self.lvm_scrollView = scrollView;
    [self addSubview:scrollView];
    self.pageController = [[UIPageControl alloc] init];
    [self addSubview:self.pageController ];
    self.pageController.numberOfPages = kGuidPageNumber;
    self.pageController.frame = CGRectMake(kMDFScreenWidth-50, kMDFScreenHeight-40, 20, 20);

    [self addSubview:buttonCover];
    [self animateImageView];
}

#pragma mark - handle event
- (void)enterApp:(id)sender
{
    if (self.animTimer) {
        [self.animTimer invalidate];
        self.animTimer = nil;
    }
    [UIView animateWithDuration:2.5 animations:^{
        CGRect  frame = self.viewClip.frame;
        frame.size.width = 10;
        self.viewClip.frame = frame;
        frame = self.lvm_zipperHeadImageView.frame;
        frame.origin.x = -LVMUserGuidZipperHeadImageWidth() + 50;
        self.lvm_zipperHeadImageView.frame =frame;
    }completion:^(BOOL finished) {
        [UIView animateWithDuration:2.0 animations:^{
            self.lvm_scrollView.alpha = 0.0;
            self.alpha = 0.0;
        } completion:^(BOOL finished) {
            [self.lvm_scrollView removeFromSuperview];
            [self removeFromSuperview];
            if (self.enterBlock) {
                self.enterBlock();
            }
        }];
    }];
}


#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (scrollView == self.lvm_scrollView) {
        int currentPage = self.currentPage;
        int nextPage = (scrollView.contentOffset.x >= self.lastXOffset)?currentPage + 1:currentPage - 1;
        UIView *currentPageView = [self viewWithTag:currentPage];
        UIView *nextPageView = [self viewWithTag:nextPage];
        
        float adjustedOffsetForPage = scrollView.contentOffset.x - (scrollView.frame.size.width*(currentPage-1));
        float maxOffset = scrollView.frame.size.width;
        float percentageScrolledOnCurrentPage = fabs(adjustedOffsetForPage/maxOffset);
        if (nextPage > 0 && nextPage < kGuidPageNumber + 1) {
            NSInteger pageNumber = (scrollView.contentOffset.x+0.5*kMDFScreenWidth)/kMDFScreenWidth;
                self.pageController.currentPage = pageNumber;
            if (currentPage > nextPage) {
                currentPageView.alpha = 1- percentageScrolledOnCurrentPage;
                NSLog(@"===currentPageViewAlpha==%lf===",1- percentageScrolledOnCurrentPage);
            }
            else {
                nextPageView.alpha =  percentageScrolledOnCurrentPage;
                 NSLog(@"===nextPageViewAlpha===%lf==",percentageScrolledOnCurrentPage);
            }
        }
        if (nextPage ==  kGuidPageNumber + 1) {
            _currentPage++;
            [self enterApp:nil];
        }
    }
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    scrollView.userInteractionEnabled = NO;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if(!decelerate){
        scrollView.userInteractionEnabled = YES;
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _lastXOffset = scrollView.contentOffset.x;
    _currentPage = [self currentPageCalc];
    if(_currentPage == kGuidPageNumber){
        [self.animTimer setFireDate:[NSDate distantPast]];
    }else {
        [self.animTimer setFireDate:[NSDate distantFuture]];
    }
    scrollView.userInteractionEnabled = YES;
    [self animateImageView];
}

#pragma mark - Helpers
-(int)currentPageCalc
{
    CGFloat pageWidth = self.frame.size.width;
    return floor((self.lvm_scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 2;
}
-(void)animateImageView {
    for (int i = 1; i <= kGuidPageNumber; i++) {
        NSInteger tag = 0;
        CGFloat moveX = 0;
        CGFloat moveY = 0;
        if (i == 1)  {
            tag = LVMUserGuid1Tag;
            moveX = 6;
        }
        else if (i == 2) {
            tag = LVMUserGuid2Tag;
            moveY = 6;
        }
        else if (i == 3){
            tag = LVMUserGuid3Tag;
            moveY = -6;
        }
        UIImageView *imageViewMoveOne = [self viewWithTag:1+tag];
        UIImageView *imageViewMoveTwo = [self viewWithTag:2+tag];
        imageViewMoveOne.transform = CGAffineTransformIdentity;
        imageViewMoveTwo.transform = CGAffineTransformIdentity;
        if (_currentPage == i) {
            [UIView animateWithDuration:2.0 animations:^{
                NSLog(@"==moveX==%lf=====moveY====%lf====",moveX,moveY);
                imageViewMoveOne.transform = CGAffineTransformMakeTranslation(moveX, moveY);
                imageViewMoveTwo.transform = CGAffineTransformMakeTranslation(-moveX, -moveY);
            }];
        }
    }
    
}

@end
