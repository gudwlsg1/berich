package kr.dgswhs.berich.bean;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBBean {

	private static DBBean instance = new DBBean();

	public static DBBean getInstance() {
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/treasure");
		return ds.getConnection();
	}

	public int insert(DataBean data) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		int result = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement(
					"insert into treasure (itemCnt,itemName,itemDesc,imageUrl,shadowUrl,lat,lng) values (?,?,?,?,?,?,?)");
			pstmt.setLong(1, data.getItemCnt());
			pstmt.setString(2, data.getItemName());
			pstmt.setString(3, data.getItemDesc());
			pstmt.setString(4, data.getImageUrl());
			pstmt.setString(5, data.getShadowUrl());
			pstmt.setDouble(6, data.getLat());
			pstmt.setDouble(7, data.getLng());
			result = pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return result;
	}

	public ArrayList<DataBean> select(int id) {
		ArrayList<DataBean> result = new ArrayList<DataBean>();
		String sql = "select * from treasure where itemId=?";
		String sql1 = "select * from treasure";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			conn = getConnection();

			if (id >= 0) {
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, id);
			} else
				pstmt = conn.prepareStatement(sql1);
			rs = pstmt.executeQuery();
			while (rs.next() == true) {
				DataBean bean = new DataBean();
				bean.setItemId(rs.getInt("itemId"));
				bean.setItemCnt(rs.getInt("itemCnt"));
				bean.setItemName(rs.getString("itemName"));
				bean.setItemDesc(rs.getString("itemDesc"));
				bean.setImageUrl(rs.getString("imageUrl"));
				bean.setShadowUrl(rs.getString("shadowUrl"));
				bean.setLat(rs.getDouble("lat"));
				bean.setLng(rs.getDouble("lng"));
				result.add(bean);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return result;
	}

	public int update(int id) throws Exception {

		String sql = "select itemCnt from treasure where itemId=?";
		String sql1 = "update treasure set itemCnt = ? where itemId = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);

			rs = pstmt.executeQuery();

			rs.next();

			int  num = rs.getInt("itemCnt");

			if (num > 0) {
				pstmt = conn.prepareStatement(sql1);

				pstmt.setInt(1, --num);
				pstmt.setInt(2, id);

				result = pstmt.executeUpdate();
				return result;
				
			}else {
				return 0;
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return 1;
	}

	public int delete(int id) {

		String sql = "delete from treasure where itemId = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		int result = 0;

		try {

			conn = getConnection();

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, id);

			result = pstmt.executeUpdate();

		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return result;

	}
}