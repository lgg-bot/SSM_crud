package com.atguigu.crud.test;
import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/**
 * 测试dao层的工作
 * 推荐Spring的项目可以使用Spring的单元测试，可以自动注入我们需要的组件
 *
 * 1、导入SpringTest模块
 * 2、@ContextConfiguration指定Spring配置文件的位置
 *  ，@RunWith(SpringJUnit4ClassRunner.class)让测试运行于Spring测试环境
 * 3、直接autowired要使用的组件即可
 */

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {

    @Autowired
    DepartmentMapper departmentMapper;

    @Autowired
    EmployeeMapper employeeMapper;

    @Autowired
    SqlSession sqlSession;

    @Test
    public void testCRUD(){
////        1、创建SpringIOC容器
//        ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
////        2、从容器中获取mapper
//        DepartmentMapper mapper = ac.getBean(DepartmentMapper.class);
//        System.out.println(departmentMapper);
//
//        //测试部门插入
//        departmentMapper.insertSelective(new Department(null,"营销部"));
//        departmentMapper.insertSelective(new Department(null,"测试部"));

//        System.out.println(employeeMapper);
//        //测试插入员工
//        employeeMapper.insertSelective(new Employee(null,"李钦伦","m","5565@qq.com",3));


        //批量插入员工
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for(int i = 0; i < 100; i++){
            String uuid = UUID.randomUUID().toString().substring(0, 5) + i;
            mapper.insertSelective(new Employee(null, uuid, "F", uuid + "@gmail.com", 2));
        }
        System.out.println("success!!");

    }
}
