<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core"%>
<%@ page import = "controller.*"%>
<%@ page import = "java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div>
		<h1>자바 코드로 속성값 읽기</h1>
		<div>context영역 속성 : <%=application.getAttribute("contextNo")%></div> <!-- 톰캣이 꺼지기 전까지-->
		<div>session영역 속성 : <%=session.getAttribute("sessionNo")%></div> <!-- 세션영역이 존재하는 동안 -->
		<div>request영역 속성 : <%=request.getAttribute("requestNo")%></div> <!-- 요청하고 응답하는 동안 -->
	</div>
	<div>
		<h1>EL을 사용하여 속성값 읽기</h1> <!-- 자바코드가 사라짐 $와 {} 사용 -->
		<div>context영역 속성 : ${applicationScope.contextNo}</div> <!-- 어플리케이션영역의 no값을 읽겠다 -->
		<div>session영역 속성 : ${sessionScope.sessionNo}</div>
		<div>request영역 속성 : ${requestScope.requestNo}</div> <!-- null은 공백으로 출력됨 -->
	</div>
	<div>
		<h1>EL을 사용하여 속성값 읽기(scope 생략 가능)</h1>
		<div>context영역 속성 : ${contextNo}</div>
		<div>session영역 속성 : ${sessionNo}</div>
		<div>request영역 속성 : ${requestNo}</div>
	</div>
	
	<div>
		<h1>자바코드를 이용하여 여러 자료형 속성(request)값 읽기</h1>
		<div>문자열 : <%=(String)request.getAttribute("name")%></div> <!-- 형변환 해야함 -->
		<div>멤버객체 :
			<%
				Member member = (Member)(request.getAttribute("member")); // request안에 Object타입으로 들어가 있으므로 형변환 필요
			%>
			
			<%=member.getId()%>
		</div>
		<div>문자열 배열 :
			<%
				String[] arr = (String[])request.getAttribute("arr");
			%>
			<%=arr[0]%>
		</div>
		<div>멤버 리스트 :
			<%
				ArrayList<Member> list = (ArrayList<Member>)request.getAttribute("list");
				Member m = list.get(1);
			%>
			<%=m.getId()%> <!-- 멤버 리스트 -->
		</div>
		
		<div>
			<h1>EL 이용하여 여러 자요형 속성(request)값 읽기</h1> <!-- import구문도 필요 없음 -->
			<div>${name}</div>
			<div>${member.id}</div><!-- 자기가 알아서 형변환까쥐 리플렉션API를 사용하여 자동으로 형변환이되고(${member}가 멤버객체가 됨) EL표현식 안에서 .id라고 호출하면 실제로는 getId()가 호출됨 getter setter가 없으면 error남-->
			<div>${arr["0"]}</div> <!-- .은 안먹힌다(?) 배열은 이렇게 써라--> <!-- 배열이나 Collections 인덱스 [번호]형태로 표현 --> <!-- EL은 값응 표현하는 방법 문장은 태그라이브러리로...퍼센트안에서는 EL사용 불가 -->
			<div>${list[1].id}</div>
		</div>
		
		<div>
			<h1>EL 표현식안에서 연산(수치연산, 비교연산, 논리연산) 가능</h1>
			<div>2 * 3 : ${2 * 3}</div>
			<div>3은 1보다 크다 : ${3 > 1}</div>
			<div>거짓 or 참 : ${false || true}</div> <!-- 논리연산 -->
			<div>no속성 값은 7이다 : ${requestNo == 7}</div> <!-- 문자는 ${'글자'}로 표현-->
			<div>name속성값은 goodee이다 : ${name == 'goodee'}</div> <!-- ''를 안쓰면 속성에서 goodee 를 찾음 -->
			<div>person속성은 없다(null이다 : ${person == null})</div>
		</div>
		<div>
			EL은 값을 표현하는 방법이지 문(자바문장)은 표현할 수 없다.<br>
			문을 태그처럼 표현하기 위해서 커스텀태그(태그 외부라이브러리)인 JSTL을(이게 표준..) 사용한다.<br>
			MVC에서는 모든 JSTL을 사용하지 않고 주로 Core단(제어문 부문)부분만 사용한다.
		</div>
		<div>
			<h1>조건문</h1>
			<div>
				<%
					Member m2 = (Member)request.getAttribute("member");
					if(m2.getAge() > 19) {
				%>
						<%=m2.getId()%>는 성인입니다.(JAVA)
				<%
					} else {
				%>
						<%=m2.getId()%>는 미성년자입니다.(JAVA)
				<%
					}
				%>
			</div>
			<div>
				<c:if test = "${member.age > 19}"> <!-- test뒤에 오는 것들은 자바코드 -->
					${member.id}는 성인입니다.(JSTL : CORE)
				</c:if> <!-- c:if는 else가 없다 else 적고 싶다면 if에 쓴 조건의 반대조건을 쓰면 됨-->
				<c:if test = "${member.age <= 19}">
					${member.id}는 미성년자입니다.(JSTL : CORE)
				</c:if>
			</div>
			<h1>반복문(JAVA)</h1>
			<div>
				<%
					for(String n : arr) {
				%>
						<%=n%>
				<%
					}
				%>
				<br>
				<%
					for(Member mb : list) {
				%>
						<%=mb.getId()%>
				<%
					}
				%>
				<br>
				<%
					for(int i = 1; i <= 10; i++) {
				%>
						<%=i%>
				<%
					}
				%>
			</div>
			<h1>반복문(JSTL)</h1>
			<div>
				<c:forEach var = "n2" items = "${arr}">
					${n2}
				</c:forEach>
				<c:forEach var = "mb2" items = "${list}">
					${mb2.id}
				</c:forEach>
				<c:forEach var = "x" begin = "1" end = "10" step = "1">
					${x}
				</c:forEach>
			</div>
		</div>
	</div>
</body>
</html>