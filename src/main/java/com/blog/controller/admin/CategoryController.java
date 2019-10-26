package com.blog.controller.admin;

import com.blog.model.Meta;
import com.blog.model.MetaDto;
import com.blog.service.MetaService;
import com.blog.service.RelationshipService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@RequestMapping("/admin/category")
public class CategoryController {

    @Autowired
    private MetaService metaService;

    @Autowired
    private RelationshipService relationshipService;

    @RequestMapping("")
    public String category(HttpServletRequest request) {
        List<MetaDto> metas = metaService.findMetaDtoByType("category");
        for (int i = 0; i < metas.size(); i++) {
            metas.get(i).setCount(relationshipService.findCount(metas.get(i).getmId()));
        }
        List<MetaDto> metaDtos = metaService.findMetaDtoByType("tags");
        for (int i = 0; i < metaDtos.size(); i++) {
            metaDtos.get(i).setCount(relationshipService.findCount(metaDtos.get(i).getmId()));
        }
        request.setAttribute("category", metas);
        request.setAttribute("tags", metaDtos);

        return "admin/category";
    }

    @RequestMapping("/add")
    @ResponseBody
    public String addCategory(@RequestParam String cname) {
        int count = metaService.findCountByName(cname);
        if (count == 0) {
            Meta meta = new Meta();
            meta.setName(cname);
            meta.setType("category");
            int result = metaService.insert(meta);
            if (result == 1)
                return "success";
            else
                return "failed";
        } else {
            return "failed";
        }
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
}
