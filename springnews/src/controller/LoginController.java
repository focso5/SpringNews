package controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import model.dao.LoginDAO;
import model.vo.LoginVO;

@Controller
public class LoginController {
	@Autowired
	LoginDAO dao;
	ModelAndView mav = new ModelAndView();
	
	/*로그인*/
	@RequestMapping("login.do")
	public ModelAndView login(LoginVO vo, HttpServletRequest request) {
		ModelAndView mav = new ModelAndView();   
		System.out.println(vo);
		if(vo.getName()!=null && vo.getPassword()!=null) {
			/*관리자 로그인*/
			if(vo.getName().equals("spring") && vo.getPassword().equals("1234")) {
				HttpSession session = request.getSession();	
				session.setAttribute("user", "admin");
			}
			dao.login(vo);
		}
		mav.setView(new RedirectView("news.do"));
		return mav;
	}
	
	/*중복체크*/
	@RequestMapping(value="checkSignup", method=RequestMethod.POST)
	@ResponseBody
	public boolean checkSignup(LoginVO vo) {
		System.out.println(vo);
		return  dao.check(vo);
	}
	
	/*회원가입*/
	@RequestMapping(value="Signup", method=RequestMethod.POST)
	public ModelAndView Signup(LoginVO vo) {
		ModelAndView mav = new ModelAndView();
		String[] str = vo.getEmail().split(",");
		/*for (String string : str) {
			System.out.println(string);
		}*/
		
		String name = str[0] + "@" + str[1];
		vo.setEmail(name);
		System.out.println(vo);
		boolean signupMsg = dao.Signup(vo);
		if(signupMsg) {
			mav.addObject("Signup_msg", vo.getName() + "님 환영합니다.");
		}
		mav.setView(new RedirectView("news.do"));
		
		return mav;
	}
	
	/*로그아웃*/
	@RequestMapping("logout.do")
	public RedirectView logout(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		
		return new RedirectView("news.do");
	}
}
