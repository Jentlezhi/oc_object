			
## YYAMapManager的集成

### 1.设置ApiKey

`YYAMapServices.apiKey = @"apiKey";`

### 2.添加地图
```
UIView *mapView = [YYAMapManager manager].mapView;
[self.view addSubview: mapView];
```

### 3.添加大头针
```
    ///起点
    YYAMapPoint *startPoint = [YYAMapPoint locationWithLatitude:39.993135 longitude:116.474175];
    startPoint.showPinAnnotationView = YES;
    startPoint.pinTitle = @"起点";
    startPoint.pinColor = YYPinAnnotationColorRed;
    self.mapManager.config.startPoint = startPoint;
    
    ///途经点
    YYAMapPoint *wayPoint = [YYAMapPoint locationWithLatitude:39.94003 longitude:116.327424];
    wayPoint.showPinAnnotationView = YES;
    wayPoint.pinTitle = @"途经点";
    wayPoint.pinColor = YYPinAnnotationColorPurple;
    self.mapManager.config.wayPoint = wayPoint;
    
    ///终点
    YYAMapPoint *endPoint = [YYAMapPoint locationWithLatitude:39.908791 longitude:116.321257];
    endPoint.showPinAnnotationView = YES;
    endPoint.pinTitle = @"终点";
    endPoint.pinColor = YYPinAnnotationColorGreen;
    self.mapManager.config.endPoint = endPoint;
```

### 4.自定义规划路线相关配置
```
    
```


## 高德地图集成

### 1. [获取Key](https://lbs.amap.com/api/ios-navi-sdk/guide/create-project/get-key)

### 2.[集成和部署](https://lbs.amap.com/api/ios-navi-sdk/guide/create-project/cocoapods)

### 3.[权限配置](https://lbs.amap.com/api/ios-navi-sdk/guide/create-project/location-positioning-statement)

#### 定位权限（必选）

##### **1、iOS8.\***

- 前台定位
  - 需要在info.plist配置NSLocationWhenInUseUsageDescription字段；
  - 注意：此权限下，如果Xcode勾选 Capabilities -> UIBackgroundModes > Location updates，则app退到后台仍可获取定位数据，但此时在手机上方会有定位小蓝条提示；
- 后台定位
  - 需要在info.plist配置NSLocationAlwaysUsageDescription字段；
  - 需要Xcode勾选 Capabilities -> UIBackgroundModes > Location updates；

##### **2、iOS9.\*与iOS10.\***

- 前台定位
  - 需要在info.plist配置NSLocationWhenInUseUsageDescription字段； 
  - 注意：此权限下，如果Xcode勾选 Capabilities -> UIBackgroundModes > Location updates并且allowsBackgroundLocationUpdates设为YES，则app退到后台仍可获取定位数据，但此时在手机上方会有定位小蓝条提示；
- 后台定位
  - 需要在info.plist配置NSLocationAlwaysUsageDescription字段；
  - 需要Xcode勾选 Capabilities -> UIBackgroundModes > Location updates；
  - 需要设置allowsBackgroundLocationUpdates为YES；
- 与iOS8.*版本相比不同点
  - iOS9.*后台增加了allowsBackgroundLocationUpdates属性，可以认为在iOS8.*下allowsBackgroundLocationUpdates永远为YES；

##### **3、iOS11.\*与iOS12.\***

- 前台定位
  - 需要在info.plist配置NSLocationWhenInUseUsageDescription字段；
  - 注意：此权限下，如果Xcode勾选 Capabilities -> UIBackgroundModes > Location updates并且allowsBackgroundLocationUpdates设为YES，则app退到后台仍可获取定位数据，但此时在手机上方会有定位小蓝条提示，此小蓝条不可隐藏；
- 后台定位
  - 需要在info.plist配置NSLocationWhenInUseUsageDescription、NSLocationAlwaysAndWhenInUseUsageDescription字段；
  - 需要Xcode勾选 Capabilities -> UIBackgroundModes > Location updates；
  - 需要设置allowsBackgroundLocationUpdates为YES；
  - 注意：此权限下，当app在后台时，系统默认不展示定位小蓝条，可通过showsBackgroundLocationIndicator控制小蓝条是否显示；
- 与iOS10.*版本相比不同点
  - iOS11.*变更了后台定位权限配置字段；
  - iOS11.*以后如果申请后台定位，info.plist需要同时配置NSLocationWhenInUseUsageDescription、NSLocationAlwaysAndWhenInUseUsageDescription两个字段；
  - iOS11.*增加了showsBackgroundLocationIndicator属性，当拥有后台定位权限时，用于控制定位小蓝条是否显示。可以认为在iOS10.*之前showsBackgroundLocationIndicator永远为NO； 

##### **4、iOS13.\***

- 前台定位
  - 需要在info.plist配置NSLocationWhenInUseUsageDescription字段；
  - 注意：权限申请弹窗与之前版本不一致，新增了允许一次选项；如果用户选择允许一次后，下次在使用app时，仍可重新调用API申请定位权限；如下图 

![img](https://a.amap.com/lbs/static/img/4%E3%80%81%E5%89%8D%E5%8F%B0%E5%AE%9A%E4%BD%8D.png)

- 后台定位
  - 需要在info.plist配置NSLocationWhenInUseUsageDescription、NSLocationAlwaysAndWhenInUseUsageDescription字段；
  - 需要Xcode勾选 Capabilities -> UIBackgroundModes > Location updates；
  - 需要设置allowsBackgroundLocationUpdates为YES；
- 与iOS12.*版本相比不同点
  - 使用应用期间的定位权限增加了允许一次选项；
  - 不能直接申请后台定位权限，需要用户先选择应用使用期间的定位权限后，在进行权限升级；

##### **5、iOS14.\***

- 前台定位
  - 需要在info.plist配置NSLocationWhenInUseUsageDescription字段；
  - 注意：权限申请弹窗与之前版本不一致，新增了精确位置开关，新增了小地图展示当前位置；小地图的显示，支持在手机定位设置中选择，如果选择关闭不显示则手机中所有app都不显示此小地图。如下图 ：

![img](https://a.amap.com/lbs/static/img/5%E3%80%81%E5%89%8D%E5%8F%B0%E5%AE%9A%E4%BD%8D1.png)

![img](https://a.amap.com/lbs/static/img/5%E3%80%81%E5%89%8D%E5%8F%B0%E5%AE%9A%E4%BD%8D.png)

![img](https://a.amap.com/lbs/static/img/5%E3%80%81%E5%89%8D%E5%8F%B0%E5%AE%9A%E4%BD%8D3.png)

- 后台定位
  - 需要在info.plist配置NSLocationWhenInUseUsageDescription、NSLocationAlwaysAndWhenInUseUsageDescription字段；
  - 需要Xcode勾选 Capabilities -> UIBackgroundModes > Location updates；
  - 需要设置allowsBackgroundLocationUpdates为YES；
- 新增精度权限
  - 需要在info.plist配置NSLocationTemporaryUsageDescriptionDictionary，如下：

Objective-C

```xml
<key>NSLocationTemporaryUsageDescriptionDictionary</key>
<dict>
  <key>ExampleUsageDescription</key>
  <string>This app needs accurate location so it can verify that you are in a supported region.</string>
  <key>AnotherUsageDescription</key>
  <string>This app needs accurate location so it can show you relevant results.</string>
</dict>
```

Objective-C

- 新增属性字段@property (nonatomic, readonly) CLAccuracyAuthorization accuracyAuthorization API_AVAILABLE(ios(14.0), macos(11.0), watchos(7.0), tvos(14.0))；可以获取当前的定位精度权限。
- 在app已经获得定位权限之后，并且当前用户选择的是模糊定位，则允许应用申请一次临时精确定位权限，申请api为- (void)requestTemporaryFullAccuracyAuthorizationWithPurposeKey:(NSString *)purposeKey completion:(void(^)(NSError *))completion; 其中purposeKey既为plist中配置字典中的key，可以有多个，对应app中不同的定位需求场景；**注意：**此API不能用于申请定位权限，只能用于从模糊定位升级为精确定位；申请定位权限只能调用requestWhen或requestAlways，如果没有获得定位权限，直接调用此API无效。如下图：

![img](https://a.amap.com/lbs/static/img/api%E6%97%A0%E6%95%88.png)

- 如果app默认不使用精确定位，则可以在info.plist中配置NSLocationDefaultAccuracyReduced字段，配置该字段后，申请定位权限的小地图中不在有精确定位的开关，即为关。如下面图示
  - 需要注意该字段类型为Boolean，如果为其他类型则不起效；
  - 配置该字段后，申请定位权限的小地图左上角则没有精确开关，默认关闭，如下面图示。但是如果info.plist中配置了NSLocationTemporaryUsageDescriptionDictionary，则仍可以申请临时的精确定位权限；

Objective-C

```xml
<key>NSLocationDefaultAccuracyReduced</key> <true/>
```

Objective-C

![img](https://a.amap.com/lbs/static/img/%E6%B5%8B%E8%AF%95.png)

- 与iOS13.*版本相比不同点
  - 权限申请弹窗与之前版本不一致；
  - 新增精度权限相关plist设置、授权、读取；
  - 新增临时一次从模糊定位升级精确定位API；
  - 新增定位权限变更回调；

##### **7、总结**

- 定位权限注意事项
  - iOS11以后如果申请后台定位，info.plist需要同时配置NSLocationWhenInUseUsageDescription、NSLocationAlwaysAndWhenInUseUsageDescription两个字段；
  - 自2019年下半年起，苹果商店上架app对后台定位权限增加限制，如果info.plist中不包含NSLocationAlwaysUsageDescription/NSLocationAlwaysAndWhenInUseUsageDescription字段，则在app代码中不能出现符号requestAlwaysAuthorization，否则上架审核不通过；
- **Info.plist 中的字段总结**

| iOS版本 | NSLocationWhenInUseUsageDescription | NSLocationAlwaysUsageDescription | NSLocationAlwaysAndWhenInUseUsageDescription | NSLocationTemporaryUsageDescriptionDictionary |
| ------- | ----------------------------------- | -------------------------------- | -------------------------------------------- | --------------------------------------------- |
| iOS 8   | YES                                 | YES                              | ×                                            | ×                                             |
| iOS 9   | YES                                 | YES                              | ×                                            | ×                                             |
| iOS 10  | YES                                 | YES                              | ×                                            | ×                                             |
| iOS 11  | YES                                 | ×                                | YES                                          | ×                                             |
| iOS 12  | YES                                 | ×                                | YES                                          | ×                                             |
| iOS 13  | YES                                 | ×                                | YES                                          | ×                                             |
| iOS 14  | YES                                 | ×                                | YES                                          | YES                                           |

- **不同系统版本调用定位权限API差异**

**iOS8.0** 

| -                             | Capabilities 关                      | Capabilities 开                    |
| ----------------------------- | ------------------------------------ | ---------------------------------- |
| requestAlwaysAuthorization    | 可以前台定位、不可以后台定位、无蓝条 | 可以前台定位、可以后台定位、无蓝条 |
| requestWhenInUseAuthorization | 可以前台定位、不可以后台定位、无蓝条 | 可以前台定位、可以后台定位、有蓝条 |
| 无/用户拒绝                   | 无任何定位                           | 无任何定位                         |

**iOS9.0 - iOS12.0**

| Capabilities 关                   | Capabilities 开                      |                                   |                                      |                                    |
| --------------------------------- | ------------------------------------ | --------------------------------- | ------------------------------------ | ---------------------------------- |
| allowsBackgroundLocationUpdates关 | allowsBackgroundLocationUpdates开    | allowsBackgroundLocationUpdates关 | allowsBackgroundLocationUpdates开    |                                    |
| requestAlwaysAuthorization        | 可以前台定位、不可以后台定位、无蓝条 | iOS抛出Crash                      | 可以前台定位、不可以后台定位、无蓝条 | 可以前台定位、可以后台定位、无蓝条 |
| requestWhenInUseAuthorization     | 可以前台定位、不可以后台定位、无蓝条 | iOS抛出Crash                      | 可以前台定位、不可以后台定位、无蓝条 | 可以前台定位、可以后台定位、有蓝条 |
| 无/用户拒绝                       | 无任何定位                           | iOS抛出Crash                      | 无任何定位                           | 无任何定位                         |
#### 后台语音播报权限（可选）
* 使用场景： 

请后台语音权限：在app退到后台时，为了给用户实时的导航语音提醒，需要后台语音播报配置  

* 具体配置：

 - 前台语音播报：
不需要申请权限，正常app都可以使用；
 - 后台语音播报
在用户app中如果使用了SDK内置语音播报且需要后台语音播报，则需要申请后台语音播报权限；否则的话则不需要
注意：在此权限下，需要Xcode勾选 Capabilities -> UIBackgroundModes > Location updates；

 - 勾选完成后，会在info.plist配置的文件里的Required background modes生成item 为App plays audio or streams audio/video using AirPlay 的配置
