# XQMultistageTableView

--------------------------
## 1. 多级菜单
## 2. 多选/单选
## 3.三种Cell样式<Base 基础、Default 默认、Custom 自定义>
    
------------------------------------


gif 图片加载中...

![gif](https://github.com/weakGG/XQMultistageTableView/blob/master/gif/image.gif)

### 可以实现带头像带子节点，也可实现不带头像的子节点

## CocoaPods

```
pod 'XQMultistageTableView', '~> 1.0.6'
```

```
#import "XQMultistage.h"
```

## XQMultistage 提供三种Cell样式

### 1、Base 基础

#### 使用 XQMultistageAdapter 管理适配器
```
- (void)viewDidLoad {
    [super viewDidLoad];

    _adapter = [[XQMultistageAdapter alloc] init];
    _adapter.radio = YES;
    _adapter.delegate = self;
    _adapter.multistageData = self.data;
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = _adapter;
    tableView.delegate = _adapter;
    [self.view addSubview:tableView];
}
```


### 2、Default 默认

#### 使用 XQMultistageAdapter 管理适配器
```
- (void)viewDidLoad {
    [super viewDidLoad];
    _adapter = [[XQMultistageDefaultAdapter alloc] init];
    _adapter.delegate = self;
    _adapter.multistageData = self.data;
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = _adapter;
    tableView.delegate = _adapter;
    [self.view addSubview:tableView]; 
}
```

### 3、Custom 自定义 ～随心所欲 ～

#### 使用 XQMultistageAdapter 管理适配器
```
- (void)viewDidLoad {
    [super viewDidLoad];

    _adapter = [[XQMultistageAdapter alloc] init];
    _adapter.radio = YES;
    _adapter.delegate = self;
    _adapter.multistageData = self.data;
    UITableView * tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.dataSource = _adapter;
    tableView.delegate = _adapter;
    [self.view addSubview:tableView];
}

#pragma mark - XQMultistageCellDelegate
/*
 * 自定义Cell
 */
- (XQMultistageCell *)xq_multistageAdapter:(XQMultistageAdapter *)adapter tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * ID = @"QMultistage";

    CustomTypeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (!cell) {
        cell = [[CustomTypeViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }

    return cell;
}


```

#### 使用 CustomTypeViewCell 配置页面
```

/**
 * 可以重写 setting 方法，对Cell进行改造
 * 也可继承 XQMultistageNode， 在使用时在转换回自的 model
 */
@implementation CustomTypeViewCell

-(void)setNode:(XQMultistageNode *)node
{
    [super setNode:node];
    
    // 此处.....
}

@end

```




## 通过 XQNode 设置对应的节点
```
typedef enum{
    XQNodeContentTypeSuper,
    XQNodeContentTypeSub,
}XQNodeContentType;

typedef void(^SelectedStateChangeBlock)(BOOL);

@interface XQNode : NSObject

#pragma 共同拥有
/// 节点名称
@property(nonatomic, copy) NSString *title;

/// 父节点的id，如果为-1表示该节点为根节点
@property (nonatomic , retain) NSString *parentId;

/// 本节点的id
@property (nonatomic , retain) NSString *nodeId;

/// 该节点的深度
@property (nonatomic , assign) NSInteger depth;

/// 内容类型
@property (nonatomic , assign) XQNodeContentType contentType;

/// 是否可以选
@property (nonatomic , assign) BOOL selectState;

/// 当前是否需选择
@property (nonatomic , assign) BOOL currentSelected;

/// 选中状态改变回调
@property (nonatomic , strong) SelectedStateChangeBlock selectedStateChange;

#pragma Super
/// 子节点列表
@property (nonatomic, strong) NSMutableArray *subItems;

/// 该节点是否处于展开状态
@property (nonatomic , assign) BOOL isExpand;
  
@end  
```

## XQMultistageAdapterDelegate
```
// 是否关闭子节点 默认是 NO
- (BOOL)xq_multistageAdapterShouldCloseSubNode:(XQMultistageAdapter *) adapter;

// 父节点可不可以点击 默认是 NO
- (BOOL)xq_multistageAdapterUnClickSuperNode:(XQMultistageAdapter *) adapter;

// cell 点击事件
- (void)xq_multistageAdapter:(XQMultistageAdapter *) adapter didSelectRowAtNode:(XQMultistageNode *) node;

// 选择展示功能 -> 状态改变
- (void)xq_multistageAdapter:(XQMultistageAdapter *) adapter didSelectStateChangeAtNode:(XQMultistageNode *) node selectState:(BOOL) state;

// 行高
- (CGFloat)xq_multistageAdapter:(XQMultistageAdapter *) adapter heightForRowAtNode:(XQMultistageNode *) node;

// 自定义 cell
- (XQMultistageCell *)xq_multistageAdapter:(XQMultistageAdapter *) adapter tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
```
## XQMultistageDefaultAdapterDelegate
```
// 自定义内容左边内边距
// 可通过 XQMultistageNode -> depth 获取到当前层级决定缩紧长度
- (CGFloat)xq_multistageDefaultAdapterToContentLeftInset:(XQMultistageDefaultAdapter *) adapter;

/**
* 多级展示节点展开提示图片功能代理
* 节点展开提示 是在 Cell 的左边
*/

// 根节点展开提示图片图片
- (UIImage *)xq_multistageDefaultAdapterToRootExpandTipImage:(XQMultistageDefaultAdapter *) adapter;

// 节点展开提示图片图片
- (UIImage *)xq_multistageDefaultAdapterToExpandTipImage:(XQMultistageDefaultAdapter *) adapter;

// 根节点展开提示图片 是否可以旋转
- (BOOL)xq_multistageDefaultAdapterToRootExpandTipImageIsRotation:(XQMultistageDefaultAdapter *) adapter;

/**
* 多级展示选择功能代理
* 节点选择图片是在 Cell 的右边
*/

// 是否启用选择展示功能 配合 XQMultistageNode->selectState 使用
- (BOOL)xq_multistageDefaultAdapterToSelectOperation:(XQMultistageDefaultAdapter *) adapter;

// 选择展示功能 -> 选中状态图片
- (UIImage *)xq_multistageDefaultAdapterToImageStateSelected:(XQMultistageDefaultAdapter *) adapter;

// 选择展示功能 -> 未选中状态图片
- (UIImage *)xq_multistageDefaultAdapterToImageStateNormal:(XQMultistageDefaultAdapter *) adapter; 
```
  

## Remind

```
ARC
iOS>=6.0
iPhone \ iPad screen anyway
```

# XQKit QQ交流：546456937
