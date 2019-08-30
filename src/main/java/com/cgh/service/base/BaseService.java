package com.cgh.service.base;

import java.util.List;

public interface BaseService<T> {
    int deleteByPrimaryKey(String id);

    int insert(T entity);

    T selectByPrimaryKey(String aid);

    List<T> selectAll();

    int updateByPrimaryKey(T entity);

    List<T> selectByPageNumSize(Integer pageNum, Integer pageSize);
}
