package project.dao;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.dto.ReviewDTO;

public class ReviewDAO extends JdbcDAO {
	private static ReviewDAO _dao;
	
	private ReviewDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new ReviewDAO();
	}
	
	public static ReviewDAO getDAO() {
		return _dao;
	}


	//Review 테이블에 저장된 전체 게시글의 갯수를 검색하여 반환하는 메소드 - 검색 기능 미사용
	public int selectReviewCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from Review";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectReviewCount 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}


	
	//시작 행번호와 종료 행번호를 전달받아 Review 테이블에 저장된 게시글에서 시작 행번호부터
	//종료 행번호 사이에 저장된 게시글을 검색하여 반환하는 메소드
	public List<ReviewDTO> selectReviewList(int startRow, int endRow) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<ReviewDTO> ReviewList=new ArrayList<ReviewDTO>();
		try {
			con=getConnection();

				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from Review order by r_no desc) temp) "
						+ "where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
						
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				ReviewDTO Review=new ReviewDTO();
				Review.setrPno(rs.getInt("r_pno"));
				Review.setrNo(rs.getInt("r_no"));
				Review.setpUser(rs.getString("p_user"));
				Review.setpTitle(rs.getString("p_title"));
				Review.setpContent(rs.getString("p_content"));
				Review.setpDate(rs.getString("p_date"));
				ReviewList.add(Review);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectReviewList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return ReviewList;
	}
	
	//Review_SEQ 시퀸스의 다음값을 검색하여 반환하는 메소드
	public int selectNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select review_r_no_seq.nextval from dual";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				nextNum=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNextNum 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return nextNum;
	}
	
	//게시글을 전달받아 Review 테이블에 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertReview(ReviewDTO Review) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into Review values(?,?,?,?,?,sysdate)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, Review.getrPno());
			pstmt.setInt(2, Review.getrNo());
			pstmt.setString(3, Review.getpUser());
			pstmt.setString(4, Review.getpTitle());
			pstmt.setString(5, Review.getpContent());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertReview 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
				
	}
	
	//글번호를 전달받아 Review 테이블에 저장된 게시글을 검색하여 반환하는 메소드
	public ReviewDTO selectReview(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ReviewDTO Review=null;
		try {
			con=getConnection();
			
			String sql="select * from Review where r_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				Review=new ReviewDTO();
				Review.setrPno(rs.getInt("r_pno"));
				Review.setrNo(rs.getInt("r_no"));
				Review.setpUser(rs.getString("p_user"));
				Review.setpTitle(rs.getString("p_title"));
				Review.setpContent(rs.getString("p_content"));
				Review.setpDate(rs.getString("p_date"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectReview 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return Review;
	}
	

	
	//글번호를 전달받아 Review 테이블에 저장된 게시글의 상태를 변경하고 변경행의 갯수를 반환하는 메소드
	public int deleteReview(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from  Review where r_no=?";
			pstmt=con.prepareStatement(sql);

			pstmt.setInt(1, num);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteReview 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;		
	}
}














