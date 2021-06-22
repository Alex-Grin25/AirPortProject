//
//  MainViewController.m
//  AirPortG5
//
//  Created by Alexander Grigorev on 22.06.2021.
//

#import "MainViewController.h"
#import "DataManager.h"

@interface MainViewController ()
@property (strong, nonatomic) UIButton *button;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.num == nil)
        self.num = @1;
    self.title = [NSString stringWithFormat:@"Controller %@", self.num];
    
    self.button = [UIButton new];
    CGSize size = CGSizeMake(self.view.frame.size.width * 0.8, self.view.frame.size.height * 0.1);
    CGPoint origin = CGPointMake((self.view.frame.size.width - size.width) / 2, (self.view.frame.size.height - size.width) / 2);
    self.button.frame = CGRectMake(origin.x, origin.y, size.width, size.height);
    [self.button setTitle:@"Navigate" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.button.hidden = YES;
    [self.view addSubview:self.button];
    [self.button addTarget:self action:@selector(navigate) forControlEvents:UIControlEventTouchUpInside];
    
    
    [[DataManager sharedInstance] loadData];
    self.view.backgroundColor = UIColor.cyanColor;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadDidComplete) name:kDataManagerLoadDataDidComplete object:nil];
}

- (void) loadDidComplete {
    self.view.backgroundColor = UIColor.greenColor;
    self.button.hidden = NO;
}

- (void) navigate {
    MainViewController *vc = [MainViewController new];
    vc.num = @(self.num.intValue + 1);
    [self.navigationController pushViewController:vc animated:YES];
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}





@end
