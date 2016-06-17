package com.study.springrest.persistence;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.study.springrest.domain.RestVO;

@Repository
public class RestDAOImpl implements RestDAO {
	
	@Inject
	private SqlSession session;
	private static String namespace="com.study.springrest.mappers.restMapper";

	@Override
	public void insert(RestVO vo) {
		session.insert(namespace+".insert", vo);
	}
	
	@Override
	public void increaseReply(int board_no) {
		session.update(namespace+".increaseReply", board_no);
	}

	@Override
	public RestVO get(int board_no) {
		return session.selectOne(namespace+".get", board_no);
	}

	@Override
	public List<RestVO> getList() {
		return session.selectList(namespace+".getList");
	}
	
	@Override
	public void update(RestVO vo) {
		session.update(namespace+".update", vo);
	}
	
	@Override
	public void delete(int board_no) {
		session.delete(namespace+".delete", board_no);
	}

}
