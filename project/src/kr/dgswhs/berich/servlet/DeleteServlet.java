package kr.dgswhs.berich.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import kr.dgswhs.berich.bean.DBBean;
import kr.dgswhs.berich.bean.DataBean;

/**
 * Servlet implementation class DeleteServlet
 */
@WebServlet("/Delete")
public class DeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String param = request.getParameter("itemId");
		
		
		if(param != null) {
			int id = Integer.parseInt(param);
			int result = DBBean.getInstance().delete(id);
		    HttpSession session = request.getSession();
		    
		    if(result != 0) {
		    	ArrayList<DataBean> list = DBBean.getInstance().select(-1);
		    	session.setAttribute("list", list);
		    	response.sendRedirect("index.jsp?message=s");
		    }
		    else {
		    	response.sendRedirect("index.jsp?message=f");
		    }
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
