package com.cgh.dao;



import com.cgh.domain.TPccdb;

import java.util.List;

public interface TPccdbMapper {
    int deleteByPrimaryKey(String pcid);

    int insert(TPccdb record);

    TPccdb selectByPrimaryKey(String pcid);

    List<TPccdb> selectAll();

    int updateByPrimaryKey(TPccdb record);
}