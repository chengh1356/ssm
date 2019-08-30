package com.cgh.dao;



import com.cgh.domain.TUserrose;

import java.util.List;

public interface TUserroseMapper {
    int deleteByPrimaryKey(String urid);

    int insert(TUserrose record);

    TUserrose selectByPrimaryKey(String urid);

    List<TUserrose> selectAll();

    int updateByPrimaryKey(TUserrose record);
}