package com.cgh.service.base;

import java.util.List;

public interface ViewBaseService<T,K> {
    List<T> selectAll();
    List<T> selectById(K id);
}
