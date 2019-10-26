package com.blog.controller.admin;

import com.blog.model.User;
import com.blog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Description:用户管理
 *
 * @authror: zhuangziyao
 * @date: 2018/9/23 13:43
 **/
@Controller
@RequestMapping("/admin/user")
public class AdminController {

    @Autowired
    private UserService userService;

    @RequestMapping("")
    public String user(HttpServletRequest request) {
        List<User> useres = userService.findAll();
        request.setAttribute("useres", useres);
        return "admin/user";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public String delete(@RequestParam String uname) {
        int result = userService.deleteUserByName(uname);
        if (result == 1)
            return "success";
        else
            return "failed";
    }

    @RequestMapping("/edit")
    @ResponseBody
    public String edit(@RequestParam User user) {
        int result = userService.updateUserByName(user);
        if (result == 1) {
            return "success";
        } else {
            return "failed";
        }
    }

    @RequestMapping("/add")
    @ResponseBody
    public String add(@RequestParam User user) {
        int result = userService.addUser(user);
        if (result == 1) {
            return "success";
        } else {
            return "failed";
        }
    }

    @RequestMapping("/get")
    @ResponseBody
    public User getUser(@RequestParam String uname) {
        List<User> user = userService.findUserByName(uname);
        return user.get(0);
    }
}
