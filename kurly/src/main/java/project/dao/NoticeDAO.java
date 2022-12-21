package project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.dto.NoticeDTO;

public class NoticeDAO extends JdbcDAO {
	private static NoticeDAO _dao;
	
	public NoticeDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new NoticeDAO();
	}
	
	public static NoticeDAO getDAO() {
		return _dao;
	}

	//테이블에 저장된 전체 게시글의 갯수를 검색하여 반환하는 메소드
	public int selectNoticeCount() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			String sql="select count(*) from notice";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNoticeCount 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	//시작 행번호와 종료 행번호를 전달받아 Notice 테이블에 저장된 게시글에서 시작 행번호부터
	//종료 행번호 사이에 저장된 게시글을 검색하여 반환하는 메소드
	public List<NoticeDTO> selectNoticeList(int startRow, int endRow) {
			Connection con=null;
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<NoticeDTO> noticeList=new ArrayList<NoticeDTO>();
			try {
				con=getConnection();
				
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from notice order by n_no desc) temp) "
						+ "where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
				
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					NoticeDTO notice=new NoticeDTO();
					notice.setNno(rs.getInt("n_no"));
					notice.setNtitle(rs.getString("n_title"));
					notice.setNcontent(rs.getString("n_content"));
					notice.setNdate(rs.getString("n_date"));
					noticeList.add(notice);
				}
			} catch (SQLException e) {
				System.out.println("[에러]selectNoticeList 메소드의 SQL 오류 = "+e.getMessage());
			} finally {
				close(con, pstmt, rs);
			}
			return noticeList;
		}
		
	//Notice_SEQ 시퀸스의 다음값을 검색하여 반환하는 메소드
	public int selectNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select notice_seq.nextval from dual";
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

	//게시글을 전달받아 Notice 테이블에 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertNotice(NoticeDTO notice) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into notice values(?,?,?,sysdate)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, notice.getNno());
			pstmt.setString(2, notice.getNtitle());
			pstmt.setString(3, notice.getNcontent());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertNotice 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;			
	}
	
	
	//글번호를 전달받아 notice 테이블에 저장된 게시글을 검색하여 반환하는 메소드
	public NoticeDTO selectNotice(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		NoticeDTO notice=null;
		try {
			con=getConnection();
			
			String sql="select * from notice where n_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				notice=new NoticeDTO();
				notice.setNno(rs.getInt("n_no"));
				notice.setNtitle(rs.getString("n_title"));
				notice.setNcontent(rs.getString("n_content"));
				notice.setNdate(rs.getString("n_date"));
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectNotice 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return notice;
	}
	
	//게시글을 전달받아 Notice 테이블에 저장된 게시글을 변경고 변경행의 갯수를 반환하는 메소드
	public int updateNotice(NoticeDTO notice) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update notice set n_title=?,n_content=? where n_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, notice.getNtitle());
			pstmt.setString(2, notice.getNcontent());
			pstmt.setInt(3, notice.getNno());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateNotice 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;		
	}
	
	//글번호를 전달받아 Notice 테이블에 저장된 게시글을 삭제하고 삭제행의 갯수를 반환하는 메소드
	public int deleteNotice(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from notice where n_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteNotice 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}
