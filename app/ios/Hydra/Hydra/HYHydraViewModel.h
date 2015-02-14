//
//  HydraViewModel.h
//  Hydra
//
//  Created by Florian Ebeling on 08/02/15.
//  Copyright (c) 2015 Florian Ebeling. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HYHydraViewModel : NSObject

- (void)start;
- (void)stop;

- (void)refresh;
@property (nonatomic) NSArray *posts;
@property (nonatomic) BOOL running;

@end
