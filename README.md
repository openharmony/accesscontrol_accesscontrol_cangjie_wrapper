# accesscontrol_cangjie_wrapper

## Introduction

The accesscontrol_cangjie_wrapper is a Cangjie API encapsulated on OpenHarmony based on the access_token capability. The access_token information of the application mainly includes the application identity APPID, user ID, application clone index, application APL (Ability Privilege Level) level, application permission information, etc. The access_token information of each application is identified by a 32-bit unique device identifier, TokenID.

## Architecture

**Figure 1** accesscontrol_cangjie_wrapper architecture

![](figures/accesscontrol_cangjie_wrapper_architecture_en.png "accesscontrol_cangjie_wrapper architecture")

## Directory Structure

The source code of the program access control is under base/accesscontrol/accesstrol_cangjie_wrapper

```
base/accesscontrol/accesscontrol_cangjie_wrapper
├── figures                 # architecture pictures
└── ohos                    # Cangjie program access control interface
    ├── ability_access_ctrl # Cangjie program access control management interface
    └── security            # Permission request result object
```

## Repositories Involved

[access_token](https://gitee.com/openharmony/security_access_token)