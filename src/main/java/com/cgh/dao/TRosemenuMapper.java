package com.cgh.dao;



import com.cgh.domain.TRosemenu;

import java.util.List;

public interface TRosemenuMapper {
    int deleteByPrimaryKey(String rmid);

    int insert(TRosemenu record);

    TRosemenu selectByPrimaryKey(String rmid);

    List<TRosemenu> selectAll();

    int updateByPrimaryKey(TRosemenu record);
}