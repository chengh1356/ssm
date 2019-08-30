package com.cgh.dao;



import com.cgh.domain.TUser;

import java.util.List;

public interface TUserMapper {
    int deleteByPrimaryKey(String uid);

    int insert(TUser record);

    TUser selectByPrimaryKey(String uid);

    List<TUser> selectAll();

    int updateByPrimaryKey(TUser record);
}