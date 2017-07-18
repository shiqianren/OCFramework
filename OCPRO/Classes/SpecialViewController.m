//
//  SpecialViewController.m
//  OCPRO
//
//  Created by shiqianren on 2017/7/11.
//  Copyright © 2017年 shiqianren. All rights reserved.
//

#import "SpecialViewController.h"
#import "MyLayout.h"
#import "HomeWebservice.h"
#import "FindFrameModel.h"
#import "BannerModel.h"
#import "MJExtension.h"
#import "SpecialViewCell.h"
#import "FindModel.h"
#import "NSObject+ProgressHud.h"
#define FindCellName @"HGFindCellName"
@interface SpecialViewController ()<MyLayoutDelegate,UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic , strong) UICollectionView *collectionView;
@property (nonatomic,strong) NSMutableArray *findArr;
@property (nonatomic,strong) NSMutableArray *findFrames;
@end

@implementation SpecialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self sendRequest];
	[self addSpecialView];
    // Do any additional setup after loading the view.
}

-(void)addSpecialView{
   //创建瀑布流
	MyLayout *myLayout = [[MyLayout alloc] init];
	myLayout.delegate = self;
	myLayout.columsCount =2 ;
	myLayout.sectionInset = UIEdgeInsetsMake(0, 10, 40, 10);
	UICollectionView *specialCollection = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:myLayout];
	[specialCollection registerClass:[SpecialViewCell class] forCellWithReuseIdentifier:FindCellName];
	specialCollection.backgroundColor = [UIColor whiteColor];
	specialCollection.delegate = self;
	specialCollection.dataSource = self;
	[self.view addSubview:specialCollection];
	self.collectionView = specialCollection;
}


-(void)sendRequest {
	
	[self Pro_progress];
	[[HomeWebservice shareInstance] getGoods:^(BOOL success, BaseResponse *response) {
		NSLog(@"获取的数据信息-----%@",response.object);
		
		NSMutableArray *bannerFrame=[NSMutableArray array];
		//创建frame模型
		if(self.findFrames.count<1){
			FindFrameModel *findFrame=[[FindFrameModel alloc]init];
			//2.获得广告栏  banner
			NSDictionary *tempBanner=response.object[@"banner"];
		    BannerModel *bannerModel=[BannerModel mj_objectWithKeyValues:tempBanner];
			findFrame.bannerModel=bannerModel;
			[bannerFrame addObject:findFrame];
			// NSLog(@"hahah");
		}
		
		NSMutableArray *arrayFrames=[NSMutableArray array];
		//3.获得商品展示的数据  goods_list
		NSArray *tempGoods = response.object[@"goods_list"];
		NSArray *goodsArr=[FindModel mj_objectArrayWithKeyValuesArray:tempGoods];
		NSMutableArray *arr=[NSMutableArray array];
		[arr addObjectsFromArray:goodsArr];
		[arr addObjectsFromArray:goodsArr];
		
		for(FindModel *findModel in arr) {
			FindFrameModel *findFrame=[[FindFrameModel alloc]init];
			findFrame.findModel=findModel;
			
			[arrayFrames addObject:findFrame];
		}
		
		//把新获得的数组放在前面
		NSMutableArray *tempArray=[NSMutableArray array];
		[tempArray addObjectsFromArray:arrayFrames]; //添加新的数组
		//[tempArray addObjectsFromArray:self.findFrames];
		//广告始终显示在最前面
		[self.findFrames addObjectsFromArray:bannerFrame];
		[self.findFrames addObjectsFromArray:tempArray];
		[self BA_hideProgress];
	  //重新刷新标示图
	  [self.collectionView reloadData];
	
	}];



}

-(NSMutableArray *)findArr
{
	if(!_findArr){
		_findArr=[NSMutableArray array];
	}
	return _findArr;
}

-(NSMutableArray *)findFrames
{
	if(_findFrames==nil) {
		_findFrames=[NSMutableArray arrayWithCapacity:100];
	}
	return _findFrames;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
 
	return self.findFrames.count;
}


-(CGFloat)waterFlow:(MyLayout *)waterFlow heightForWidth:(CGFloat)width indexpath:(NSIndexPath *)indexpath{
	
	FindFrameModel *frameModel = self.findFrames[indexpath.item];
	return frameModel.cellH;

}

-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
	SpecialViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:FindCellName forIndexPath:indexPath ];
	FindFrameModel *frameModel = self.findFrames[indexPath.item];
	cell.findFrameModel =frameModel;
	return cell;
	
}


-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

	NSLog(@"你当前点击了%ld那一行",indexPath.row);
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
