//
//  ViewController.m
//  WaterFallFlow
//
//  Created by colin liao on 15/6/12.
//  Copyright (c) 2015年 colin liao. All rights reserved.
//


#import "ViewController.h"
#define WL_XIB(string) ([[[NSBundle mainBundle] loadNibNamed:string owner:nil options:nil] lastObject])
#define WL_NIB(key) ([UINib nibWithNibName:key bundle:nil])
#import "WaterFallFlowCollectionViewCell.h"
#import "WaterFallFlowCollectionReusableView.h"
#import "WaterFallFlowCollectionViewFlowLayout.h"
NSString* kWaterFallFlowCollectionViewCell = @"WaterFallFlowCollectionViewCell";
NSString* kWaterFallFlowCollectionReusableView = @"WaterFallFlowCollectionReusableView";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,weak)IBOutlet UICollectionView* waterFallFlowCollectionView;
@property(nonatomic,strong)NSMutableArray* itemArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.waterFallFlowCollectionView.delegate = self;
    self.waterFallFlowCollectionView.dataSource = self;
    
    
    self.itemArray = [NSMutableArray array];
    
    for (int i = 0; i < 15; i++) {
        int index =  (arc4random()+1)%3;
        Item* item =  [[Item alloc] init];
        if (1  == index) {
            
            item.height = 5;
        }else if(2 == index)
        {
            item.height = 10;
        }else
        {
            item.height = 8;
        }
        item.width = 100;
        [self.itemArray addObject:item];
    }
    
    
    
    NSMutableArray* flowLayoutArray = [NSMutableArray array];
    for (int i = 0; i< 3; i++) {
        SectionItem* item = [[SectionItem alloc] init];
        item.section = i;
        item.minimumInteritemSpacing = 10;
        item.minimumLineSpacing = 10;
        item.insets = UIEdgeInsetsMake(10, 10, 10, 10);
        item.listAmount = i+1;
        item.headerType = SupplementType_ALL;
        item.footerType = SupplementType_ALL;
        item.itemArray = self.itemArray;
        [flowLayoutArray addObject:item];
    }
    
    WaterFallFlowCollectionViewFlowLayout* flowLayout = [[WaterFallFlowCollectionViewFlowLayout alloc] initWithSectionArray:flowLayoutArray];
    
    self.waterFallFlowCollectionView.collectionViewLayout = flowLayout;
    
    
    [self.waterFallFlowCollectionView registerNib:WL_NIB(kWaterFallFlowCollectionViewCell) forCellWithReuseIdentifier:kWaterFallFlowCollectionViewCell];
    [self.waterFallFlowCollectionView registerNib:WL_NIB(kWaterFallFlowCollectionReusableView) forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:kWaterFallFlowCollectionReusableView];
    [self.waterFallFlowCollectionView registerNib:WL_NIB(kWaterFallFlowCollectionReusableView) forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:kWaterFallFlowCollectionReusableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.itemArray.count;
}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterFallFlowCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:kWaterFallFlowCollectionViewCell forIndexPath:indexPath];
    return cell;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    WaterFallFlowCollectionReusableView* view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:kWaterFallFlowCollectionReusableView forIndexPath:indexPath];
    return view;
}


-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"%f-------%f",scrollView.contentSize.width,scrollView.contentSize.height);
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"%f-------%f",scrollView.contentSize.width,scrollView.contentSize.height);
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%f-------%f",self.waterFallFlowCollectionView.contentSize.width,self.waterFallFlowCollectionView.contentSize.height);
    NSLog(@"%@",self.waterFallFlowCollectionView);
}

//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(320, 50);
//}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section
//{
//    return CGSizeMake(320, 50);
//}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end


