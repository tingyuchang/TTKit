//
//  TTFlowLayout.m
//  TTKit
//
//  Created by TinTint on 13/9/10.
//  Copyright (c) 2013年 TinTint. All rights reserved.
//

#import "TTFlowLayout.h"

@implementation TTFlowLayout

- (id)init{
    
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(80,80);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 邊緣
        self.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        self.minimumLineSpacing = 0;
        self.minimumInteritemSpacing = 0;
    }
    
    return self;
}


@end
