package kr.dgswhs.berich.servlet;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

import kr.dgswhs.berich.bean.DBBean;
import kr.dgswhs.berich.bean.DataBean;

/**
 * Servlet implementation class insert
 */
@WebServlet("/select")
public class selectMobile_do extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public selectMobile_do() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		select(request, response);
	}

	protected void select(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/json; charset=UTF-8");
		DBBean dbbean = DBBean.getInstance();
		ArrayList<DataBean> data = dbbean.select(-1);

		// 최종 완성될 JSONObject 선언(전체)
		JSONObject jsonObject = new JSONObject();
		// result의 JSON정보를 담을 Array 선언
		JSONArray resultArray = new JSONArray();

		for (int i = 0; i < data.size(); i++) {
			JSONObject todoInfo = new JSONObject();
			todoInfo.put("itemId", data.get(i).getItemId());
			todoInfo.put("itemCnt",data.get(i).getItemCnt());
			todoInfo.put("itemName", data.get(i).getItemName());
			todoInfo.put("itemDesc", data.get(i).getItemDesc());
			todoInfo.put("imageUrl", data.get(i).getImageUrl());
			todoInfo.put("shadowUrl", data.get(i).getShadowUrl());
			todoInfo.put("lat", data.get(i).getLat());
			todoInfo.put("lng", data.get(i).getLng());
			resultArray.add(todoInfo);
		}

		jsonObject.put("length", data.size());
		if (data.size() > 0)
			jsonObject.put("item", resultArray);
		String jsonInfo = jsonObject.toString();
		response.getWriter().print(jsonInfo);
	}
}
