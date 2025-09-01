/*
 * Copyright (c) 2025 Huawei Device Co., Ltd.
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

package ohos_app_cangjie_entry

import std.unittest.*
import std.unittest.common.*
import std.unittest.testmacro.*
import ohos.base.*
import ohos.business_exception.*
import ohos.hilog.Hilog
import kit.AbilityKit.AbilityAccessCtrl
import kit.AbilityKit.PermissionRequestResult
import kit.AbilityKit.GrantStatus
import kit.AbilityKit.MemoryLevel as AbilityMemoryLevel
import kit.PerformanceAnalysisKit.Hilog

let permissionList = ["ohos.permission.READ_CONTACTS"]

@Test
class Test_ability_access_ctrl {
    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_grantStatus() {
        let abilityAccessCtrl = AbilityAccessCtrl.createAtManager()
        let grantStatus = abilityAccessCtrl.checkAccessToken(1, "READ_CONTACTS")
        Hilog.info(0, "CangjieTest", "grantStatus is ${grantStatus.toString()}")
        @Expect(grantStatus, GrantStatus.PermissionDenied)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_AbilityAccessCtrl() {
        let aac = AbilityAccessCtrl.createAtManager()
        @Expect(true)
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_AtManager() {
        let abilityAccessCtrl = AbilityAccessCtrl.createAtManager()
        let uiAbilityContext = getAbilityContext()
        abilityAccessCtrl.requestPermissionsFromUser(uiAbilityContext, [""]) {
            errorCode, data => match (errorCode) {
                case Some(e) => Hilog.error(0, "ability_access_ctrl_test",
                    "permissionResultCallBack request error: errcode is ${e.code}")
                case _ => match (data) {
                    case Some(value) => for (i in (0..value.permissions.size)) {
                        Hilog.info(0, "ability_access_ctrl_test", "permissionResultCallBack: xxx")
                        Hilog.info(0, "ability_access_ctrl_test",
                            "permissionResultCallBack: ${value.permissions[i]} -- ${value.authResults[i]}")
                    }
                    case _ => Hilog.error(0, "ability_access_ctrl_test",
                        "permissionResultCallBack request error: data is null")
                }
            }
        }
    }

    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_checkAccessToken() {
        let abilityAccessCtrl = AbilityAccessCtrl.createAtManager()
        try {
            abilityAccessCtrl.checkAccessToken(0, "")
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 12100001)
        }
        abilityAccessCtrl.checkAccessToken(1, "")
    }


    @TestCase
    @Tag[APILevel21, TestLevel0]
    func test_auto_enum_GrantStatus() {
        let arr1: Array<GrantStatus> = [
            PermissionDenied,
            PermissionGranted
        ]
        let arrStr: Array<String> = [
            "GrantStatus.PermissionDenied",
            "GrantStatus.PermissionGranted"
        ]
        for (i in 0..arr1.size) {
            @Expect(arr1[i] == arr1[i])
            @Expect(arr1[i] != arr1[(i + 1) % arr1.size])
            @Expect(arr1[i].toString() == arrStr[i])
        }
    }
}
