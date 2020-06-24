package com.bus.service;

import com.bus.dao.BusUserMapper;
import com.bus.model.BusUser;
import com.bus.utils.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class BusUserService {

    @Autowired
    private BusUserMapper busUserMapper;

    public List<BusUser> getUserByUserName(String userName) {
        return busUserMapper.getUserByUserName(userName);
    }

    public Page<Map<String, Object>> getBusUserList(String name, Integer userId, String phone, Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        List<Map<String, Object>> list = busUserMapper.getBusUserList(name,userId,phone);
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
    public String addUser(BusUser user) {
        Integer count = busUserMapper.countUserByName(user.getUserName());
        if (count > 0) {
            return user.getUserName()+"用户名已经存在";
        }
        busUserMapper.save(user);
        return "添加成功";
    }

    @Transactional
    public String deleteBusUser(Integer id) {
        busUserMapper.delete(id);
        return "删除成功";
    }

    @Transactional
    public String updateUser(BusUser user) {
        busUserMapper.updateUser(user);
        return "更新成功";
    }

    public List<Map<String, Object>> getUserByRole(Integer role) {
        return busUserMapper.getUserByRole(role);
    }
}
