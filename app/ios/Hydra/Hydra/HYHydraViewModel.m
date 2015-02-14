//
//  HydraViewModel.m
//  Hydra
//
//  Created by Florian Ebeling on 08/02/15.
//  Copyright (c) 2015 Florian Ebeling. All rights reserved.
//

#import "hydra.h"
#import "HYPost.h"

#import "HYHydraViewModel.h"

@interface HYHydraViewModel ()
@property (nonatomic) NSString *documentsPath;
@property (nonatomic) hydra_t *hydra;
@property (nonatomic) dispatch_queue_t hydraQueue;
@end

@implementation HYHydraViewModel

- (instancetype)init
{
    self = [super init];
    if(self == nil) return nil;

    _hydraQueue = dispatch_queue_create ("hydra-queue", 0);

    // find "Documents" directory
    _documentsPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;

    NSLog(@"Using hydra directory: %@", _documentsPath);

    _hydra = hydra_new (_documentsPath.UTF8String);
    hydra_set_animate(_hydra);
    hydra_set_verbose(_hydra);

    return self;
}

- (void)start
{
    dispatch_async (self.hydraQueue, ^{
        int err = hydra_start (self.hydra);
        if(err == 0) {
            self.running = YES;
        } else {
            self.running = NO;
        }
    });
}

- (void)stop
{
    NSLog(@"Stopping hydra...");
    dispatch_async(self.hydraQueue, ^{
        hydra_destroy (&_hydra);
        NSLog(@"Hydra stopped.");
        assert(!_hydra);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.running = NO;
        });
    });
}

- (void)refresh
{
    NSLog(@"Refreshing view model...");
    dispatch_async(self.hydraQueue, ^{
        NSMutableArray *newPosts = NSMutableArray.array;
        hydra_post_t *post = NULL;
        while((post = hydra_fetch (_hydra))) {
            NSLog(@" - post received");
            [newPosts addObject:[[HYPost alloc] initWithPost:post]];
        }
        NSLog(@"%lu posts received; finished.", (unsigned long)newPosts.count);
        dispatch_async(dispatch_get_main_queue(), ^{
            self.posts = [newPosts copy];
        });
    });
}

@end
