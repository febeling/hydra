//
//  HYPost.m
//  Hydra
//
//  Created by Florian Ebeling on 08/02/15.
//  Copyright (c) 2015 Florian Ebeling. All rights reserved.
//

#import "hydra.h"

#import "HYPost.h"

@interface HYPost ()
@property (nonatomic) hydra_post_t *post;
@end

@implementation HYPost

- (instancetype)initWithPost:(hydra_post_t *)post
{
    NSParameterAssert(post);

    self = [super init];
    if(self == nil) return nil;

    _post = post;
   
    return self;
}

- (void)dealloc
{
    hydra_post_destroy (&_post);
}

- (NSString *)subject
{
    return [NSString stringWithUTF8String:hydra_post_subject (_post)];
}

//@property (nonatomic, readonly) NSDate *timestamp;

- (NSString *)mimeType
{
    return [NSString stringWithUTF8String:hydra_post_mime_type (_post)];
}

- (NSString *)identifier
{
    return [NSString stringWithUTF8String:hydra_post_ident (_post)];
}

- (NSInteger)size
{
    return (NSInteger)hydra_post_content_size (_post);
}

//@property (nonatomic, readonly) NSData *content;

- (NSString *)location
{
    return [NSString stringWithUTF8String:hydra_post_location (_post)];
}

- (NSString *)digest
{
    return [NSString stringWithUTF8String:hydra_post_digest (_post)];
}

@end
