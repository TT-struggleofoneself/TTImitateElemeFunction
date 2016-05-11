//
//  ViewController.m
//  TTImitateElemeFunction
//
//  Created by TT_code on 16/4/22.
//  Copyright © 2016年 TT_code. All rights reserved.
//

#import "ViewController.h"
#import "TTTabelview.h"
#import "TTScrollview.h"



@interface ViewController ()<UIScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView* tableview;
@property(nonatomic,strong)UISearchBar* searbar;
@property(nonatomic,strong)UIScrollView* scrollview;
@end

@implementation ViewController
static NSString* idetifier=@"mycell";
- (void)viewDidLoad {
    [super viewDidLoad];
    //基础设置
    self.title=@"饿了么";
    self.view.backgroundColor=[UIColor whiteColor];
    
    //设置导航栏
   [self setNavigationBar];
    
    //增加tablevieww
    [self addtableview];
    
    //增加 headview
    [self addheadview];
    
    // 设置 contentsize
    self.scrollview.contentSize=CGSizeMake([UIScreen mainScreen].bounds.size.width, self.scrollview.bounds.size.height+44);
    
}


/**
 *  设置导航栏
 */
-(void)setNavigationBar{
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.translucent=NO;
//    self.view.autoresizingMask=UIViewAutoresizingNone;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage imageNamed:@"backimage"] resizableImageWithCapInsets:UIEdgeInsetsMake(2, 2, 2, 2) resizingMode:UIImageResizingModeStretch] forBarMetrics:UIBarMetricsDefault];
    self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"search"] style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem.tintColor=[UIColor whiteColor];
    self.navigationItem.leftBarButtonItem.tintColor=[UIColor whiteColor];
     self.navigationItem.rightBarButtonItem.tintColor=[UIColor whiteColor];
}


/**
 *  增加 scrollview
 */
-(void)addscrollview
{
    self.scrollview=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 64,[UIScreen mainScreen].bounds.size.width , [UIScreen mainScreen].bounds.size.height-64)];
    self.scrollview.delegate=self;
    self.scrollview.backgroundColor=[UIColor greenColor];
    self.scrollview.userInteractionEnabled=YES;
    [self.view addSubview:self.scrollview];
}


/**
 *  增加 tableview
 */
-(void)addtableview
{
    self.tableview=[[UITableView alloc]initWithFrame:CGRectMake(0, 0,[UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height-64)];
    self.tableview.delegate=self;
    self.tableview.dataSource=self;
    [self.tableview registerClass:[UITableViewCell class] forCellReuseIdentifier:idetifier];
    self.tableview.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.tableview];
}


/**
 *  add  headview
 */
-(void)addheadview
{
    //曲线救国方式-----
    [self.searbar removeFromSuperview];
    self.searbar=nil;
    UISearchBar* searchbar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 44)];
    self.searbar=searchbar;
    searchbar.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"backimage"]];
    searchbar.tintColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"backimage"]];
     self.tableview.tableHeaderView=self.searbar;
}






#pragma mark-《tableview  delegate-or-datasource》
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:idetifier];
    cell.textLabel.text=[NSString stringWithFormat:@"我是第%ld  cell",indexPath.row];
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}



/**
 *  监听滚动
 *
 *  @param scrollView
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"打印偏移量:%lf",offsetY);
    
    if(offsetY<0){//搜索框不动
       [self setNavigationBar];
        [self.view addSubview:self.searbar];
    }else{//动
        [self addheadview];
        if(offsetY>=44){
             self.navigationItem.rightBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:nil];
        }
    }
}



@end
