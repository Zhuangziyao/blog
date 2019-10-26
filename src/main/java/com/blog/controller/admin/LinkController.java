package com.blog.controller.admin;

import com.blog.model.Meta;
import com.blog.service.MetaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/admin/links")
public class LinkController {

    @Autowired
    private MetaService metaService;

    @RequestMapping("")
    public String link(HttpServletRequest request) {
        List<Meta> metaList = metaService.findMetaByType("link");
        request.setAttribute("links", metaList);
        return "admin/links";
    }

    @RequestMapping("/delete")
    @ResponseBody
    public String delete(@RequestParam int mId) {
        int result = metaService.deleteById(mId);
        if (result == 1)
            return "success";
        else
            return "failed";
    }

    @RequestMapping("/save")
    @ResponseBody
    public String save(@RequestParam String name, @RequestParam String slug,
                       @RequestParam String description, @RequestParam Integer mId,
                       @RequestParam(value = "sort", defaultValue = "0") int sort) {
        int result;
        Meta meta = new Meta();
        try {
            if (mId != null)
                meta.setmId(mId);
            meta.setName(name);
            meta.setSlug(slug);
            meta.setSort(sort);
            meta.setDescription(description);
            if (meta.getType() == null)
                meta.setType("link");
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (meta.getmId() != null)
            result = metaService.updateById(meta);
        else
            result = metaService.insert(meta);
        if (result == 1)
            return "success";
        else
            return "failed";
    }
}
