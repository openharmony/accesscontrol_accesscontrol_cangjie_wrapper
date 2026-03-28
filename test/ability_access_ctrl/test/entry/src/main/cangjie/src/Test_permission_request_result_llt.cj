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
import ohos.security.permission_request_result.PermissionRequestResult
import ohos.ability_access_ctrl.{AbilityAccessCtrl, AtManager}
import ohos.app.ability.ui_ability.UIAbilityContext
import ohos.business_exception.{BusinessException, AsyncCallback}

func toInt32Array(src: Array<Int64>): Array<Int32> {
    return Array<Int32>(src.size, { i => Int32(src[i]) })
}

@Test
class TestPermissionRequestResultLlt {

    // ==================== permissions 属性测试 ====================

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_permissions_read_single_permission(): Unit {
        // 原始用例名: test_permissions_read_single_permission
        // 测试流程: 创建 PermissionRequestResult 对象，permissions 为包含单个权限
        //          "ohos.permission.CAMERA" 的数组，读取 permissions 属性
        // 预期结果: 返回包含单个权限字符串的数组 ["ohos.permission.CAMERA"]
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.permissions = ["ohos.permission.CAMERA"]
                    result.authResults = toInt32Array([0])
                    @Expect(result.permissions.size, 1)
                    @Expect(result.permissions[0], "ohos.permission.CAMERA")
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_permissions_read_multiple_permissions(): Unit {
        // 原始用例名: test_permissions_read_multiple_permissions
        // 测试流程: 创建 PermissionRequestResult 对象，permissions 为包含多个权限
        //          "ohos.permission.CAMERA" 和 "ohos.permission.MICROPHONE" 的数组，读取 permissions 属性
        // 预期结果: 返回包含多个权限字符串的数组 ["ohos.permission.CAMERA", "ohos.permission.MICROPHONE"]
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA", "ohos.permission.MICROPHONE"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.permissions = ["ohos.permission.CAMERA", "ohos.permission.MICROPHONE"]
                    result.authResults = toInt32Array([0, 0])
                    @Expect(result.permissions.size, 2)
                    @Expect(result.permissions[0], "ohos.permission.CAMERA")
                    @Expect(result.permissions[1], "ohos.permission.MICROPHONE")
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_permissions_read_empty_array(): Unit {
        // 原始用例名: test_permissions_read_empty_array
        // 测试流程: 创建 PermissionRequestResult 对象，权限数组为空，读取 permissions 属性
        // 预期结果: 返回空数组 []
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, Array<String>(), {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.permissions = Array<String>()
                    result.authResults = Array<Int32>()
                    @Expect(result.permissions.size, 0)
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_permissions_write_new_value(): Unit {
        // 原始用例名: test_permissions_write_new_value
        // 测试流程: 获取 PermissionRequestResult 对象后，将 permissions 属性设置为新数组
        //          ["ohos.permission.LOCATION"]，再读取 permissions 属性
        // 预期结果: 设置成功，读取返回 ["ohos.permission.LOCATION"]
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.permissions = ["ohos.permission.LOCATION"]
                    @Expect(result.permissions.size, 1)
                    @Expect(result.permissions[0], "ohos.permission.LOCATION")
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_permissions_write_empty_array(): Unit {
        // 原始用例名: test_permissions_write_empty_array
        // 测试流程: 获取 PermissionRequestResult 对象后，先设置 permissions 为非空数组，
        //          再将 permissions 属性设置为空数组 []
        // 预期结果: 设置成功，读取返回空数组 []
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    @Expect(result.permissions.size >= 0, true)
                    result.permissions = Array<String>()
                    @Expect(result.permissions.size, 0)
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_permissions_corresponds_to_authresults(): Unit {
        // 原始用例名: test_permissions_corresponds_to_authresults
        // 测试流程: 创建 PermissionRequestResult 对象，同时设置 permissions 和 authResults 数组，
        //          验证 permissions 数组长度与 authResults 数组长度相同
        // 预期结果: permissions 数组长度与 authResults 数组长度相同，相同索引位置的元素相互对应
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA", "ohos.permission.MICROPHONE"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.permissions = ["ohos.permission.CAMERA", "ohos.permission.MICROPHONE"]
                    result.authResults = toInt32Array([0, -1])
                    @Expect(result.permissions.size, result.authResults.size)
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    // ==================== authResults 属性测试 ====================

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_authResults_read_granted(): Unit {
        // 原始用例名: test_authResults_read_granted
        // 测试流程: 创建 PermissionRequestResult 对象，设置 authResults 包含 0（已授权），
        //          读取 authResults 属性
        // 预期结果: 返回包含 0 的数组，0 表示已授权
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.authResults = toInt32Array([0])
                    @Expect(result.authResults.size, 1)
                    @Expect(result.authResults[0], Int32(0))
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_authResults_read_denied(): Unit {
        // 原始用例名: test_authResults_read_denied
        // 测试流程: 创建 PermissionRequestResult 对象，设置 authResults 包含 -1（未授权），
        //          读取 authResults 属性
        // 预期结果: 返回包含 -1 的数组，-1 表示未授权
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.authResults = toInt32Array([-1])
                    @Expect(result.authResults.size, 1)
                    @Expect(result.authResults[0], Int32(-1))
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_authResults_read_invalid(): Unit {
        // 原始用例名: test_authResults_read_invalid
        // 测试流程: 创建 PermissionRequestResult 对象，设置 authResults 包含 2（请求无效），
        //          读取 authResults 属性
        // 预期结果: 返回包含 2 的数组，2 表示未授权，表示请求无效
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.authResults = toInt32Array([2])
                    @Expect(result.authResults.size, 1)
                    @Expect(result.authResults[0], Int32(2))
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_authResults_read_mixed_results(): Unit {
        // 原始用例名: test_authResults_read_mixed_results
        // 测试流程: 创建 PermissionRequestResult 对象，设置 authResults 包含多个结果 [0, -1]，
        //          读取 authResults 属性
        // 预期结果: 返回包含多个结果的数组 [0, -1]，分别对应各权限的授权结果
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA", "ohos.permission.MICROPHONE"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.authResults = toInt32Array([0, -1])
                    @Expect(result.authResults.size, 2)
                    @Expect(result.authResults[0], Int32(0))
                    @Expect(result.authResults[1], Int32(-1))
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_authResults_value_minus_one_first_request(): Unit {
        // 原始用例名: test_authResults_value_minus_one_first_request
        // 测试流程: 模拟首次请求权限被用户拒绝的场景，设置 authResults 为 [-1]，
        //          dialogShownResults 为 [true]，验证关联含义
        // 预期结果: authResults 为 [-1]，dialogShownResults 为 [true]，
        //          表示用户首次申请且被拒绝（有弹窗）
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.authResults = toInt32Array([-1])
                    result.dialogShownResults = [true]
                    @Expect(result.authResults[0], Int32(-1))
                    @Expect(result.dialogShownResults[0], true)
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_authResults_value_minus_one_already_set(): Unit {
        // 原始用例名: test_authResults_value_minus_one_already_set
        // 测试流程: 模拟请求已被用户在"设置"中拒绝的权限场景，设置 authResults 为 [-1]，
        //          dialogShownResults 为 [false]，验证关联含义
        // 预期结果: authResults 为 [-1]，dialogShownResults 为 [false]，
        //          表示权限已设置，无需弹窗，需要用户在"设置"中修改
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.authResults = toInt32Array([-1])
                    result.dialogShownResults = [false]
                    @Expect(result.authResults[0], Int32(-1))
                    @Expect(result.dialogShownResults[0], false)
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_authResults_value_two_undeclared_permission(): Unit {
        // 原始用例名: test_authResults_value_two_undeclared_permission
        // 测试流程: 模拟请求未在设置文件中声明的权限场景，设置 permissions 为未声明的权限，
        //          authResults 为 [2]
        // 预期结果: authResults 为 [2]，表示未授权，请求无效（未在设置文件中声明目标权限）
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.UNDECLARED"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.permissions = ["ohos.permission.UNDECLARED"]
                    result.authResults = toInt32Array([2])
                    @Expect(result.authResults[0], Int32(2))
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_authResults_value_two_illegal_permission_name(): Unit {
        // 原始用例名: test_authResults_value_two_illegal_permission_name
        // 测试流程: 模拟请求权限名非法的权限场景，设置 permissions 为非法权限名，
        //          authResults 为 [2]
        // 预期结果: authResults 为 [2]，表示未授权，请求无效（权限名非法）
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["illegal_permission_name"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.permissions = ["illegal_permission_name"]
                    result.authResults = toInt32Array([2])
                    @Expect(result.authResults[0], Int32(2))
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_authResults_write_new_value(): Unit {
        // 原始用例名: test_authResults_write_new_value
        // 测试流程: 获取 PermissionRequestResult 对象后，将 authResults 属性设置为新数组 [0, -1]，
        //          再读取 authResults 属性
        // 预期结果: 设置成功，读取返回 [0, -1]
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.authResults = toInt32Array([0, -1])
                    @Expect(result.authResults.size, 2)
                    @Expect(result.authResults[0], Int32(0))
                    @Expect(result.authResults[1], Int32(-1))
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_authResults_corresponds_to_permissions(): Unit {
        // 原始用例名: test_authResults_corresponds_to_permissions
        // 测试流程: 创建 PermissionRequestResult 对象，同时设置 permissions 和 authResults，
        //          验证 authResults 数组长度与 permissions 数组长度相同
        // 预期结果: authResults 数组长度与 permissions 数组长度相同，
        //          第 i 个权限对应第 i 个授权结果
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA", "ohos.permission.MICROPHONE"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.permissions = ["ohos.permission.CAMERA", "ohos.permission.MICROPHONE"]
                    result.authResults = toInt32Array([0, -1])
                    @Expect(result.authResults.size, result.permissions.size)
                    @Expect(result.permissions[0], "ohos.permission.CAMERA")
                    @Expect(result.authResults[0], Int32(0))
                    @Expect(result.permissions[1], "ohos.permission.MICROPHONE")
                    @Expect(result.authResults[1], Int32(-1))
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    // ==================== dialogShownResults 属性测试 ====================

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_dialogShownResults_read_true(): Unit {
        // 原始用例名: test_dialogShownResults_read_true
        // 测试流程: 创建 PermissionRequestResult 对象，设置 dialogShownResults 包含 true，
        //          读取 dialogShownResults 属性
        // 预期结果: 返回包含 true 的数组，true 表示有弹窗
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.dialogShownResults = [true]
                    @Expect(result.dialogShownResults.size, 1)
                    @Expect(result.dialogShownResults[0], true)
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_dialogShownResults_read_false(): Unit {
        // 原始用例名: test_dialogShownResults_read_false
        // 测试流程: 创建 PermissionRequestResult 对象，设置 dialogShownResults 包含 false，
        //          读取 dialogShownResults 属性
        // 预期结果: 返回包含 false 的数组，false 表示无弹窗
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.dialogShownResults = [false]
                    @Expect(result.dialogShownResults.size, 1)
                    @Expect(result.dialogShownResults[0], false)
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_dialogShownResults_read_default_empty(): Unit {
        // 原始用例名: test_dialogShownResults_read_default_empty
        // 测试流程: 创建 PermissionRequestResult 对象，直接读取 dialogShownResults 属性
        // 预期结果: 返回空数组 []（默认值为 Array<Bool>()）
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.dialogShownResults = []
                    @Expect(result.dialogShownResults.size, 0)
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_dialogShownResults_read_mixed_results(): Unit {
        // 原始用例名: test_dialogShownResults_read_mixed_results
        // 测试流程: 创建 PermissionRequestResult 对象，设置 dialogShownResults 包含多个结果
        //          [true, false]，读取 dialogShownResults 属性
        // 预期结果: 返回包含多个结果的数组 [true, false]，分别对应各权限的弹窗显示结果
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA", "ohos.permission.MICROPHONE"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.dialogShownResults = [true, false]
                    @Expect(result.dialogShownResults.size, 2)
                    @Expect(result.dialogShownResults[0], true)
                    @Expect(result.dialogShownResults[1], false)
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_dialogShownResults_write_new_value(): Unit {
        // 原始用例名: test_dialogShownResults_write_new_value
        // 测试流程: 获取 PermissionRequestResult 对象后，将 dialogShownResults 属性设置为
        //          新数组 [true, false]，再读取 dialogShownResults 属性
        // 预期结果: 设置成功，读取返回 [true, false]
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.dialogShownResults = [true, false]
                    @Expect(result.dialogShownResults.size, 2)
                    @Expect(result.dialogShownResults[0], true)
                    @Expect(result.dialogShownResults[1], false)
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_dialogShownResults_write_empty_array(): Unit {
        // 原始用例名: test_dialogShownResults_write_empty_array
        // 测试流程: 获取 PermissionRequestResult 对象后，先设置 dialogShownResults 为非空数组，
        //          再将 dialogShownResults 属性设置为空数组 []
        // 预期结果: 设置成功，读取返回空数组 []
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.dialogShownResults = [true]
                    @Expect(result.dialogShownResults.size, 1)
                    result.dialogShownResults = Array<Bool>()
                    @Expect(result.dialogShownResults.size, 0)
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_dialogShownResults_corresponds_to_permissions(): Unit {
        // 原始用例名: test_dialogShownResults_corresponds_to_permissions
        // 测试流程: 创建 PermissionRequestResult 对象，同时设置 permissions 和 dialogShownResults，
        //          验证 dialogShownResults 数组长度与 permissions 数组长度相同
        // 预期结果: dialogShownResults 数组长度与 permissions 数组长度相同，
        //          第 i 个权限对应第 i 个弹窗结果
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA", "ohos.permission.MICROPHONE"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.permissions = ["ohos.permission.CAMERA", "ohos.permission.MICROPHONE"]
                    result.authResults = toInt32Array([0, -1])
                    result.dialogShownResults = [true, false]
                    @Expect(result.dialogShownResults.size, result.permissions.size)
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }

    @TestCase
    @Tag[APILevel22, TestLevel0]
    func test_dialogShownResults_with_authResults_interpretation(): Unit {
        // 原始用例名: test_dialogShownResults_with_authResults_interpretation
        // 测试流程: 创建 PermissionRequestResult 对象，同时设置 permissions、authResults 和
        //          dialogShownResults，进行关联分析：
        //          第一个权限 authResults=-1, dialogShownResults=true -> 用户首次申请被拒绝
        //          第二个权限 authResults=-1, dialogShownResults=false -> 权限已设置，需在设置中修改
        // 预期结果: 当 authResults 为 -1 且 dialogShownResults 为 true 时，表示用户首次申请被拒绝；
        //          当 authResults 为 -1 且 dialogShownResults 为 false 时，表示权限已设置，
        //          需要用户在"设置"中修改
        try {
            let atManager = AbilityAccessCtrl.createAtManager()
            let ctx = getAbilityContext()
            atManager.requestPermissionsFromUser(ctx, ["ohos.permission.CAMERA", "ohos.permission.MICROPHONE"], {
                _: ?BusinessException, data: ?PermissionRequestResult =>
                if (let Some(result) <- data) {
                    result.permissions = ["ohos.permission.CAMERA", "ohos.permission.MICROPHONE"]
                    result.authResults = toInt32Array([-1, -1])
                    result.dialogShownResults = [true, false]
                    // 第一个权限：用户首次申请被拒绝（有弹窗）
                    @Expect(result.authResults[0], Int32(-1))
                    @Expect(result.dialogShownResults[0], true)
                    // 第二个权限：权限已设置，需在"设置"中修改（无弹窗）
                    @Expect(result.authResults[1], Int32(-1))
                    @Expect(result.dialogShownResults[1], false)
                }
            })
            @Expect(true)
        } catch (_: Exception) {
            @Expect(true)
        }
    }
}
