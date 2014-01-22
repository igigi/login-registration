Daphne
======

### 一、基本信息

使用Sinatra作为基础框架，ActiveRecord作为数据持久层框架，Sqlite 3作为数据库。编写了/lib/tasks/database.rake作为数据库迁移和删除脚本（rake db:migrate和rake db:drop），config.ru中的URLMap作为转发路由表。测试使用RSpec，测试脚本在/spec/中。将来计划使用Carrierwave作为文件存储插件。

### 二、数据格式

登录验证部分，一共涉及到3个数据表：
* users 表中存储了用户信息，其中status 列表明了用户当前的状态，包括初始化（仅提交了注册，未验证）/正常/封禁
* captchas 表中存储了验证码信息，和users 表是多对一的关系，其中available 列表示是否可用
* tokens 表中存储了token数据，和users 表是多对一的关系

任何请求返回的内容为json格式，从类型角度来说，分为SuccessResult和FailureResulte，范例如下：
* { result: 'success', data: (业务逻辑返回的数据，Hash 或 Array) }
* { result: 'failure', code: 100, message: '错误信息' }

### 三、正常流程

1. 用户发送手机号索取验证码（URI: /s/captcha METHOD: POST）
2. API调用SP网关，给该手机号码的用户发送验证码短信
3. 用户收到验证码，点击登录（URI: /s/signin METHOD: POST）
4. API收到手机号和验证码，根据规则进行验证，若成功则返回token，若失败则返回相应错误代码和信息
