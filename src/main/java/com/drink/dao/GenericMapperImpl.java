package com.drink.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class GenericMapperImpl<T, C> implements GenericMapper<T, C> {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public T selectOne(String statement) {
		return sqlSession.selectOne(statement);
	}

	@Override
	public T selectOne(String statement, C parameter) {
		return sqlSession.selectOne(statement, parameter);
	}

	@Override
	public Map<String, Object> selectMap(String statement, String mapKey) {
		return sqlSession.selectMap(statement, mapKey);
	}

	@Override
	public Map<String, Object> selectMap(String statement, C parameter, String mapKey) {
		return sqlSession.selectMap(statement, parameter, mapKey);
	}

	@Override
	public Map<String, Object> selectMap(String statement, C parameter, String mapKey, RowBounds rowBounds) {
		return sqlSession.selectMap(statement, parameter, mapKey, rowBounds);
	}

	@Override
	public <E> List<E> selectList(String statement) {
		return sqlSession.selectList(statement);
	}

	@Override
	public <E> List<E> selectList(String statement, C parameter) {
		return sqlSession.selectList(statement, parameter);
	}

	@Override
	public <E> List<E> selectList(String statement, C parameter, RowBounds rowBounds) {
		return sqlSession.selectList(statement, parameter, rowBounds);
	}

	@Override
	public void select(String statement, ResultHandler<T> handler) {
		sqlSession.select(statement, handler);
	}

	@Override
	public void select(String statement, C parameter, ResultHandler<T> handler) {
		sqlSession.select(statement, parameter, handler);
	}

	@Override
	public void select(String statement, C parameter, RowBounds rowBounds, ResultHandler<T> handler) {
		sqlSession.select(statement, parameter, rowBounds, handler);
	}

	@Override
	public int insert(String statement) {
		return sqlSession.insert(statement);
	}

	@Override
	public int insert(String statement, C parameter) {
		return sqlSession.insert(statement, parameter);
	}

	@Override
	public int update(String statement) {
		return sqlSession.update(statement);
	}

	@Override
	public int update(String statement, C parameter) {
		return sqlSession.update(statement, parameter);
	}

	@Override
	public int delete(String statement) {
		return sqlSession.delete(statement);
	}

	@Override
	public int delete(String statement, C parameter) {
		return sqlSession.delete(statement, parameter);
	}

}
