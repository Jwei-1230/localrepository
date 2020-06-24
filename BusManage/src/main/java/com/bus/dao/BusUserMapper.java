package com.bus.dao;

import com.bus.model.BusUser;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface BusUserMapper {
    /**
     * 根据用户名获取用户
     * @param userName
     * @return
     */
    List<BusUser> getUserByUserName(@Param("userName") String userName);

    /**
     * 分页查询用户
     * @param name 用户名称
     * @param role 用户角色
     * @param phone 用户电话
     * @return
     */
    List<Map<String, Object>> getBusUserList(@Param("name")String name,@Param("userId") Integer userId,@Param("phone") String phone);

    /**
     * 保存用户信息
     * @param user
     */
    void save(BusUser user);

    /**
     * 删除用户
     * @param id
     */
    void delete(Integer id);

    /**
     * 更新用户
     * @param user
     */
    void updateUser(BusUser user);

    Integer countUserByName(@Param("userName") String userName);

    List<Map<String, Object>> getUserByRole(@Param("role") Integer role);
}
