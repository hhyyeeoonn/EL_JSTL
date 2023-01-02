package controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/ELTest")
public class ELTest extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		// 모델값
		int no = 7;
		String name = "goodee";
		Member member = new Member(20, "admin");
		String[] arr = {"루피", "조로", "상디"};
		ArrayList<Member> list = new ArrayList<Member>();
		list.add(new Member(17, "우솝"));
		list.add(new Member(22, "로빈"));
		
		// 속성 형태의 저장영역 3군데 
		request.getServletContext().setAttribute("contextNo", no); // 톰캣안에 저장 어플리케이션 영역 동일한 톰캣을 쓰는 사람들에게 공유됨
		request.getSession().setAttribute("sessionNo", no); // 세션영역 웹브라우저 안에서 사용 한 사람만 사용 가능 jsp session.setAttribute()
		request.setAttribute("requestNo", no); // 리퀘스트 영역 요청한 사람만 사용가능하고 응답하면 끝남 리퀘스트를 include나 forward하다가 response하면 끝남
	
		// 다양한 자료형을 속성영역에 저장 (속성은 Map타입)
		request.setAttribute("name", name); // 문자열
		request.setAttribute("member", member); // 객체
		request.setAttribute("arr", arr); // 배열
		request.setAttribute("list", list); // 리스트
		
		// View
		request.getRequestDispatcher("/WEB-INF/view/elTestView.jsp").forward(request, response);
	}

}