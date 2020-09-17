package com.atguigu.crud.controller;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
处理员工crud
 */

@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    //一般来说     post请求：新增       get请求：查询       put请求：修改      delete请求：删除

    //单个和批量删除合并
    @ResponseBody
    @RequestMapping(value = "/emp/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids") String ids) {
        if(ids.contains("-")){//批量
            System.out.println(ids);
            List<Integer> del_ids=new ArrayList<Integer>();
            String[] str_ids=ids.split("-");
            for(String string:str_ids){
                del_ids.add(Integer.parseInt(string));
            }
            employeeService.deleteBatch(del_ids);
            return Msg.success();
        }
        else{//单个
            employeeService.deleteEmp(Integer.parseInt(ids));
            return Msg.success();
        }
    }



    @ResponseBody
    @RequestMapping(value = "/emp/{empId}",method = RequestMethod.PUT)
    public Msg updateEmp(Employee employee){
        System.out.println(employee);
        employeeService.updateEmp(employee);
        return Msg.success();
    }



    //查询员工
    @ResponseBody
    @RequestMapping(value = "/emp/{id}",method = RequestMethod.GET)
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee=employeeService.getEmp(id);
        return Msg.success().add("emp",employee);
    }

    //检查用户名是否可用
    @ResponseBody
    @RequestMapping(value = "/checkuser")
    public Msg checkuser(String empName){
        String regx="(^[\\u2E80-\\u9FFF]{2,4})";
        if(!empName.matches(regx)){
            return Msg.fail().add("va_msg","用户名必须是2-4位中文组成");
        }
        boolean b=employeeService.checkUser(empName);
        if(b){
            return Msg.success();
        }
        else{
            return Msg.fail().add("va_msg","用户名不可用");

        }

    }
    /*
        保存员工
     */
    @ResponseBody
    @RequestMapping(value = "/emp",method = RequestMethod.POST)
    public Msg saveEmp(@Valid Employee employee, BindingResult result){
        if(result.hasErrors()){
            //在模态框中显示校验失败信息
            Map<String,Object> map=new HashMap<String,Object>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError fieldError:errors){
                System.out.println("错误的字段名"+fieldError.getField());
                System.out.println("错误的信息"+fieldError.getDefaultMessage());
                map.put(fieldError.getField(),fieldError.getDefaultMessage());
            }
            return Msg.fail().add("errorFields",map);
        }
        else{
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    /**
     *  @ResponseBody是为了将返回的对象转换为json对象，方便在ajax回调函数中解析
     * .@ResponseBody要能正常工作，需要导入jackson包
     */
    @ResponseBody
    @RequestMapping("/emps")
    public Msg getEmpsWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn){

//        引入pageHelper分页查询，
//        在查询之前只需要调用PageHelper.startPage()，传入页码，以及每一页显示的数量
        PageHelper.startPage(pn,5);
//        分页完之后的查询就是分页查询
        List<Employee> emps = employeeService.getALL();

//        分页查询完之后，可以使用pageInfo来包装查询后的结果，
//        只需要将pageInfo交给页面就行
//        pageInfo封装了详细的分页信息，包括我们查询出来的数据
//        比如总共有多少页，当前是第几页等。。。
//        想要连续显示5页，就加上参数5即可
        PageInfo pageInfo = new PageInfo(emps,5);
        return Msg.success().add("pageInfo", pageInfo);
    }

    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn",defaultValue = "1")Integer pn,
                          Model model){

        //引入pageHelper
        PageHelper.startPage(pn,5);//每页包含多少记录
        List<Employee> emps= employeeService.getALL();
        //使用pageinfo包装
        PageInfo page=new PageInfo(emps,5);//一页上显示多少页码，比如当前为第四页，就显示23456

        model.addAttribute("pageInfo",page);
        return "list";
    }
}
