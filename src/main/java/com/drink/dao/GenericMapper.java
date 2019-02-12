package com.drink.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;

public interface GenericMapper<T, C> {

	public T selectOne(String statement);

	public T selectOne(String statement, C parameter);

	public Map<String, Object> selectMap(String statement, String mapKey);

	public Map<String, Object> selectMap(String statement, C parameter, String mapKey);

	public Map<String, Object> selectMap(String statement, C parameter, String mapKey, RowBounds rowBounds);

	public <E> List<E> selectList(String statement);

	public <E> List<E> selectList(String statement, C parameter);

	public <E> List<E> selectList(String statement, C parameter, RowBounds rowBounds);

	public void select(String statement, ResultHandler<T> handler);

	public void select(String statement, C parameter, ResultHandler<T> handler);

	public void select(String statement, C parameter, RowBounds rowBounds, ResultHandler<T> handler);

	public int insert(String statement);

	public int insert(String statement, C parameter);

	public int update(String statement);

	public int update(String statement, C parameter);

	public int delete(String statement);

	public int delete(String statement, C parameter);

}
