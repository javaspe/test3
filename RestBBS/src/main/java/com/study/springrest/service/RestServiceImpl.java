package com.study.springrest.service;

import java.util.List;
import javax.inject.Inject;
import org.springframework.stereotype.Service;
import com.study.springrest.domain.RestVO;
import com.study.springrest.persistence.RestDAO;

@Service
public class RestServiceImpl implements RestService {
	
	@Inject 
	private RestDAO dao;

	@Override
	public RestVO get(int reply_no) {
		return dao.get(reply_no);
	}

	@Override
	public List<RestVO> getList() {
		return dao.getList();
	}

	@Override
	public void insert(RestVO vo) {
		dao.insert(vo);
	}

	@Override
	public void update(RestVO vo) {
		dao.update(vo);
	}

	@Override
	public void delete(int reply_no) {
		dao.delete(reply_no);
	}

}
