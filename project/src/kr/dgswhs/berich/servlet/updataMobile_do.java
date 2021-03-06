package kr.dgswhs.berich.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import kr.dgswhs.berich.bean.DBBean;

/**
 * Servlet implementation class updataMobile_do
 */
@WebServlet("/update")
public class updataMobile_do extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public updataMobile_do() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doPost(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		update(request,response);
	}

	private void update(HttpServletRequest request, HttpServletResponse response)throws IOException,ServletException{
		String param = request.getParameter("itemId");
		
		if(param != null) {
			int id = Integer.parseInt(param);
			DBBean dbbean = DBBean.getInstance();
			try {
				int result = dbbean.update(id);
				response.getWriter().println(result);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		
	}

}
