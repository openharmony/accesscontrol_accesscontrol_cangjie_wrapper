/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package ohos.ability_access_ctrl

import ohos.app.ability.ui_ability.UIAbilityContext
import ohos.business_exception.AsyncCallback
import ohos.labels.APILevel
public import ohos.security.permission_request_result.*
import ohos.security.permission_request_result.*

public type Permissions = String

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Security.AccessToken"
]
public enum GrantStatus {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Security.AccessToken"
    ]
    PermissionDenied
    |
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Security.AccessToken"
    ]
    PermissionGranted
    | ...
}

extend GrantStatus <: ToString {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Security.AccessToken"
    ]
    public func toString(): String {
        return String()
    }
}

extend GrantStatus <: Equatable<GrantStatus> {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Security.AccessToken"
    ]
    public operator func ==(other: GrantStatus): Bool {
        return true
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Security.AccessToken"
    ]
    public operator func !=(other: GrantStatus): Bool {
        return true
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Security.AccessToken"
]
public class AbilityAccessCtrl {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Security.AccessToken"
    ]
    public static func createAtManager(): AtManager {
        return AtManager()
    }
    
    public init() {
        super()
    }
}

@!APILevel[
    since: "22",
    syscap: "SystemCapability.Security.AccessToken"
]
public class AtManager {
    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Security.AccessToken",
        throwexception: true
    ]
    public func checkAccessToken(tokenID: UInt32, permissionName: Permissions): GrantStatus {
        return GrantStatus.PermissionDenied
    }

    @!APILevel[
        since: "22",
        syscap: "SystemCapability.Security.AccessToken",
        throwexception: true
    ]
    public func requestPermissionsFromUser(context: UIAbilityContext, permissionList: Array<Permissions>,
        requestCallback: AsyncCallback<PermissionRequestResult>): Unit {
        return ()
    }

    @!APILevel[
        since: "24",
        syscap: "SystemCapability.Security.AccessToken",
        throwexception: true,
        workerthread: true
    ]
    public func requestPermissionOnSetting(context: UIAbilityContext, permissionList: Array<Permissions>): Array<GrantStatus> {
        return Array<GrantStatus>()
    }

    public init() {
        super()
    }
}