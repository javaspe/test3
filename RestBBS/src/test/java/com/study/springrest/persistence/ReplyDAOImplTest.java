package com.study.springrest.persistence;

import java.util.Iterator;
import java.util.List;

import javax.inject.Inject;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.study.springrest.domain.ReplyVO;
import com.study.springrest.domain.RestVO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration( locations={"file:src/main/webapp/WEB-INF/spring/**/*.xml"})
public class ReplyDAOImplTest {

	@Inject
	private ReplyDAO dao;

	@Test
	public void test(){
		System.out.println("DAT = "+dao);
	}

	@Test
	public void insertTest() throws Exception{
		ReplyVO vo = new ReplyVO();
		vo.setContent("테스트내용");
		vo.setUser_name("테스트유저");
		vo.setBoard_no(7);
		dao.insert(vo);
	}

	@Test
	public void getTest() throws Exception{
		int board_no = 11;
		ReplyVO vo = dao.get(board_no);
		System.out.println("이름:"+vo.getUser_name());
	}
	
	@Test
	public void getListTest() throws Exception{
		List<ReplyVO> list = dao.getList(6);
		Iterator<ReplyVO> it = list.iterator();
		while(it.hasNext()){
			ReplyVO vo = it.next();
			System.out.println("이름:"+vo.getUser_name());
		}
	}
	
	@Test
	public void updateTest() throws Exception{
		ReplyVO vo = new ReplyVO();

		vo.setContent("수정내용");
		vo.setUser_name("수정유저");
		vo.setBoard_no(2);
		dao.update(vo);
	}
	
	@Test
	public void deleteTest() throws Exception{
		dao.delete(3);
	}
	
}
