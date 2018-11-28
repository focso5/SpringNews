package model.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import model.vo.NewsVO;

@Repository
public class NewsMybatisDAO {
	@Autowired
	SqlSession session = null;
	

	public List<NewsVO> listAll(String date, int start, int end){
		List<NewsVO> list = null;	
		try {
			String statement = "resource.NewsMapper.selectPage";
			HashMap map = new HashMap<>();
			
			map.put("date", date);
			map.put("start", start);
			map.put("end", end);

			list = session.selectList(statement, map);
		}catch (Exception e) {
			e.printStackTrace();
		}           
		return list;
	}


	public List<NewsVO> listWriter(String date, String writer, int start, int end){
		List<NewsVO> list = null;
		HashMap map = new HashMap<>();

		try {
			String statement = "resource.NewsMapper.selectPage";

			
			map.put("writer", writer);
			map.put("date", date);
			map.put("start", start);
			map.put("end", end);

			list = session.selectList(statement, map);

		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public List<NewsVO> searchContent(String date, String key, String search, int start, int end){
		List<NewsVO> list = null;
		HashMap map = new HashMap<>();
		//[ 생성자 메서드 ]
		try {
			String statement = "resource.NewsMapper.selectPage";
			
			map.put("date", date);
			map.put("key", key);
			map.put("searchType", search);
			map.put("start", start);
			map.put("end", end);
			
			list = session.selectList(statement, map);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	public List<NewsVO> searchTitle(String date, String key, String search, int start, int end){
		List<NewsVO> list = null;
		HashMap map = new HashMap<>();
		//[ 생성자 메서드 ]
		try {
			String statement = "resource.NewsMapper.selectPage";
			        
			map.put("date", date);
			map.put("key", key);
			map.put("searchType", search);
			map.put("start", start);
			map.put("end", end);

			list = session.selectList(statement, map);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}


	

	public boolean insert(NewsVO vo,String date){
		boolean result = false;

		//[ 생성자 메서드 ]
		try {
			System.out.println("DAO" + vo);
			String statement = "resource.NewsMapper.insertNews";
			session.insert(statement, vo);
			result = true;
			System.out.println("insert : " + date);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean update(NewsVO vo){
		boolean result = false;
		//[ 생성자 메서드 ]
		try {
			String statement = "resource.NewsMapper.updateNews";
			session.update(statement, vo);
			result = true;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	public boolean delete(int id){
		boolean result = false;
		//[ 생성자 메서드 ]
		try {
			String statement = "resource.NewsMapper.deleteNews";
			session.delete(statement, id);
			result = true;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}


	public NewsVO listOne(int id, String date){
		HashMap map = new HashMap<>();
		NewsVO vo = null;
		//[ 생성자 메서드 ]
		try {
			String statement2 = "resource.NewsMapper.updateCount";
			String statement = "resource.NewsMapper.selectNewsOne";
			session.update(statement2,id);
			//One는 vo로 리턴
			vo = session.selectOne(statement, id);
			map.put("date", date);
			map.put("vo", vo);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return vo;
	}
	
	
	/*총 게시물 개수*/
	public int count(String date) {
		HashMap map = new HashMap<>();
		String statement = "resource.NewsMapper.cnt";
		
		System.out.println("dao : " + date);
		
		map.put("date", date);
		return session.selectOne(statement, map);
	}


	public int count2(String writer, String date) {
		HashMap map = new HashMap<>();
		String statement = "resource.NewsMapper.cnt";
		
		map.put("writer", writer);
		map.put("date", date);
		
		return session.selectOne(statement, map);
	}
	
	public int count3(String date, String key, String searchType) {
		HashMap map = new HashMap<>();
		String statement = "resource.NewsMapper.cnt";
			map.put("date", date);
			map.put("key", key);
			map.put("searchType", searchType);
		return session.selectOne(statement, map);
	}
}
