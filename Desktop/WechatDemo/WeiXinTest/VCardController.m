//
//  VCardController.m
//  WeiXinTest
//
//  Created by long on 16/5/20.
//  Copyright © 2016年 long. All rights reserved.
//

#import "VCardController.h"
#import "VCardModel.h"
#import "XMPPvCardTemp.h"
#import "MyNavController.h"
#import "EditVCardViewcontroller.h"

#define VCardCell_ID @"VCardCell"
@interface VCardController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,EditVCardViewcontrollerDelegate>
@property (nonatomic,strong) NSMutableArray *allDatas;
@property (nonatomic,strong) NSMutableArray *oneSection;
@property (nonatomic,strong) NSMutableArray *twoSection;
@end

@implementation VCardController
- (NSMutableArray *)allDatas{
    if (!_allDatas) {
        _allDatas = [NSMutableArray array];
    }
    return _allDatas;
}
- (NSMutableArray *)oneSection{
    if (!_oneSection) {
        _oneSection =[NSMutableArray array];
    }
    return _oneSection;
}
- (NSMutableArray *)twoSection{
    if (!_twoSection) {
        _twoSection = [NSMutableArray array];
    }
    return _twoSection;
}
- (instancetype)init{
   
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad{
    
    [super viewDidLoad];
    
    self.title = @"个人中心";
    self.tableView.contentInset=UIEdgeInsetsMake(15, 0, 0, 0);
    [self loadUserInfo];
    
   // [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:VCardCell_ID];
    
}
#pragma mark 加载用户信息
- (void)loadUserInfo{
    
    XMPPTools *tool = [XMPPTools sharedxmpp];
    XMPPvCardTemp *temp = tool.vCard.myvCardTemp;
    //设置头像 Default--->@"DefaultProfileHead_phone"
    NSData *data = temp.photo? temp.photo:UIImageJPEGRepresentation([UIImage imageNamed:@"DefaultProfileHead_phone"], 1.0);
    VCardModel *headCard = [VCardModel VCardWithImage:data name:@"头像"];
    //设置昵称
    NSString *nickName = temp.nickname?temp.nickname: @"未设置";
    VCardModel *nickCard = [VCardModel VCardWithInfo:nickName infoType:UserNickName name:@"昵称"];
    //设置微信号
    UserOperation *user = [UserOperation shareduser];
    NSString *account = user.uname;
    VCardModel *accountCard = [VCardModel VCardWithInfo:account infoType:UserWeixinNum name:@"微信号"];
    [self.oneSection addObjectsFromArray:@[headCard,nickCard,accountCard]];
    [self.allDatas addObject:_oneSection];
    
    //公司
    NSString *company = temp.orgName?temp.orgName:@"未设置";
    VCardModel *companyCard = [VCardModel VCardWithInfo:company infoType:UserCompany name:@"公司"];
    //部门
    NSString *depart = temp.orgUnits.count>0? temp.orgUnits.firstObject:@"未设置";
    VCardModel *departCard = [VCardModel VCardWithInfo:depart infoType:UserDepartment name:@"部门"];
    
    //6.职位
    NSString *worker = temp.title?temp.title:@"未设置";
    VCardModel *workCard = [VCardModel VCardWithInfo:worker infoType:UserWorker name:@"职位"];
    
    //7.电话
    // myVCard.telecomsAddresses 这个get方法，没有对电子名片的xml数据进行解析
    // 使用note字段充当电话
    NSString *tel=temp.note?temp.note:@"未设置";
    VCardModel *telCard=[VCardModel VCardWithInfo:tel infoType:UserTel name:@"电话"];
    //7.邮件
    // 用mailer充当邮件
    NSString *email=temp.mailer?temp.mailer:@"未设置";
    VCardModel *emailCard=[VCardModel VCardWithInfo:email infoType:UserEmail name:@"邮箱"];
    [self.twoSection addObjectsFromArray:@[companyCard,departCard,workCard,telCard,emailCard]];
    [self.allDatas addObject:_twoSection];
    
}
#pragma mark  UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.allDatas.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSArray *arr=self.allDatas[section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:VCardCell_ID];
    if(cell==nil){
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:VCardCell_ID];
    }
    VCardModel *vcard = self.allDatas[indexPath.section][indexPath.row];
    if (vcard.image) {
        UIImageView *headView = [[UIImageView alloc]initWithImage:[UIImage imageWithData:vcard.image]];
        headView.frame = CGRectMake(0, 0, 50, 50);
        cell.accessoryView = headView;
    }
    cell.textLabel.text = vcard.name;
    
    cell.detailTextLabel.text = vcard.info;

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    VCardModel *vcard = self.allDatas[indexPath.section][indexPath.row];
    if (vcard.image) {
        return 80;
    }
    
    return 44;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 2;
}
#pragma mark 点击单元格执行的方法
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    VCardModel *vcard = self.allDatas[indexPath.section][indexPath.row];
    if (vcard.image) {
        [self setupActionSheet];//提醒用户选择图片来源方式.
    }
    
    [self presentVc:indexPath];//跳转界面
    
}
- (void)presentVc:(NSIndexPath *)indexPath{
    VCardModel *vcard = self.allDatas[indexPath.section][indexPath.row];
    EditVCardViewcontroller *editVc = [EditVCardViewcontroller new];
    editVc.content = [vcard.info isEqualToString:@"未设置"]?@"":vcard.info;
    editVc.indexPath = indexPath;
    editVc.title = vcard.name;
    editVc.delegate = self;
    MyNavController *nav = [[MyNavController alloc]initWithRootViewController:editVc];
    [self presentViewController:nav animated:YES completion:nil];
    
}
#pragma mark 把设置好的信息回传 EditVCardViewcontrollerDelegate
- (void)EditingFinished:(EditVCardViewcontroller *)edit indexPath:(NSIndexPath *)indexPath newInfo:(NSString *)newInfo{
    NSLog(@"%@",newInfo);
    VCardModel *vcard = self.allDatas[indexPath.section][indexPath.row];
    vcard.info = newInfo;//重新设置用户信息
    
    [self addVCardModel:vcard newInfo:newInfo];//保存信息
    [self.tableView reloadData];
    
    
}
- (void)addVCardModel:(VCardModel *)vcard newInfo:(NSString *)newinfo{
    
    XMPPTools *tool = [XMPPTools sharedxmpp];
    XMPPvCardTemp *temp = tool.vCard.myvCardTemp;//电子名片
    
    switch (vcard.infoType) {
        case UserNickName:
            temp.nickname = newinfo;
            break;
        case UserWeixinNum:
            //temp.uid = newinfo;
            //b不需要做操作
            break;
        case UserCompany:
            temp.orgName = newinfo;
            break;
        case UserDepartment:
            temp.nickname = newinfo;
            if (newinfo.length>0) {
                temp.orgUnits = @[newinfo];
            }
            break;
        case UserWorker:
            temp.title = newinfo;
            break;
        case UserTel:
            temp.note = newinfo;
            break;
        case UserEmail:
            temp.note = newinfo;
            break;
            
        default:
            break;
    }
    
    
    
    
    
}
#pragma mark 设置头像
- (void)setupActionSheet{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"选择图片来源" message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    //取消按钮
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    [alert addAction:cancel];
    
    UIAlertAction *destructive = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        //跳入相册
        [self openCameraCaptureWith:UIImagePickerControllerSourceTypeCamera];

        
    }];
    [alert addAction:destructive];
    
    UIAlertAction *photoAlbum = [UIAlertAction actionWithTitle:@"从手机相册中选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //打开相册
        [self openCameraCaptureWith:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    
    }];
    [alert addAction:photoAlbum];
    
    [self presentViewController:alert animated:YES completion:nil];
}
- (void)openCameraCaptureWith:(UIImagePickerControllerSourceType)sourceType{
    
    UIImagePickerController *imgPicker = [[UIImagePickerController alloc]init];
    imgPicker.delegate = self;
    imgPicker.allowsEditing = YES;
    
    imgPicker.sourceType = sourceType;
    
    [self presentViewController:imgPicker animated:YES completion:nil];
    
}
#pragma mark UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    UIImage *image = info[UIImagePickerControllerEditedImage];
    
    VCardModel *vcard = self.allDatas[0][0];
    vcard.image = UIImageJPEGRepresentation(image, 1.0);
    [self saveHeadImage:UIImageJPEGRepresentation(image, 0.7)];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
    
}
#pragma mark 保存头像
- (void)saveHeadImage:(NSData *)data{
    
    XMPPTools *tools = [XMPPTools sharedxmpp];
    XMPPvCardTemp *temp = tools.vCard.myvCardTemp;
    temp.photo = data;
    VCardModel *vcard = self.allDatas[0][0];
    vcard.image = data;

    [self.tableView reloadData];
    [tools.vCard updateMyvCardTemp:temp]; //更新 这个方法内部会实现数据上传到服务，无需程序自己操作,//保存头像到服务器
    //发送通知
    NSNotification *notif = [[NSNotification alloc]initWithName:changeHeadNameNotif object:data userInfo:nil];
    [Mynotification postNotification:notif];
    
}
@end
