# XQMultistageTableView

### 多级菜单

gif 图片加载中...

![gif](https://github.com/weakGG/XQMultistageTableView/blob/master/gif/image.gif)

### 可以实现带头像带子节点，也可实现不带头像的子节点

## 通过 XQNode 设置对应的节点
```
typedef enum{  
    XQNodeContentTypeSuper, // 父节点 
    XQNodeContentTypeSub,  // 子节点  
}XQNodeContentType;  
  
@interface XQNode : NSObject  
  
#pragma 共同拥有  
/// 节点名称  
@property(nonatomic, copy) NSString *title;  
  
/// 父节点的id，如果为-1表示该节点为根节点  
@property (nonatomic , retain) NSNumber *parentId;  
  
/// 本节点的id  
@property (nonatomic , retain) NSNumber *nodeId;  
  
/// 该节点的深度  
@property (nonatomic , assign) int depth;  
  
/// 使用者id  
@property (nonatomic , retain) NSNumber *userId;  
  
/// 内容类型  
@property (nonatomic , assign) XQNodeContentType contentType;  
  
/// 图片路径  
@property (nonatomic , copy) NSString *imagePath;  
  
#pragma Super  
/// 子节点列表  
@property (nonatomic, strong) NSMutableArray *subItems;  
  
/// 该节点是否处于展开状态  
@property (nonatomic , assign) BOOL isExpand;  
  
@end  
```
## 将创建好的数据源交给 XQMultistageAdapter 管理
```
_adapter = [[XQMultistageAdapter alloc] init];  
_adapter.delegate = self;  
_adapter.multistageData = self.data;  
UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds];  
tableView.dataSource = _adapter;  
tableView.delegate = _adapter;  
[self.view addSubview:tableView];  
```
## XQMultistageAdapterDelegate
```
// 点击事件
- (void)multistageAdapter:(XQMultistageAdapter *) adapter node:(XQNode *) node didSelectRowAtIndexPath:(NSIndexPath *)indexPath;  
```
## XQMultistageCellDelegate
```
// 子 自己决定怎么显示图片  
- (void)multistageCell:(XQMultistageCell *) cell imageView:(UIImageView *) imageView forRowAtNode:(XQNode *) node;  
  
// 子 自己决定与父标题间距  
- (CGFloat)multistageCellSuperPidding:(XQMultistageCell *) cell;  
```
## ViewController
```
@implementation ViewController  
  
  
- (void)viewDidLoad {  
    [super viewDidLoad];  
      
    _adapter = [[XQMultistageAdapter alloc] init];  
    _adapter.delegate = self;  
    _adapter.multistageData = self.data;  
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds];  
    tableView.dataSource = _adapter;  
    tableView.delegate = _adapter;  
    [self.view addSubview:tableView];  
}  
  
#pragma mark - XQMultistageCellDelegate  
  
-(CGFloat)multistageCellSuperPidding:(XQMultistageCell *)cell  
{  
    return 30;  
}  
  
-(void)multistageCell:(XQMultistageCell *)cell imageView:(UIImageView *)imageView forRowAtNode:(XQNode *)node  
{  
    if (node.imagePath.length) {  
        imageView.image = [UIImage imageNamed:node.imagePath];  
    }  
}  
```

## Remind

```
ARC
iOS>=6.0
iPhone \ iPad screen anyway
```

XQKit 交流：546456937
