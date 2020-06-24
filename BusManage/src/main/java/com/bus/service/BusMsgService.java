package com.bus.service;

import com.bus.dao.BusMsgMapper;
import com.bus.model.BusMsg;
import com.bus.utils.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

/**
 * 留言
 */
@Service
public class BusMsgService {

    @Autowired
    private BusMsgMapper busMsgMapper;

    public Page<Map<String, Object>> getBusMsgList(String name, Integer userId, String content, Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        List<Map<String, Object>> list = busMsgMapper.getBusMsgList(name,userId,content);
        Page<Map<String, Object>> userPage = new Page<Map<String, Object>>();
        PageInfo<Map<String, Object>> info = new PageInfo<Map<String, Object>>(list);
        userPage.setPageNo(pageNo);
        userPage.setPageSize(pageSize);
        userPage.setResults(list);
        userPage.setTotalPage(info.getPages());
        userPage.setTotalRecord(info.getTotal());
        return userPage;
    }

    @Transactional
    public String addMsg(BusMsg msg) {
        busMsgMapper.save(msg);
        return "添加成功";
    }

    @Transactional
    public String deleteMsg(Integer id) {
        busMsgMapper.delete(id);
        return "删除成功";
    }

    @Transactional
    public String updateMsg(BusMsg msg) {
        busMsgMapper.updateMsg(msg);
        return "更新成功";
    }
}
