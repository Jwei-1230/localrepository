package com.bus.service;

import com.bus.dao.BusRepairToolMapper;
import com.bus.model.*;
import com.bus.utils.CommonConstant;
import com.bus.utils.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.ObjectUtils;

import javax.servlet.http.HttpSession;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 汽车工具
 */
@Service
public class ToolService {

    @Autowired
    private BusRepairToolMapper busRepairToolMapper;

    @Autowired
    private HttpSession session;

    /**
     * 分页查询
     * @param name 工具名称
     * @param pageNo 当前页
     * @param pageSize 每页大小
     * @return
     */
    public Page<Map<String, Object>> getBusToolList(String name, Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        List<Map<String, Object>> list = busRepairToolMapper.getBusToolList(name);
        Page<Map<String, Object>> page = new Page<Map<String, Object>>();
        PageInfo<Map<String, Object>> info = new PageInfo<Map<String, Object>>(list);
        page.setPageNo(pageNo);
        page.setPageSize(pageSize);
        page.setResults(list);
        page.setTotalPage(info.getPages());
        page.setTotalRecord(info.getTotal());
        return page;
    }

    /**
     * 新增工具
     * @param tool
     * @return
     */
    @Transactional
    public String addTool(BusRepairTool tool) {
        Integer count = busRepairToolMapper.countToolByName(tool.getName());
        if (!ObjectUtils.isEmpty(count) && count > 0) {
            return tool.getName()+"已经存在，请更改名称";
        }
        busRepairToolMapper.save(tool);
        if (!ObjectUtils.isEmpty(tool.getBalance()) && tool.getBalance() > 0) {
            BusRepairToolOperate busRepairToolOperate = new BusRepairToolOperate();
            busRepairToolOperate.setBalanceAmount(0);
            busRepairToolOperate.setCreateTime(new Date());
            busRepairToolOperate.setCreateUser(tool.getCreateUser());
            busRepairToolOperate.setToolId(tool.getId());
            busRepairToolOperate.setRemark("初始入库");
            busRepairToolOperate.setOperateAmount(tool.getBalance());
            busRepairToolOperate.setType(1);
            busRepairToolMapper.saveOperate(busRepairToolOperate);
        }
        return "新增工具成功";
    }

    /**
     * 工具操作记录
     * @param name
     * @param pageNo
     * @param pageSize
     * @return
     */
    public Page<Map<String, Object>> getToolOperateList(String name, Integer pageNo, Integer pageSize) {
        PageHelper.startPage(pageNo, pageSize);
        List<Map<String, Object>> list = busRepairToolMapper.getToolOperateList(name);
        Page<Map<String, Object>> page = new Page<Map<String, Object>>();
        PageInfo<Map<String, Object>> info = new PageInfo<Map<String, Object>>(list);
        page.setPageNo(pageNo);
        page.setPageSize(pageSize);
        page.setResults(list);
        page.setTotalPage(info.getPages());
        page.setTotalRecord(info.getTotal());
        return page;
    }

    /**
     * 删除工具
     * @param id
     * @return
     */
    @Transactional
    public String deleteBusTool(Integer id) {
        busRepairToolMapper.delete(id);
        busRepairToolMapper.deleteOperate(id);
        return "删除成功";
    }

    /**
     * 出入库操作
     * @param id
     * @param amount
     * @param type 1 入库 2出库
     * @return
     */
    @Transactional
    public String operateChuRuKu(Integer id, Integer amount,Integer type) {
       BusRepairTool tool =  busRepairToolMapper.get(id);
        BusUser user = (BusUser) session.getAttribute(CommonConstant.USER);
       if (ObjectUtils.isEmpty(tool)) {
           return "工具数据不存在";
       }
       if (type == 2) {
           //出库操作,
           if (amount > tool.getBalance()) {
               return "库存数量不足，无法出库";
           }
       }

       Integer balance = tool.getBalance();
        tool.setBalance(type == 1 ? (balance + amount) : (balance - amount));
        Integer count = busRepairToolMapper.update(tool);
        if (count <= 0) {
            return "系统繁忙，请稍后重试";
        }

        BusRepairToolOperate busRepairToolOperate = new BusRepairToolOperate();
        busRepairToolOperate.setBalanceAmount(balance);
        busRepairToolOperate.setCreateTime(new Date());
        busRepairToolOperate.setCreateUser(user.getId());
        busRepairToolOperate.setToolId(tool.getId());
        busRepairToolOperate.setRemark(type == 1 ? "手动入库":"手动出库");
        busRepairToolOperate.setOperateAmount(amount);
        busRepairToolOperate.setType(type);
        busRepairToolMapper.saveOperate(busRepairToolOperate);

        return type == 1 ? "入库成功":"出库成功";
    }

    public List<Map<String, Object>> getToolData() {
        return busRepairToolMapper.getToolData();
    }
}
