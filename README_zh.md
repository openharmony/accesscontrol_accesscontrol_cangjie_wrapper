# 程序访问控制仓颉接口

## 简介

程序访问控制仓颉接口是在OpenHarmony上基于AccessToken能力之上封装的仓颉API。应用的Accesstoken信息主要包括应用身份标识APPID、用户ID，应用分身索引、应用APL(Ability Privilege Level)等级、应用权限信息等。每个应用的Accesstoken信息由一个32bits的设备内唯一标识符TokenID(Token identity)来标识。

## 架构图

**图 1** 程序访问控制仓颉架构图

![](figures/accesscontrol_cangjie_wrapper_architecture.png "程序访问控制仓颉架构图")

## 目录

程序访问控制仓颉源码在base/accesscontrol/accesstrol_cangjie_wrapper下

```
base/accesscontrol/accesscontrol_cangjie_wrapper
├── figures                 # 存放readme中的架构图
└── ohos                    # 仓颉程序访问控制接口
    ├── ability_access_ctrl # 仓颉程序访问控制管理接口
    └── security            # 权限请求结果对象
```

## 相关仓

[access_token](https://gitee.com/openharmony/security_access_token)