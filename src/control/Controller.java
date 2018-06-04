package control;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import service.CommandProcess;

import com.sun.xml.internal.fastinfoset.sax.Properties;

@WebServlet("/Controller")
public class Controller extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Map<String, Object> commandMap = new HashMap<String, Object>();
   //command.properties의 String 과 object
   //command.properties를 담기 위해 map으로 선언
	
	public void init(ServletConfig config) throws ServletException {	//생성될 때 딱 한 번만 실행!
		//web.xml에서 propertyConfig에 해당하는 init-param의 값을 읽어옴
		String props = config.getInitParameter("config");	//web.xml의 param
		System.out.println("props->"+props);
		//web.xml의 config
		//명령어와 처리클래스의 매핑정보를 저장할 properties 객체 생성
		java.util.Properties pr = new java.util.Properties();
		//환경변수를 저장
		FileInputStream f = null;
		try{
			String configFilePath = config.getServletContext().getRealPath(props);
			f= new FileInputStream(configFilePath);
			//command.properties 파일의 정보를 properties 객체에 저장
			pr.load(f);	
			//환경변수 메모리에 load 함
		}catch(IOException e){
			throw new ServletException(e);
		}finally{
			if(f!=null) try{
				f.close();
			}catch(IOException e){}
		}
		//Iterator 객체는 Enumeration 객체를 확장시킨 개념의 객체
		Iterator keyIter = pr.keySet().iterator();
		//객체를 하나씩 꺼내서 그 객체명으로 Properties 객체에 저장된 객체에 접근
		while(keyIter.hasNext()){	//원소가 있으면 가져옴 
			String command = (String)keyIter.next();	//list.do, content.do, ***
			String className = pr.getProperty(command);	//service.ListAction
			System.out.println("while commannd->"+command);
			System.out.println("while className=>"+className);
			try{
				Class commandClass = Class.forName(className);	//해당 문자열을 클래스로 만든다.
				Object commandInstance = commandClass.newInstance();	//해당 클래스의 객체를 생성
				commandMap.put(command, commandInstance);	//Map 객체인 commandMap에 객체 저장
						//list.do의 문자열 , service.listAction의 인스턴스화 된 것 
			} catch(Exception e){
				throw new ServletException(e);
			}
		}
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestPro(request,response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		requestPro(request,response);
	}
	//사용자의 요청을 분석해서 해당 작업을 처리
	private void requestPro(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException{
		String view= null;
		CommandProcess com=null;
		try{
			String command=request.getRequestURI();	//uri를 가져와 ccommand에 들어감
			System.out.println(command); 	//  /ch16/list.do
			//System.out.println(request.getContextPath());// /ch16
			//System.out.println(command.indexOf(request.getContextPath()));	//0
			//if(command.indexOf(request.getContextPath()) ==0){
			command = command.substring(request.getContextPath().length());	
			//	/ch16/list.do에서 /ch16을 잘라냄 => list.do 만 들어감
		//}
			com=(CommandProcess)commandMap.get(command);
			System.out.println("command=> " +command);  	// /ch16/com
			System.out.println("com=> "+com); 	// /ch16/com
			view = com.requestPro(request, response);
			System.out.println("view=> "+view);  	//  /ch16/com
	} catch(Throwable e){
		throw new ServletException(e);
	} 
		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		dispatcher.forward(request, response);
	}
}
