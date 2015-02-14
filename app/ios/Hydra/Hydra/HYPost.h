//
//  HYPost.h
//  Hydra
//
//  Created by Florian Ebeling on 08/02/15.
//  Copyright (c) 2015 Florian Ebeling. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "hydra.h"

@interface HYPost : UIView

- (instancetype)initWithPost:(hydra_post_t *)post;

@property (nonatomic, readonly) NSString *subject;
@property (nonatomic, readonly) NSDate *timestamp;
@property (nonatomic, readonly) NSString *mimeType;
@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) NSInteger size;
@property (nonatomic, readonly) NSData *content;
@property (nonatomic, readonly) NSString *location;
@property (nonatomic, readonly) NSString *digest;

@end
