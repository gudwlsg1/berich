package kr.dgswhs.berich.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Enumeration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.dgswhs.berich.bean.DBBean;
import kr.dgswhs.berich.bean.DataBean;

/**
 * Servlet implementation class InsertServlet
 */
@WebServlet("/Insert")
public class InsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public InsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		request.setCharacterEncoding("UTF-8");
		response.setCharacterEncoding("UTF-8");
	    //response.setContentType("text/plain; charset=UTF-8");
	    PrintWriter out = response.getWriter();

	    String savePath="/upload";
	    int uploadFileSizeLimit = 5*1024*1024; // 5MB
	    String encType="UTF-8";
	    

	    ServletContext context = getServletContext();
	    String uploadFilePath = context.getRealPath(savePath);

		try{
		    MultipartRequest multi = new MultipartRequest(
		        request, uploadFilePath,uploadFileSizeLimit, encType,
		        new DefaultFileRenamePolicy());
		    Enumeration<String> files = multi.getFileNames();
		    String[] fileName = new String[2];
		    int i=0;
		    while(files.hasMoreElements() && i < fileName.length)
		    {
		        String file = files.nextElement();
		        fileName[i] = multi.getFilesystemName(file);
		        System.out.println(fileName[i]);
		        String orgName = multi.getOriginalFileName(file);
		        i++;
		    }
		    
		    //String baseUrl = "http://10.80.162.89:8080"+context.getContextPath()+"/upload/";
		    String baseUrl = context.getContextPath()+"/upload/";
		    String itemName = multi.getParameter("itemName");
		    String imageUrl = baseUrl+fileName[0];
		    String shadowUrl = baseUrl + fileName[1];
		    String itemDesc = multi.getParameter("itemDesc");
		    int itemCnt = Integer.parseInt(multi.getParameter("itemCnt"));
		    Double lat = Double.parseDouble(multi.getParameter("lat"));
		    Double lng = Double.parseDouble(multi.getParameter("lng"));
		    
		    
		    
		    DataBean bean = new DataBean();
		    bean.setItemName(itemName);
		    bean.setImageUrl(imageUrl);
		    bean.setItemCnt(itemCnt);
		    bean.setItemDesc(itemDesc);
		    bean.setShadowUrl(shadowUrl);
		    bean.setLat(lat);
		    bean.setLng(lng);
		    
		    int result = 0;
		    result = DBBean.getInstance().insert(bean);
		    
		    if(result != 0) {
		    	ArrayList<DataBean> list = DBBean.getInstance().select(-1);
		    	session.setAttribute("list", list);
		    	response.sendRedirect("index.jsp?message=s");
		    }
		    else
		    	response.sendRedirect("index.jsp?message=f");
		    //Session에 DBBean.select 저장하고
		    // Redirect
		}catch(Exception e)
	    {
	        e.printStackTrace();
	    }
	}

}
