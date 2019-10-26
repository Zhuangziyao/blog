package com.blog.controller.admin;

import com.blog.model.Attach;
import com.blog.model.User;
import com.blog.service.AttachService;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Description:attach
 *
 * @authror: zhuangziyao
 * @date: 2018/9/19 12:58
 **/
@Controller
@RequestMapping("/admin/attach")
public class AttachController {

    @Autowired
    private AttachService attachService;

    @RequestMapping("")
    public String attach(HttpServletRequest request) {
        List<Attach> attaches = attachService.findAll();
        request.setAttribute("attaches", attaches);
        return "admin/attach";
    }

    @RequestMapping("/upload")
    @ResponseBody
    public String upload(HttpServletRequest request, @RequestParam("file") MultipartFile[] multipartFiles) throws IOException {
        User user = (User) request.getSession().getAttribute("user");
        Date date = new Date();
        String path = request.getSession().getServletContext().getRealPath("/upload");
        File file = new File(path);
        //若路径不存在则创建
        if (!file.exists()) {
            file.mkdir();
        }

        try {
            for (MultipartFile multipartFile : multipartFiles) {
                String fname = multipartFile.getOriginalFilename();//全名
                String ftype = fname.substring(fname.lastIndexOf(".") + 1);//文件后缀名
                path = path + "/" + fname;
                String savePath = "/upload/" + fname;
                Attach attach = new Attach();
                attach.setFname(fname);
                attach.setAuthorId(user.getuId());
                attach.setFtype(checkType(ftype) == true ? "image" : ftype);
                attach.setCreated((int) (date.getTime() / 1000));
                try {
                    FileUtils.copyInputStreamToFile(multipartFile.getInputStream(), new File(path));
                    attach.setFkey(savePath);
                    attachService.insert(attach);
                } catch (IOException E) {
                    System.out.println(E.getMessage());
                    E.printStackTrace();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "success";
    }

    public boolean checkType(String type) {
        if (type.equals("png") || type.equals("jpg") || type.equals("jpeg")
                || type.equals("bmp") || type.equals("ico") || type.equals("gif"))
            return true;
        else
            return false;
    }

    @RequestMapping("/delete")
    @ResponseBody
    public String deleteAttach(@RequestParam int id, HttpServletRequest request) {
        String savePath = attachService.findPathById(id);
        String path = request.getSession().getServletContext().getRealPath("upload");
        String deletePath = path + "/" + savePath.split("/upload/")[1];
        System.out.println(deletePath);
        File file = new File(deletePath);
        if (file.exists()) {
            file.delete();
            attachService.deleteById(id);
            return "success";
        } else {
            attachService.deleteById(id);
            return "failed";
        }

    }

}
