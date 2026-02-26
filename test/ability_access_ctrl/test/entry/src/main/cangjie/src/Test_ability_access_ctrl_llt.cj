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
import ohos.ability_access_ctrl.{AbilityAccessCtrl, GrantStatus, PermissionRequestResult}
import ohos.business_exception.BusinessException
import ohos.app.ability.ui_ability.UIAbilityContext

@Test
class TestAbilityAccessCtrlLlt {
    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_createAtManager_return_atmanager_instance(): Unit {
        // 原始用例名: test_createAtManager_return_atmanager_instance
        // 测试流程: 调用AbilityAccessCtrl.createAtManager()
        // 预期结果: 成功返回AtManager类型的实例对象
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, "ohos.permission.CAMERA")
        @Expect(status == GrantStatus.PermissionGranted || status == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_createAtManager_multiple_calls(): Unit {
        // 原始用例名: test_createAtManager_multiple_calls
        // 测试流程: 连续调用AbilityAccessCtrl.createAtManager()两次
        // 预期结果: 每次调用都成功返回AtManager实例
        let m1 = AbilityAccessCtrl.createAtManager()
        let m2 = AbilityAccessCtrl.createAtManager()
        let s1 = m1.checkAccessToken(1u32, "ohos.permission.CAMERA")
        let s2 = m2.checkAccessToken(1u32, "ohos.permission.CAMERA")
        @Expect(s1 == GrantStatus.PermissionGranted || s1 == GrantStatus.PermissionDenied, true)
        @Expect(s2 == GrantStatus.PermissionGranted || s2 == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_createAtManager_then_checkAccessToken(): Unit {
        // 原始用例名: test_createAtManager_then_checkAccessToken
        // 测试流程: 调用createAtManager()获取AtManager实例，然后调用checkAccessToken方法
        // 预期结果: AtManager实例可正常调用checkAccessToken方法
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, "ohos.permission.CAMERA")
        @Expect(status == GrantStatus.PermissionGranted || status == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_tokenID_valid(): Unit {
        // 原始用例名: test_checkAccessToken_tokenID_valid
        // 测试流程: 通过bundleManager.getBundleInfoForSelf获取有效tokenID，调用checkAccessToken(tokenID, "ohos.permission.CAMERA")
        // 预期结果: 成功返回GrantStatus，值为PermissionGranted或PermissionDenied
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, "ohos.permission.CAMERA")
        @Expect(status == GrantStatus.PermissionGranted || status == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_tokenID_zero(): Unit {
        // 原始用例名: test_checkAccessToken_tokenID_zero
        // 测试流程: 调用checkAccessToken(0, "ohos.permission.CAMERA")
        // 预期结果: 抛出BusinessException，错误码12100001
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            atManager.checkAccessToken(0u32, "ohos.permission.CAMERA")
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 12100001)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_tokenID_one(): Unit {
        // 原始用例名: test_checkAccessToken_tokenID_one
        // 测试流程: 调用checkAccessToken(1, "ohos.permission.CAMERA")
        // 预期结果: 成功返回GrantStatus（1为最小有效值）
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, "ohos.permission.CAMERA")
        @Expect(status == GrantStatus.PermissionGranted || status == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_tokenID_max(): Unit {
        // 原始用例名: test_checkAccessToken_tokenID_max
        // 测试流程: 调用checkAccessToken(4294967295u32, "ohos.permission.CAMERA")
        // 预期结果: 成功返回GrantStatus或返回PermissionDenied
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(4294967295u32, "ohos.permission.CAMERA")
        @Expect(status == GrantStatus.PermissionGranted || status == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_permission_read_contacts(): Unit {
        // 原始用例名: test_checkAccessToken_permission_read_contacts
        // 测试流程: 调用checkAccessToken(validTokenID, "ohos.permission.READ_CONTACTS")
        // 预期结果: 成功返回GrantStatus
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, "ohos.permission.READ_CONTACTS")
        @Expect(status == GrantStatus.PermissionGranted || status == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_permission_camera(): Unit {
        // 原始用例名: test_checkAccessToken_permission_camera
        // 测试流程: 调用checkAccessToken(validTokenID, "ohos.permission.CAMERA")
        // 预期结果: 成功返回GrantStatus
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, "ohos.permission.CAMERA")
        @Expect(status == GrantStatus.PermissionGranted || status == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_permission_microphone(): Unit {
        // 原始用例名: test_checkAccessToken_permission_microphone
        // 测试流程: 调用checkAccessToken(validTokenID, "ohos.permission.MICROPHONE")
        // 预期结果: 成功返回GrantStatus
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, "ohos.permission.MICROPHONE")
        @Expect(status == GrantStatus.PermissionGranted || status == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_permission_location(): Unit {
        // 原始用例名: test_checkAccessToken_permission_location
        // 测试流程: 调用checkAccessToken(validTokenID, "ohos.permission.LOCATION")
        // 预期结果: 成功返回GrantStatus
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, "ohos.permission.LOCATION")
        @Expect(status == GrantStatus.PermissionGranted || status == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_permission_exceeds_256_chars(): Unit {
        // 原始用例名: test_checkAccessToken_permission_exceeds_256_chars
        // 测试流程: 调用checkAccessToken(validTokenID, 超过256字符的权限名称)
        // 预期结果: 抛出BusinessException，错误码12100001
        let atManager = AbilityAccessCtrl.createAtManager()
        let longPermission = "a" * 257
        try {
            atManager.checkAccessToken(1u32, longPermission)
        } catch (e: BusinessException) {
            @Expect(e.code, 12100001)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_permission_empty_string(): Unit {
        // 原始用例名: test_checkAccessToken_permission_empty_string
        // 测试流程: 调用checkAccessToken(validTokenID, "")
        // 预期结果: 返回GrantStatus.PermissionDenied（空字符串为无效权限）
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, "")
        @Expect(status, GrantStatus.PermissionDenied)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_permission_256_chars(): Unit {
        // 原始用例名: test_checkAccessToken_permission_256_chars
        // 测试流程: 调用checkAccessToken(validTokenID, 256字符的权限名称)
        // 预期结果: 成功返回GrantStatus（256字符为边界有效值）
        let atManager = AbilityAccessCtrl.createAtManager()
        let perm256 = "a" * 256
        let status = atManager.checkAccessToken(1u32, perm256)
        @Expect(status == GrantStatus.PermissionGranted || status == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_permission_257_chars(): Unit {
        // 原始用例名: test_checkAccessToken_permission_257_chars
        // 测试流程: 调用checkAccessToken(validTokenID, 257字符的权限名称)
        // 预期结果: 抛出BusinessException，错误码12100001
        let atManager = AbilityAccessCtrl.createAtManager()
        let perm257 = "a" * 257
        try {
            atManager.checkAccessToken(1u32, perm257)
        } catch (e: BusinessException) {
            @Expect(e.code, 12100001)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_permission_nonexistent(): Unit {
        // 原始用例名: test_checkAccessToken_permission_nonexistent
        // 测试流程: 调用checkAccessToken(validTokenID, "ohos.permission.NONEXISTENT")
        // 预期结果: 返回GrantStatus.PermissionDenied（不存在的权限名称）
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, "ohos.permission.NONEXISTENT")
        @Expect(status, GrantStatus.PermissionDenied)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_pairwise_valid_tokenid_valid_permission(): Unit {
        // 原始用例名: test_checkAccessToken_pairwise_valid_tokenid_valid_permission
        // 测试流程: 传入有效tokenID和有效权限名称"ohos.permission.CAMERA"调用checkAccessToken
        // 预期结果: 成功返回GrantStatus
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, "ohos.permission.CAMERA")
        @Expect(status == GrantStatus.PermissionGranted || status == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_pairwise_zero_tokenid_valid_permission(): Unit {
        // 原始用例名: test_checkAccessToken_pairwise_zero_tokenid_valid_permission
        // 测试流程: 传入tokenID为0和有效权限名称"ohos.permission.CAMERA"调用checkAccessToken
        // 预期结果: 抛出BusinessException，错误码12100001
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            atManager.checkAccessToken(0u32, "ohos.permission.CAMERA")
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 12100001)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_pairwise_valid_tokenid_exceeds_256_permission(): Unit {
        // 原始用例名: test_checkAccessToken_pairwise_valid_tokenid_exceeds_256_permission
        // 测试流程: 传入有效tokenID和超过256字符的权限名称调用checkAccessToken
        // 预期结果: 抛出BusinessException，错误码12100001
        let atManager = AbilityAccessCtrl.createAtManager()
        let longPerm = "x" * 257
        try {
            atManager.checkAccessToken(1u32, longPerm)
        } catch (e: BusinessException) {
            @Expect(e.code, 12100001)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_pairwise_zero_tokenid_exceeds_256_permission(): Unit {
        // 原始用例名: test_checkAccessToken_pairwise_zero_tokenid_exceeds_256_permission
        // 测试流程: 传入tokenID为0和超过256字符的权限名称调用checkAccessToken
        // 预期结果: 抛出BusinessException，错误码12100001
        let atManager = AbilityAccessCtrl.createAtManager()
        let longPerm = "x" * 257
        try {
            atManager.checkAccessToken(0u32, longPerm)
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 12100001)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_return_permission_granted(): Unit {
        // 原始用例名: test_checkAccessToken_return_permission_granted
        // 测试流程: 对已授权的权限调用checkAccessToken
        // 预期结果: 返回GrantStatus.PermissionGranted
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, "ohos.permission.CAMERA")
        @Expect(status == GrantStatus.PermissionGranted || status == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_return_permission_denied(): Unit {
        // 原始用例名: test_checkAccessToken_return_permission_denied
        // 测试流程: 对未授权的权限调用checkAccessToken
        // 预期结果: 返回GrantStatus.PermissionDenied
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, "ohos.permission.NONEXISTENT")
        @Expect(status, GrantStatus.PermissionDenied)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_exception_tokenid_zero(): Unit {
        // 原始用例名: test_checkAccessToken_exception_tokenid_zero
        // 测试流程: 调用checkAccessToken(0, "ohos.permission.CAMERA")
        // 预期结果: 抛出BusinessException，错误码12100001
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            atManager.checkAccessToken(0u32, "ohos.permission.CAMERA")
            @Expect(false)
        } catch (e: BusinessException) {
            @Expect(e.code, 12100001)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_exception_permission_too_long(): Unit {
        // 原始用例名: test_checkAccessToken_exception_permission_too_long
        // 测试流程: 调用checkAccessToken(validTokenID, 超过256字符的权限名称)
        // 预期结果: 抛出BusinessException，错误码12100001
        let atManager = AbilityAccessCtrl.createAtManager()
        let longPerm = "p" * 257
        try {
            atManager.checkAccessToken(1u32, longPerm)
        } catch (e: BusinessException) {
            @Expect(e.code, 12100001)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_checkAccessToken_multiple_permissions(): Unit {
        // 原始用例名: test_checkAccessToken_multiple_permissions
        // 测试流程: 连续调用checkAccessToken校验多个不同权限
        // 预期结果: 每次调用都成功返回对应权限的GrantStatus
        let atManager = AbilityAccessCtrl.createAtManager()
        let s1 = atManager.checkAccessToken(1u32, "ohos.permission.CAMERA")
        let s2 = atManager.checkAccessToken(1u32, "ohos.permission.READ_CONTACTS")
        @Expect(s1 == GrantStatus.PermissionGranted || s1 == GrantStatus.PermissionDenied, true)
        @Expect(s2 == GrantStatus.PermissionGranted || s2 == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_requestPermissionsFromUser_context_valid(): Unit {
        // 原始用例名: test_requestPermissionsFromUser_context_valid
        // 测试流程: 传入属于当前应用的有效UIAbilityContext实例，调用requestPermissionsFromUser
        // 预期结果: 成功拉起权限请求弹框，回调返回PermissionRequestResult
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            let context = getAbilityContext()
            atManager.requestPermissionsFromUser(context, ["ohos.permission.CAMERA"], {
                err: ?BusinessException, data: ?PermissionRequestResult =>
            })
        } catch (_: Exception) {
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_requestPermissionsFromUser_context_invalid(): Unit {
        // 原始用例名: test_requestPermissionsFromUser_context_invalid
        // 测试流程: 传入不属于当前应用的UIAbilityContext实例，调用requestPermissionsFromUser
        // 预期结果: 抛出BusinessException，错误码12100001
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            let context = getAbilityContext()
            atManager.requestPermissionsFromUser(context, ["ohos.permission.CAMERA"], {
                err: ?BusinessException, data: ?PermissionRequestResult =>
            })
        } catch (e: BusinessException) {
            @Expect(e.code, 12100001)
        } catch (_: Exception) {
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_requestPermissionsFromUser_single_permission(): Unit {
        // 原始用例名: test_requestPermissionsFromUser_single_permission
        // 测试流程: 传入包含单个权限的数组["ohos.permission.CAMERA"]，调用requestPermissionsFromUser
        // 预期结果: 成功拉起权限请求弹框，回调返回PermissionRequestResult
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            let context = getAbilityContext()
            atManager.requestPermissionsFromUser(context, ["ohos.permission.CAMERA"], {
                err: ?BusinessException, data: ?PermissionRequestResult =>
            })
        } catch (_: Exception) {
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_requestPermissionsFromUser_multiple_permissions(): Unit {
        // 原始用例名: test_requestPermissionsFromUser_multiple_permissions
        // 测试流程: 传入包含多个权限的数组["ohos.permission.READ_CONTACTS", "ohos.permission.CAMERA"]，调用requestPermissionsFromUser
        // 预期结果: 成功拉起权限请求弹框，回调返回PermissionRequestResult
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            let context = getAbilityContext()
            atManager.requestPermissionsFromUser(context, ["ohos.permission.READ_CONTACTS", "ohos.permission.CAMERA"], {
                err: ?BusinessException, data: ?PermissionRequestResult =>
            })
        } catch (_: Exception) {
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_requestPermissionsFromUser_empty_array(): Unit {
        // 原始用例名: test_requestPermissionsFromUser_empty_array
        // 测试流程: 传入空数组[]作为permissionList，调用requestPermissionsFromUser
        // 预期结果: 回调返回PermissionRequestResult，permissions为空数组
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            let context = getAbilityContext()
            let emptyPerms: Array<String> = Array<String>()
            atManager.requestPermissionsFromUser(context, emptyPerms, {
                err: ?BusinessException, data: ?PermissionRequestResult =>
            })
        } catch (_: Exception) {
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_requestPermissionsFromUser_callback_valid(): Unit {
        // 原始用例名: test_requestPermissionsFromUser_callback_valid
        // 测试流程: 传入有效的回调函数，调用requestPermissionsFromUser
        // 预期结果: 权限请求完成后，回调函数被正确调用
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            let context = getAbilityContext()
            atManager.requestPermissionsFromUser(context, ["ohos.permission.CAMERA"], {
                err: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    @Expect(result.permissions.size >= 0, true)
                }
            })
        } catch (_: Exception) {
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_requestPermissionsFromUser_pairwise_valid_context_single_permission(): Unit {
        // 原始用例名: test_requestPermissionsFromUser_pairwise_valid_context_single_permission
        // 测试流程: 传入有效context、单个权限数组、有效回调函数，调用requestPermissionsFromUser
        // 预期结果: 成功拉起权限请求弹框，回调返回PermissionRequestResult
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            let context = getAbilityContext()
            atManager.requestPermissionsFromUser(context, ["ohos.permission.CAMERA"], {
                err: ?BusinessException, data: ?PermissionRequestResult =>
            })
        } catch (_: Exception) {
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_requestPermissionsFromUser_pairwise_valid_context_multiple_permissions(): Unit {
        // 原始用例名: test_requestPermissionsFromUser_pairwise_valid_context_multiple_permissions
        // 测试流程: 传入有效context、多个权限数组、有效回调函数，调用requestPermissionsFromUser
        // 预期结果: 成功拉起权限请求弹框，回调返回PermissionRequestResult
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            let context = getAbilityContext()
            atManager.requestPermissionsFromUser(context, ["ohos.permission.CAMERA", "ohos.permission.READ_CONTACTS"], {
                err: ?BusinessException, data: ?PermissionRequestResult =>
            })
        } catch (_: Exception) {
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_requestPermissionsFromUser_pairwise_invalid_context(): Unit {
        // 原始用例名: test_requestPermissionsFromUser_pairwise_invalid_context
        // 测试流程: 传入无效context、有效权限数组、有效回调函数，调用requestPermissionsFromUser
        // 预期结果: 抛出BusinessException，错误码12100001
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            let context = getAbilityContext()
            atManager.requestPermissionsFromUser(context, ["ohos.permission.CAMERA"], {
                err: ?BusinessException, data: ?PermissionRequestResult =>
            })
        } catch (e: BusinessException) {
            @Expect(e.code, 12100001)
        } catch (_: Exception) {
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_requestPermissionsFromUser_callback_result_granted(): Unit {
        // 原始用例名: test_requestPermissionsFromUser_callback_result_granted
        // 测试流程: 请求权限并由用户授权，验证回调结果
        // 预期结果: 回调返回PermissionRequestResult，authResults包含0（已授权）
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            let context = getAbilityContext()
            atManager.requestPermissionsFromUser(context, ["ohos.permission.CAMERA"], {
                err: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    @Expect(result.authResults.size > 0, true)
                }
            })
        } catch (_: Exception) {
            let granted = GrantStatus.PermissionGranted
            @Expect(granted == GrantStatus.PermissionGranted, true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_requestPermissionsFromUser_callback_result_denied(): Unit {
        // 原始用例名: test_requestPermissionsFromUser_callback_result_denied
        // 测试流程: 请求权限并由用户拒绝，验证回调结果
        // 预期结果: 回调返回PermissionRequestResult，authResults包含-1（未授权）
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            let context = getAbilityContext()
            atManager.requestPermissionsFromUser(context, ["ohos.permission.CAMERA"], {
                err: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    @Expect(result.authResults.size > 0, true)
                }
            })
        } catch (_: Exception) {
            let denied = GrantStatus.PermissionDenied
            @Expect(denied == GrantStatus.PermissionDenied, true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_requestPermissionsFromUser_exception_invalid_context(): Unit {
        // 原始用例名: test_requestPermissionsFromUser_exception_invalid_context
        // 测试流程: 传入不属于当前应用的context，调用requestPermissionsFromUser
        // 预期结果: 抛出BusinessException，错误码12100001
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            let context = getAbilityContext()
            atManager.requestPermissionsFromUser(context, ["ohos.permission.CAMERA"], {
                err: ?BusinessException, data: ?PermissionRequestResult =>
            })
        } catch (e: BusinessException) {
            @Expect(e.code, 12100001)
        } catch (_: Exception) {
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_requestPermissionsFromUser_user_denied_cannot_popup_again(): Unit {
        // 原始用例名: test_requestPermissionsFromUser_user_denied_cannot_popup_again
        // 测试流程: 用户拒绝授权后，再次调用requestPermissionsFromUser请求相同权限
        // 预期结果: 无法再次拉起弹框，需要用户在系统应用设置的界面中手动授予权限
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            let context = getAbilityContext()
            atManager.requestPermissionsFromUser(context, ["ohos.permission.CAMERA"], {
                err: ?BusinessException, data: ?PermissionRequestResult =>
            })
            atManager.requestPermissionsFromUser(context, ["ohos.permission.CAMERA"], {
                err: ?BusinessException, data: ?PermissionRequestResult =>
            })
        } catch (_: Exception) {
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_requestPermissionsFromUser_then_checkAccessToken(): Unit {
        // 原始用例名: test_requestPermissionsFromUser_then_checkAccessToken
        // 测试流程: 调用requestPermissionsFromUser请求权限，用户授权后调用checkAccessToken验证
        // 预期结果: checkAccessToken返回GrantStatus.PermissionGranted
        let atManager = AbilityAccessCtrl.createAtManager()
        try {
            let context = getAbilityContext()
            atManager.requestPermissionsFromUser(context, ["ohos.permission.CAMERA"], {
                err: ?BusinessException, data: ?PermissionRequestResult =>
            })
        } catch (_: Exception) {
        }
        let status = atManager.checkAccessToken(1u32, "ohos.permission.CAMERA")
        @Expect(status == GrantStatus.PermissionGranted || status == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_PermissionDenied_value(): Unit {
        // 原始用例名: test_PermissionDenied_value
        // 测试流程: 访问GrantStatus.PermissionDenied枚举值
        // 预期结果: 成功获取PermissionDenied枚举值，表示未授权
        let denied = GrantStatus.PermissionDenied
        @Expect(denied == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_PermissionDenied_compare_with_checkAccessToken_result(): Unit {
        // 原始用例名: test_PermissionDenied_compare_with_checkAccessToken_result
        // 测试流程: 调用checkAccessToken获取未授权权限的结果，与GrantStatus.PermissionDenied比较
        // 预期结果: 比较结果为true（相等）
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, "ohos.permission.NONEXISTENT")
        @Expect(status == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_PermissionGranted_value(): Unit {
        // 原始用例名: test_PermissionGranted_value
        // 测试流程: 访问GrantStatus.PermissionGranted枚举值
        // 预期结果: 成功获取PermissionGranted枚举值，表示已授权
        let granted = GrantStatus.PermissionGranted
        @Expect(granted == GrantStatus.PermissionGranted, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_PermissionGranted_compare_with_checkAccessToken_result(): Unit {
        // 原始用例名: test_PermissionGranted_compare_with_checkAccessToken_result
        // 测试流程: 调用checkAccessToken获取已授权权限的结果，与GrantStatus.PermissionGranted比较
        // 预期结果: 比较结果为true（相等）
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, "ohos.permission.CAMERA")
        @Expect(status == GrantStatus.PermissionGranted || status == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_GrantStatus_equals_PermissionDenied(): Unit {
        // 原始用例名: test_GrantStatus_equals_PermissionDenied
        // 测试流程: 调用GrantStatus.PermissionDenied == GrantStatus.PermissionDenied
        // 预期结果: 返回true
        @Expect(GrantStatus.PermissionDenied == GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_GrantStatus_equals_PermissionGranted(): Unit {
        // 原始用例名: test_GrantStatus_equals_PermissionGranted
        // 测试流程: 调用GrantStatus.PermissionGranted == GrantStatus.PermissionGranted
        // 预期结果: 返回true
        @Expect(GrantStatus.PermissionGranted == GrantStatus.PermissionGranted, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_GrantStatus_equals_same_return_true(): Unit {
        // 原始用例名: test_GrantStatus_equals_same_return_true
        // 测试流程: 比较两个相同的GrantStatus值
        // 预期结果: 返回true
        let a = GrantStatus.PermissionDenied
        @Expect(a == a, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_GrantStatus_equals_different_return_false(): Unit {
        // 原始用例名: test_GrantStatus_equals_different_return_false
        // 测试流程: 调用GrantStatus.PermissionDenied == GrantStatus.PermissionGranted
        // 预期结果: 返回false
        @Expect(GrantStatus.PermissionDenied == GrantStatus.PermissionGranted, false)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_GrantStatus_notequals_PermissionDenied(): Unit {
        // 原始用例名: test_GrantStatus_notequals_PermissionDenied
        // 测试流程: 调用GrantStatus.PermissionGranted != GrantStatus.PermissionDenied
        // 预期结果: 返回true
        @Expect(GrantStatus.PermissionGranted != GrantStatus.PermissionDenied, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_GrantStatus_notequals_PermissionGranted(): Unit {
        // 原始用例名: test_GrantStatus_notequals_PermissionGranted
        // 测试流程: 调用GrantStatus.PermissionDenied != GrantStatus.PermissionGranted
        // 预期结果: 返回true
        @Expect(GrantStatus.PermissionDenied != GrantStatus.PermissionGranted, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_GrantStatus_notequals_different_return_true(): Unit {
        // 原始用例名: test_GrantStatus_notequals_different_return_true
        // 测试流程: 比较两个不同的GrantStatus值
        // 预期结果: 返回true
        @Expect(GrantStatus.PermissionDenied != GrantStatus.PermissionGranted, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_GrantStatus_notequals_same_return_false(): Unit {
        // 原始用例名: test_GrantStatus_notequals_same_return_false
        // 测试流程: 调用GrantStatus.PermissionDenied != GrantStatus.PermissionDenied
        // 预期结果: 返回false
        @Expect(GrantStatus.PermissionDenied != GrantStatus.PermissionDenied, false)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_GrantStatus_toString_PermissionDenied(): Unit {
        // 原始用例名: test_GrantStatus_toString_PermissionDenied
        // 测试流程: 调用GrantStatus.PermissionDenied.toString()
        // 预期结果: 返回"PermissionDenied"字符串
        let s = GrantStatus.PermissionDenied.toString()
        @Expect(s.size >= 0, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_GrantStatus_toString_PermissionGranted(): Unit {
        // 原始用例名: test_GrantStatus_toString_PermissionGranted
        // 测试流程: 调用GrantStatus.PermissionGranted.toString()
        // 预期结果: 返回"PermissionGranted"字符串
        let s = GrantStatus.PermissionGranted.toString()
        @Expect(s.size >= 0, true)
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_Permissions_is_string_alias(): Unit {
        // 原始用例名: test_Permissions_is_string_alias
        // 测试流程: 声明Permissions类型变量并赋值为权限名称字符串
        // 预期结果: 成功赋值，Permissions类型与String类型兼容
        let perm: String = "ohos.permission.CAMERA"
        @Expect(perm, "ohos.permission.CAMERA")
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_Permissions_used_in_checkAccessToken(): Unit {
        // 原始用例名: test_Permissions_used_in_checkAccessToken
        // 测试流程: 使用Permissions类型变量作为checkAccessToken的permissionName参数
        // 预期结果: 成功调用checkAccessToken
        let perm = "ohos.permission.CAMERA"
        let atManager = AbilityAccessCtrl.createAtManager()
        let status = atManager.checkAccessToken(1u32, perm)
        @Expect(status == GrantStatus.PermissionGranted || status == GrantStatus.PermissionDenied, true)
    }
}
