# 程序访问控制仓颉接口

## 简介

程序访问控制仓颉接口是在OpenHarmony上基于AccessToken能力之上封装的仓颉API。应用的Accesstoken信息主要包括应用身份标识APPID、用户ID，应用分身索引、应用APL(Ability Privilege Level)等级、应用权限信息等。每个应用的Accesstoken信息由一个32bits的设备内唯一标识符TokenID(Token identity)来标识。

## 系统架构

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

## 约束

当前开放的程序访问控制仓颉接口仅支持standard设备。

## 使用说明

如架构图所示，程序访问控制仓颉接口以下功能接口，开发者可以根据使用诉求，综合使用一类或多类接口：

  - 程序访问控制提供应用程序的权限校验和管理能力。用户可通过提供的接口申请和查看应用权限。
  - 权限请求结果对象可以在用户调用requestPermissionsFromUser接口申请权限时返回此次权限申请的结果。

与ArkTS相比，暂不支持以下功能：

  - 查询应用权限状态。
  - 拉起全局开关设置。
  - 二次拉起权限设置弹窗。

程序访问控制相关API请参见[ohos.ability_access_ctrl（程序访问控制管理）](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/blob/master/doc/API_Reference/source_zh_cn/apis/AbilityKit/cj-apis-ability_access_ctrl.md)，相关指导请参见[程序框架服务开发指南](https://gitcode.com/openharmony-sig/arkcompiler_cangjie_ark_interop/tree/master/doc/Dev_Guide/source_zh_cn/application-models)。

## 参与贡献

欢迎广大开发者代码，文档等，具体的贡献流程和方式请参见[参与贡献](https://gitcode.com/openharmony/docs/blob/master/zh-cn/contribute/%E5%8F%82%E4%B8%8E%E8%B4%A1%E7%8C%AE.md)。

## 相关仓

[security_access_token](https://gitee.com/openharmony/security_access_token)
