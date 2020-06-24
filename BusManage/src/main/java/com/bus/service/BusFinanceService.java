package com.bus.service;

import com.bus.dao.BusOrderMapper;
import com.bus.utils.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class BusFinanceService {
    @Autowired
    private BusOrderMapper busOrderMapper;

    public Page<Map<String, Object>> getCompleteOrderList(Integer userId,String name, String orderNo, Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        List<Map<String, Object>> list = busOrderMapper.getCompleteOrderList(name,orderNo,userId);
        Page<Map<String, Object>> userPage = new Page<Map<String, Object>>();
        PageInfo<Map<String, Object>> info = new PageInfo<Map<String, Object>>(list);
        userPage.setPageNo(pageNo);
        userPage.setPageSize(pageSize);
        userPage.setResults(list);
        userPage.setTotalPage(info.getPages());
        userPage.setTotalRecord(info.getTotal());
        return userPage;
    }

    @Transactional(rollbackFor = Exception.class)
    public String doJieSuan(Integer id) {
        busOrderMapper.doJieSuan(id);
        return "结算成功";
    }

    /**
     * 获取欠款信息
     * @param userId 客户id
     * @param name 客户
     * @param pageNo
     * @param pageSize
     * @return
     */
    public Page<Map<String, Object>> getQiKuanList(Integer userId, String name, Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        List<Map<String, Object>> list = busOrderMapper.getQiKuanList(name,userId);
        Page<Map<String, Object>> userPage = new Page<Map<String, Object>>();
        PageInfo<Map<String, Object>> info = new PageInfo<Map<String, Object>>(list);
        userPage.setPageNo(pageNo);
        userPage.setPageSize(pageSize);
        userPage.setResults(list);
        userPage.setTotalPage(info.getPages());
        userPage.setTotalRecord(info.getTotal());
        return userPage;
    }

    @Transactional(rollbackFor = Exception.class)
    public String doJieSuanAll(Integer id) {
        busOrderMapper.doJieSuanAll(id);
        return "结算成功";
    }

    public Page<Map<String, Object>> getYuShouKuanList(Integer userId, String name, String orderNo, Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        List<Map<String, Object>> list = busOrderMapper.getYuShouKuanList(name,orderNo,userId);
        Page<Map<String, Object>> userPage = new Page<Map<String, Object>>();
        PageInfo<Map<String, Object>> info = new PageInfo<Map<String, Object>>(list);
        userPage.setPageNo(pageNo);
        userPage.setPageSize(pageSize);
        userPage.setResults(list);
        userPage.setTotalPage(info.getPages());
        userPage.setTotalRecord(info.getTotal());
        return userPage;
    }
}
