package com.blog.controller.admin;

import com.blog.model.User;
import com.blog.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/admin/profile")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("")
    public String profile() {
        return "admin/profile";
    }

    @ResponseBody
    @RequestMapping("/add")
    public String addUser(@RequestBody User user) {
        int result = userService.addUser(user);
        if (result == 1)
            return "success";
        else
            return "failed";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public String deleteUser(String userName) {
        int result = userService.deleteUserByName(userName);
        if (result == 1)
            return "success";
        else
            return "failed";
    }

    @RequestMapping("/update")
    @ResponseBody
    public String updateUser(@RequestParam String screenName, @RequestParam String email, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        user.setScreenName(screenName);
        user.setEmail(email);
        int result = userService.updateUserByName(user);
        if (result == 1)
            return "success";
        else
            return "failed";
    }

    @RequestMapping("/updatePassword")
    @ResponseBody
    public String updatePassword(@RequestParam String oldPwd, @RequestParam String newPwd, HttpServletRequest request) {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user.getPassword().equals(oldPwd)) {
            user.setPassword(newPwd);
            int result = userService.updateUserByName(user);
            if (result == 1)
                return "success";
            else
                return "failed";
        } else
            return "failed";
    }

    @ResponseBody
    @RequestMapping("/findByName")
    public List<User> findUserByName(String userName) {
        List<User> list = userService.findUserByName(userName);
        return list;
    }
}
