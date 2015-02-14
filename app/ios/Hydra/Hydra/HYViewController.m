//
//  ViewController.m
//  Hydra
//
//  Created by Florian Ebeling on 30/01/15.
//  Copyright (c) 2015 Florian Ebeling. All rights reserved.
//

#import "HYHydraViewModel.h"
#import "HYPost.h"

#import "HYViewController.h"

static NSString *const PostsKey = @"posts";

@interface HYViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
- (IBAction)refreshAction:(id)sender;
@property (nonatomic) HYHydraViewModel *viewModel;
@end

@implementation HYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.viewModel = [[HYHydraViewModel alloc] init];

    [self.viewModel addObserver:self
                     forKeyPath:PostsKey
                        options:0
                        context:NULL];

    [self.viewModel start];
}

- (void)dealloc
{
    [self.viewModel stop];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if([PostsKey isEqualToString:keyPath]) {
        [self.tableView reloadData];
    }
}

# pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.viewModel.posts.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HYPost *post = self.viewModel.posts[indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"plain" forIndexPath:indexPath];

    cell.textLabel.text = post.subject;
    cell.detailTextLabel.text = post.subject;

    return cell;
}

- (IBAction)refreshAction:(id)sender
{
    [self.viewModel refresh];
}

@end
