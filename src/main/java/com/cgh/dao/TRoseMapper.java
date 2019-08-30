package com.cgh.dao;



import com.cgh.domain.TRose;

import java.util.List;

public interface TRoseMapper {
    int deleteByPrimaryKey(String rid);

    int insert(TRose record);

    TRose selectByPrimaryKey(String rid);

    List<TRose> selectAll();

    int updateByPrimaryKey(TRose record);
}