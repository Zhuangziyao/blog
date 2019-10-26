package com.blog.controller.admin;

import com.blog.model.Option;
import com.blog.service.SettingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("/admin/setting")
public class SettingController {
    @Autowired
    private SettingService settingService;

    @RequestMapping("")
    public String setting(HttpServletRequest request) {
        List<Option> list = settingService.findAll();
        Map<String, String> options = new HashMap<>();
        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getValue() == null)
                options.put(list.get(i).getName(), "");
            else
                options.put(list.get(i).getName(), list.get(i).getValue());
        }
        request.setAttribute("options", options);
        return "admin/setting";
    }

    @RequestMapping("/save")
    @ResponseBody
    public String setting(@RequestParam Map<String, String> map, HttpServletRequest request) {
        List<Option> list = new ArrayList<>();
        //遍历map
        Iterator<Map.Entry<String, String>> it = map.entrySet().iterator();
        while (it.hasNext()) {
            Map.Entry<String, String> entry = it.next();
            Option option = new Option();
            option.setName(entry.getKey());
            option.setValue(entry.getValue());
            list.add(option);
        }
        int result = settingService.updateByName(list);
        if (result == list.size())
            return "success";
        else
            return "failed";
    }
}
