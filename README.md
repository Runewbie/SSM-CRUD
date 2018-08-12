### SSM-CRUD：SSM框架集成实战练习 

------

#### 简介：

> ##### SSM：Spring+SpringMVC+Mybatis CRUD： Create（创建） Retrieve（查询） Update（更新） Delete（删除）

#### 功能点：

> - 1、分页
>
> -  2、数据校验
>
>   > - jQuery前端校验 
>   > -  JSR303后端校验 
>
> - 3、AJAX
>
> -  4、Rest风格的URI；使用HTTP协议请求方式的动词，来表示对资源的 操作（GET（查询），POST（新增），PUT（修改），DELETE（删除））

#### 技术点：

> - 基础框架-SSM（Spring+SpringMVC+Mybatis）
> - 数据库-MySQL
> - 前端框架-Bootstrap快速搭建简介美观的页面
> - 项目的依赖管理-Maven
> - 分页-pagehelper
> - 逆向工程-MyBatis Generator

------

#### 开发过程：

##### 基础环境搭建：

> - 1、创建一个maven工程（创建一个简单的maven工程，在项目中右击选择properties，选择project facets，去掉动态web模块，然后在加上，修改web.xml的位置为src/main/webapp） 
>
> - 2、引入项目依赖的jar包: spring、springmvc、mybati、数据库连接池、驱动包、其他（jstl、servlet-api、junit） 
>
> - 3、引入Bootstrap前端框架 
>
> - 4、编写SSM整合的关键配置文件
>
>   > - web.xml
>   > - [Spring](https://spring.io/)
>   > - [SpringMVC](https://docs.spring.io/spring/docs/current/spring-framework-reference/web.html)
>   > - [Mybatis]([http://www.mybatis.org/mybatis-3/)
>   > - 使用Mybatis的的逆向工具 [MyBatis Generator](http://www.mybatis.org/generator/index.html) 进行逆向工程生成对应的bean以及mapper
>
> - 5、测试Mapper 

#### 业务逻辑开始：

> - **查询：**
>
>   - 1、访问index.jsp页面
>
>   - 2、index.jsp页面发出查询员工列表的请求
>
>   - 3、EmployeeController来接受请求，查出员工数据
>
>   - 4、来到list.jsp页面进行展示
>
>   - 5、pageHelper分页插件完成分页查询功能 
>
>   - URI：规定查询请求的URI：/emps
>
>   - 查询-ajax：
>
>     > - 1、index.jsp页面直接发送ajax请求进行员工分页数据的查询
>     > - 2、服务器将查出的数据，以json字符串的形式返回给浏览器
>     > - 3、浏览器收到js字符串，可以使用js对json进行解析，使用js通过dom增删改改变页面
>     > - 4、返回json，实现客户端的无关性
>
> - **新增：**
>
>   - 1、在index.jsp页面点击“新增”
>
>   - 2、弹出新增对话框
>
>   - 3、去数据库查询部门列表，显示在对话框中
>
>   - 4、用户输入数据，并进行校验
>
>     > jQuery前端校验，ajax用户名重复校验
>     >
>     > 重要数据（后端校验（JSR303），唯一约束）
>
>   -  5、完成保存
>
>   - 定义请求操作URI:
>
>     > - /emp/{id} GET 查询员工
>     > - /emp POST 保存员工
>     > - /emp/{id} PUT 修改员工
>     > - /emp/{id} DELETE 删除员工
>
> - **修改：**
>
>   - 1、点击编辑
>   - 2、弹出用户修改的模态框（显示用户信息）
>   - 3、点击更新，完成用户修改
>
> - **删除：**
>
>   - URI：/emp/{id} DELETE

------

#### 项目框架图示：
![SSM-CRUD实战练习总结](https://github.com/Runewbie/SSM-CRUD/blob/master/Readme/SSM-CRUD%E5%AE%9E%E6%88%98%E7%BB%83%E4%B9%A0%E6%80%BB%E7%BB%93.png)
