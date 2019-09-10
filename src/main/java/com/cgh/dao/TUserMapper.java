package com.cgh.dao;



import com.cgh.domain.TUser;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TUserMapper extends JpaRepository<TUser,String> {
    int deleteByPrimaryKey(String uid);

    int insert(TUser record);

    TUser selectByPrimaryKey(String uid);

    List<TUser> selectAll();

    int updateByPrimaryKey(TUser record);
}