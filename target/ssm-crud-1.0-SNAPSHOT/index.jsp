<%--
  Created by IntelliJ IDEA.
  User: lgg
  Date: 2020/9/10
  Time: 17:33
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html>
<head>
    <title>员工列表</title>
    <%-- 设置路径--%>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>
    <%--   web路径：
                不以/开始的相对路径，找资源是以当前资源的路径为基准，经常容易出问题
                而以/开始的相对路径，是以服务器的路径为标注的（http://localhost:3306），需要加上项目名
                        http://localhost:3306/crud
       --%>
    <script src="${APP_PATH}/static/js/jquery-1.12.4.min.js"></script>
    <link href="${APP_PATH}/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH}/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>

<%--员工修改模态框--%>
<div class="modal fade" id="empUpdateModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" >员工修改</h4>
            </div>
            <%--            每一项的name名字和bean对象里面的一样，才能进行封装--%>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="empName_update_static">email@example.com</p>
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_update_input" placeholder="email@atguigu.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_update_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>

<!-- 员工添加的模态框 -->
<div class="modal fade" id="empAddModel" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="myModalLabel">员工添加</h4>
            </div>
<%--            每一项的name名字和bean对象里面的一样，才能进行封装--%>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="empName_add_input" class="col-sm-2 control-label">empName</label>
                        <div class="col-sm-10">
                            <input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="email_add_input" class="col-sm-2 control-label">email</label>
                        <div class="col-sm-10">
                            <input type="text" name="email" class="form-control" id="email_add_input" placeholder="email@atguigu.com">
                            <span  class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">gender</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label  class="col-sm-2 control-label">deptName</label>
                        <div class="col-sm-4">
                            <select class="form-control" name="dId" id="dept_add_select">

                            </select>
                        </div>
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<%--搭建显示页面--%>
<div class="container">
    <%--    标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM-CRUD</h1>
        </div>
    </div>

    <%--    新增/删除 按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-info" id="emp_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="emp__delete_all_btn">删除</button>
        </div>
    </div>

    <%--    表格--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                    <tr>
                        <th>
                            <input type="checkbox" id="check_all">
                        </th>
                        <th>#</th>
                        <th>empName</th>
                        <th>gender</th>
                        <th>email</th>
                        <th>deptName</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>

                </tbody>

            </table>
        </div>
    </div>


    <%--    显示分页信息--%>
    <div class="row" id="page">
        <%--            分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>

        <%--            分页条信息--%>
        <div class="col-md-6" id="page_nav_area">


        </div>
    </div>
</div>
<script type="text/javascript">
    //在执行完所有点击绑定以后再执行，页面先执行上面的html代码，然后执行js下面的绑定的代码，然后执行此函数
    $(function () {
        to_page(1);
    });
    
    function to_page(pn) {
        $.ajax({
            url:"${APP_PATH}/emps",
            data:"pn="+pn,
            type:"GET",
            success:function (result) {
                console.log(result);
                build_emps_table(result);
                build_page_info(result);
                build_page_nav(result);
            }

        });
    }
    
    //构建用户信息表
    function build_emps_table(result) {
        //清空
        $("#emps_table tbody").empty();

        var emps=result.extend.pageInfo.list;
        $.each(emps,function(index,item) {
            var checkBoxTd=$("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd=$("<td></td>").append(item.empId);
            var empNameTd=$("<td></td>").append(item.empName);
            var genderTd=$("<td></td>").append(item.gender=="M"?"男":"女");
            var emailTd=$("<td></td>").append(item.email);
            var deptNameTd=$("<td></td>").append(item.dept.deptName);
            var editBtn=$("<button></button>").addClass("btn btn-info btn-sm edit_btn").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加自定义属性
            editBtn.attr("edit-id",item.empId);

            var delBtn=$("<button></button>").addClass("btn btn-danger btn-sm delete_btn").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            delBtn.attr("del-id",item.empId);

            $("<tr></tr>").append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(editBtn)
                .append(delBtn)
                .appendTo("#emps_table tbody");

        })
    }

    //显示分页信息
    function build_page_info(result) {
        //清空
        $("#page_info_area").empty();
        $("#page_info_area").append("当前第"+result.extend.pageInfo.pageNum+"页，共"+result.extend.pageInfo.total+"条记录。");
    }

    //构建分页条信息
    function build_page_nav(result) {
        //清空
        $("#page_nav_area").empty();

        var ul=$("<ul></ul>").addClass("pagination");

        var firstPageLi=$("<li></li>").append($("<a></a>").append("首页"));
        var prePageLi=$("<li></li>").append($("<a></a>").append("&laquo;"));
        if(result.extend.pageInfo.hasPreviousPage==false){
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        }
        else {
            firstPageLi.click(function () {
                to_page(1);
            });

            prePageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum - 1);
            });
        }

        var nextPageLi=$("<li></li>").append($("<a></a>").append("&raquo;"));
        var lastPageLi=$("<li></li>").append($("<a></a>").append("尾页"));
        if(result.extend.pageInfo.hasNextPage==false){
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        }
        else {
            lastPageLi.click(function () {
                to_page(result.extend.pageInfo.pages);
            });

            nextPageLi.click(function () {
                to_page(result.extend.pageInfo.pageNum + 1);
            });
        }

        ul.append(firstPageLi).append(prePageLi);
        $.each(result.extend.pageInfo.navigatepageNums,function(index,item) {
            if(result.extend.pageInfo.pageNum==item) {
                var numLi = $("<li></li>").addClass("active").append($("<a></a>").append(item).attr("href", "#"));
            }
            else{
                var numLi = $("<li></li>").append($("<a></a>").append(item).attr("href", "#"));

            }
            numLi.click(function() {
                to_page(item);
            });

            ul.append(numLi);
        });
        ul.append(nextPageLi).append(lastPageLi);
        var navEle=$("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    function reset_form(ele){
        $(ele)[0].reset();
        //还要清空表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    //点击新增按钮弹出模态框
    //$(document).on("click","#emp_add_modal_btn",function () {
    $("#emp_add_modal_btn").click(function() {

        //表单完整重置
        //$("#empAddModel form")[0].reset();
        reset_form("#empAddModel form");
        //发送ajax请求，查出部门信息，显示下拉列表
        getDepts("#dept_add_select");
        $("#empAddModel").modal({
            backdrop:"static"
        });
    });
    
    function getDepts(ele) {
        $(ele).empty();
        $.ajax({
            url:"${APP_PATH}/depts",
            type:"GET",
            success:function(result) {
                //$("#dept_add_select").append("");
                $.each(result.extend.depts,function(index,item){
                    var optionEle=$("<option></option>>").append(item.deptName).attr("value",item.deptId);
                    optionEle.appendTo(ele);
                })
            }
        })
    }

    function validate_add_form(){
        //1.拿到校验数据
        var empName= $("#empName_add_input").val();
        var regName=/(^[\u2E80-\u9FFF]{2,4})/;//用户名必须是2-4位中文组成
        if(!regName.test(empName)){
            //记得先清空
            show_validate_msg("#empName_add_input","error","用户名必须是2-4位中文组成");
            // $("#empName_add_input").parent().addClass("has-error");
            // $("#empName_add_input").next("span").text("用户名必须是2-4位中文组成")
             return false;
        }
        else{
            show_validate_msg("#empName_add_input","success","");
            // $("#empName_add_input").parent().addClass("has-success");
            // $("#empName_add_input").next("span").text("");

        }
        //2.检验邮箱
        var email = $("#email_add_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //记得先清空
            show_validate_msg("#email_add_input","error","邮箱格式错误");
            // $("#email_add_input").parent().addClass("has-error");
            // $("#email_add_input").next("span").text("邮箱格式错误");
            return false;
        }
        else{
            show_validate_msg("#email_add_input","success","");
            // $("#email_add_input").parent().addClass("has-success");
            // $("#email_add_input").next("span").text("");

        }
        return true;
    }

    //为校验添加信息
    function show_validate_msg(ele,status,msg){
        //将以前的校验信息清除
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");

        if("success" == status){
            //如果校验成功
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        }else if("error" == status){
            //如果校验失败
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    $("#empName_add_input").change(function () {
        //检验用户名是否重复
        var empName=$("#empName_add_input").val();
        $.ajax({
            url:"${APP_PATH}/checkuser",
            type:"GET",
            data:"empName="+empName,//data数据相当于加到url链接后面的
            success:function(result) {
                if(result.code==100){
                    show_validate_msg("#empName_add_input","success","用户名可用");
                    $("#emp_save_btn").attr("ajax_val","success");
                }
                else{
                    show_validate_msg("#empName_add_input","error",result.extend.va_msg);
                    $("#emp_save_btn").attr("ajax_val","error");
                }
            }

        });
    });



    $("#emp_save_btn").click(function() {
        if(!validate_add_form()){
            return false;
        }
        if($("#emp_save_btn").attr("ajax_val")=="error"){
            return false;
        }
        $.ajax({
            url:"${APP_PATH}/emp",
            type:"POST",
            data:$("#empAddModel form").serialize(),
            success:function(result) {
                if(result.code==100) {
                    //alert(result.msg);
                    //关闭模态框
                    $('#empAddModel').modal('hide')
                }else{
                    if(undefined!=result.extend.errorFields.empName){
                        show_validate_msg("#empName_add_input","error",result.extend.errorFields.empName);
                        $("#emp_save_btn").attr("ajax_val","error");
                    }
                    if(undefined!=result.extend.errorFields.email){
                        show_validate_msg("#email_add_input","error",result.extend.errorFields.email);
                    }
                }
            }
        })
    });

    //为每个员工的编辑按钮绑定单击事件
    //但是，这里的单击事件是在编辑按钮被创建出来之前就已经开始绑定了，所以这里无法绑定单击事件
    //有两种办法
    //     1）可以在创建按钮的时候就给他绑定单击事件
    //     2）绑定单击.live()，而新版jQuery没有live方法，而是用on进行替代
    //推荐所有绑定的点击的事件都按照下方的写
    //.edit_btn代表类选择器，即类中包括edit_btn的标签，按钮等，都会绑定上这个事件，像上面的编辑按钮绑定了四个类
    $(document).on("click",".edit_btn",function () {
    //$(document).on("click","#edit_btn",function () {
        //alert("lgg");
        getDepts("#dept_update_select");
        getEmp($(this).attr("edit-id"));
        $("#emp_update_btn").attr("edit-id",$(this).attr("edit-id"));
        $("#empUpdateModel").modal({
            backdrop:"static"
        });
    });

    //$(document).on("click",".del_btn",function () {



    function getEmp(id){
        $.ajax({
            url:"${APP_PATH}/emp/"+id,
            type:"GET",
            success:function (result) {
                console.log(result);
                var empData=result.extend.emp;
                $("#empName_update_static").text(empData.empName);
                //显示邮箱
                $("#email_update_input").val(empData.email);
                //选中性别单选框
                $("#empUpdateModel input[name = gender]").val([empData.gender]);
                //选中部门
                $("#empUpdateModel select").val([empData.dId]);
            }
        });
    }

    $(document).on("click","#emp_update_btn",function () {
    //$("#emp_update_btn").click(function(){
        //alert($("#empUpdateModel form").serialize());
        //验证邮箱是否合法
        var email = $("#email_update_input").val();
        var regEmail=/^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if(!regEmail.test(email)){
            //记得先清空
            show_validate_msg("#email_update_input","error","邮箱格式错误");
            // $("#email_add_input").parent().addClass("has-error");
            // $("#email_add_input").next("span").text("邮箱格式错误");
            return false;
        }
        else{
            show_validate_msg("#email_update_input","success","");
            // $("#email_add_input").parent().addClass("has-success");
            // $("#email_add_input").next("span").text("");
        }
        $.ajax({
            url:"${APP_PATH}/emp/"+$(this).attr("edit-id"),
            type:"PUT",
            data:$("#empUpdateModel form").serialize(),
            success:function (result) {
                $("#empUpdateModel").modal("hide");
                to_page(1);
            }
        })


    });

    //单个删除
    $(document).on("click",".delete_btn",function () {
        //弹出删除对话框
        //alert($(this).parents("tr").find("td:eq(1)").text());//代表删除删除按钮祖先的tr节点的第二个td节点，即员工姓名。
        var empName=$(this).parents("tr").find("td:eq(2)").text();
        if(confirm("确认删除【"+empName+"】吗？")){
            $.ajax({
                url:"${APP_PATH}/emp/"+$(this).attr("del-id"),
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(1);
                }
            });
        }


    });

    //完成全选
    $("#check_all").click(function () {

        $(".check_item").prop("checked",$(this).prop("checked"));
    });

    $("#emp__delete_all_btn").click(function () {
        //$(".check_item:checked")
        var empNames="";
        var del_idstr="";
        $.each($(".check_item:checked"),function () {//遍历被选中的项
            //alert($(this).parents("tr").find("td:eq(2)").text());
            empNames+=$(this).parents("tr").find("td:eq(2)").text()+",";
            del_idstr+=$(this).parents("tr").find("td:eq(1)").text()+"-";
        });
        empNames=empNames.substring(0,empNames.length-1);
        del_idstr=del_idstr.substring(0,del_idstr.length-1);
        if(confirm("确认删除【"+empNames+"】吗？")) {
            $.ajax({
                url:"${APP_PATH}/emp/"+del_idstr,
                type:"DELETE",
                success:function (result) {
                    alert(result.msg);
                    to_page(1);
                }
            })
        }
    });







</script>
</body>
</html>
