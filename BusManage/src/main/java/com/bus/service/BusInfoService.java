package com.bus.service;

import com.bus.dao.BusInfoMapper;
import com.bus.model.BusInfo;
import com.bus.utils.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class BusInfoService {

    @Autowired
    private BusInfoMapper busInfoMapper;

    public Page<Map<String, Object>> getBusList(String name, Integer userId, String busName, Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        List<Map<String, Object>> list = busInfoMapper.getBusList(name,userId,busName);
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
    public String addBus(BusInfo info) {
        busInfoMapper.save(info);
        return "添加成功";
    }

    @Transactional
    public String deleteBus(Integer id) {
        busInfoMapper.delete(id);
        return "删除成功";
    }

    @Transactional
    public String updateBus(BusInfo info) {
        busInfoMapper.updateBus(info);
        return "更新成功";
    }

    public List<Map<String, Object>> getBusByUserId(Integer userId) {
        return busInfoMapper.getBusByUserId(userId);
    }
}
