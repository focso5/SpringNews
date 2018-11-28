package controller;

import java.time.LocalDate;
import java.time.YearMonth;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import model.dao.NewsMybatisDAO;
import model.vo.NewsVO;
@Controller

public class NewsController{        
	@Autowired
	NewsMybatisDAO dao; 
	ModelAndView mav = new ModelAndView();


//리스트 출력
	@RequestMapping("/news.do")
	public ModelAndView listAll(@RequestParam(defaultValue="1") int page, String date, HttpSession session) {
		session.setAttribute("date1", date);
		//현재 날짜(2018.10) 출력		
		LocalDate now = null;
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy.MM");
		
		if(date == null || date.equals("")) {   
			now = LocalDate.now();
			mav.addObject("today", now.format(dtf));			
		} else {
			now = YearMonth.parse(date, dtf).atDay(1);
			mav.addObject("today", now.format(dtf));
		}
		PageControl pc = new PageControl(page, dao.count(now.format(dtf)));	
		
		mav.addObject("next", now.plusMonths(1).format(dtf));
		mav.addObject("pre",  now.minusMonths(1).format(dtf));
	
		List<NewsVO> d = dao.listAll(now.format(dtf), pc.getWritingStart(), pc.getWritingEnd());
		mav.addObject("list", d);

		/*페이지 번호 출력*/
		mav.addObject("end", pc.getPageEnd());
		mav.addObject("start", pc.getPageStart());          
		mav.addObject("total", pc.getPageCount()); //총 페이지 수
		
		mav.setViewName("newsView");
		return mav;
	}

	
//게시물 삭제
	@RequestMapping(value="delete", method=RequestMethod.GET)
	public ModelAndView delete(@RequestParam(defaultValue="1") int page, String date, NewsVO vo) {
		PageControl pc = new PageControl(page, dao.count(date));
		boolean result = dao.delete(vo.getId());
		if(result) {
			mav.addObject("list", dao.listAll(date, pc.getWritingStart(), pc.getWritingEnd()) );
		}else {
			mav.addObject("msg", vo.getId() + "번 글이 존재하지 않습니다.");
		}
				
		mav.setViewName("newsView");
		return mav;
	}

	
//게시물 읽기
	@RequestMapping(value="read", method=RequestMethod.GET)
	public ModelAndView read(String date, @RequestParam(defaultValue="1") int page, NewsVO vo) {
		PageControl pc = new PageControl(page, dao.count(date));
		vo = dao.listOne(vo.getId(), date);
		if(vo != null) {
			mav.addObject("vo", vo);		
			mav.addObject("list", dao.listAll(date, pc.getWritingStart(), pc.getWritingEnd()) );				
		}

		mav.setViewName("newsView");
		return mav;
	}

	
//게시물 찾기
	@RequestMapping(value="search", method=RequestMethod.GET)
	public ModelAndView search(String date, @RequestParam(defaultValue="1") int page, String searchType, String key) {
		PageControl pc = new PageControl(page, dao.count3(date, key, searchType));
		
		mav.addObject("list", dao.searchTitle(date, key, searchType, pc.getWritingStart(), pc.getWritingEnd()));
 
		mav.addObject("end", pc.getPageEnd());
		mav.addObject("start", pc.getPageStart());
		mav.addObject("total", pc.getPageCount());
		mav.setViewName("newsView");
		return mav;
	}

	
//작성자 명으로 찾기
	@RequestMapping(value="listWriter", method=RequestMethod.GET)
	public ModelAndView listWriter(String date, @RequestParam(defaultValue="1") int page, NewsVO vo) {
		PageControl pc = new PageControl(page, dao.count2(date, vo.getWriter()));

		mav.addObject("list", dao.listWriter(date, vo.getWriter(),pc.getWritingStart(), pc.getWritingEnd()));
		mav.addObject("end", pc.getPageEnd());
		mav.addObject("start", pc.getPageStart());
		mav.addObject("total", pc.getPageCount());
		mav.setViewName("newsView");
		return mav;
	}

	
//게시물 추가
	@RequestMapping(value="insert", method=RequestMethod.POST)
	public ModelAndView insert(String date, @RequestParam(defaultValue="1") int page, NewsVO vo) {
		PageControl pc = new PageControl(page, dao.count(date));
		dao.insert(vo, date);
		System.out.println("Controller : " + vo);
		mav.addObject("list", dao.listAll(date, pc.getWritingStart(), pc.getWritingEnd()) );
		mav.setViewName("newsView");
		return mav;
	}

	
//게시물 수정
	@RequestMapping(value="update", method=RequestMethod.POST)
	public ModelAndView update(@RequestParam(defaultValue="1") int page, NewsVO vo) {
		dao.update(vo);
		
		mav.setViewName("newsView");
		return mav;
	}
}                 


