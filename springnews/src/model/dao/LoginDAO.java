package model.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import model.vo.LoginVO;

@Repository
public class LoginDAO {
	@Autowired
	SqlSession session = null;
	
	/*중복체크*/
	public boolean check(LoginVO vo){
		boolean result = false;
		System.out.println(vo);
		try {
			String statement = "resource.NewsMapper.selectLogin";
			int ret = session.selectOne(statement, vo);
//			System.out.println(ret);
			result = ret == 1 ? true : false;	
			
		}catch (Exception e) {
			e.printStackTrace();
		}           
		return result;
	}
	
	/*회원가입*/
	public boolean Signup(LoginVO vo){
		boolean result = false;

		//[ 생성자 메서드 ]
		try {
			String statement = "resource.NewsMapper.insertLogin";
			session.insert(statement, vo);
			result = true;
			System.out.println("DAO => " + vo);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	/*로그인*/
	public boolean login(LoginVO vo){
		boolean result = false;
		HashMap map = new HashMap();
		try {
			String statement = "resource.NewsMapper.selectLogin";
			map.put("name", vo.getName());
			map.put("password", vo.getPassword());
			int ret = session.selectOne(statement, map);
			
			result = ret == 1 ? true : false;
		}catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
}
