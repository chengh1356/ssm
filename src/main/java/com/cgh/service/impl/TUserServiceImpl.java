package com.cgh.service.impl;

import com.cgh.dao.TUserMapper;
import com.cgh.domain.TUser;
import com.cgh.service.TUserService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
@Service
public class TUserServiceImpl implements TUserService {
    @Resource
    private TUserMapper userMapper;
    public List<TUser> findAll() {
        return userMapper.findAll();
    }
}
