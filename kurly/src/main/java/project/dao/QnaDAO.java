package project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.dto.QnaDTO;

public class QnaDAO extends JdbcDAO {
	private static QnaDAO _dao;
	
	private QnaDAO() {
		// TODO Auto-generated constructor stub
	}
	
	static {
		_dao=new QnaDAO();
	}
	
	public static QnaDAO getDAO() {
		return _dao;
	}

	//검색 관련 값을 전달받아 qna 테이블에 저장된 전체 게시글 중 검색컬럼에 검색어가 포함된
	//게시글의 갯수를 검색하여 반환하는 메소드 - 검색 기능 사용
	public int selectQnaCount(String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int count=0;
		try {
			con=getConnection();
			
			if(keyword.equals("")) {//검색 기능을 사용하지 않은 경우
				String sql="select count(*) from qna";
				pstmt=con.prepareStatement(sql);
			} else {//검색 기능을 사용한 경우
				String sql="select count(*) from qna where "+search+" like '%'||?||'%' and q_status=1";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
			}
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				count=rs.getInt(1);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQnaCount 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return count;
	}
	
	//시작 행번호와 종료 행번호를 전달받아 Qna 테이블에 저장된 게시글에서 시작 행번호부터
	//종료 행번호 사이에 저장된 게시글을 검색하여 반환하는 메소드 - 검색 기능 사용
	public List<QnaDTO> selectQnaList(int startRow, int endRow, String search, String keyword) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<QnaDTO> qnaList=new ArrayList<QnaDTO>();
		try {
			con=getConnection();
			
			if(keyword.equals("")) {
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from qna order by ref desc, re_step) temp) "
						+ "where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setInt(1, startRow);
				pstmt.setInt(2, endRow);
			} else {
				String sql="select * from (select rownum rn, temp.* from "
						+ "(select * from qna where "+search
						+" like '%'||?||'%' and q_status=1 order by ref desc, re_step) temp) "
						+ "where rn between ? and ?";
				pstmt=con.prepareStatement(sql);
				pstmt.setString(1, keyword);
				pstmt.setInt(2, startRow);
				pstmt.setInt(3, endRow);
			}
						
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				QnaDTO qna=new QnaDTO();
				qna.setQno(rs.getInt("Q_no"));
				qna.setQtitle(rs.getString("Q_title"));
				qna.setQcontent(rs.getString("Q_content"));
				qna.setQname(rs.getString("Q_name"));
				qna.setQdate(rs.getString("Q_date"));
				qna.setRef(rs.getInt("ref"));
				qna.setReStep(rs.getInt("re_step"));
				qna.setReLevel(rs.getInt("re_level"));
				qna.setQstatus(rs.getInt("Q_status"));
				qnaList.add(qna);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQnaList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qnaList;
	}
	
	//QNA_SEQ 시퀸스의 다음값을 검색하여 반환하는 메소드
	public int selectNextNum() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		int nextNum=0;
		try {
			con=getConnection();
			
			String sql="select qna_seq.nextval from dual";
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
	
	//부모글의 ref 변수값과 reStep 변수값을 전달받아 QNA 테이블에 저장된 게시글에서 
		//REF 컬럼값과 ref 변수값이 같은 게시글 중 reStep 변수값보다 RE_STEP 컬럼값이 큰 
		//게시글의 RE_STEP 컬럼값이 1 증가되도록 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateReStep(int ref, int reStep) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update qna set re_step=re_step+1 where ref=? and re_step>?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, ref);
			pstmt.setInt(2, reStep);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateReStep 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}

	//게시글을 전달받아 QNA 테이블에 삽입하고 삽입행의 갯수를 반환하는 메소드
	public int insertQna(QnaDTO qna) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="insert into qna values(?,?,?,?,sysdate,?,?,?,?)";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, qna.getQno());
			pstmt.setString(2, qna.getQtitle());
			pstmt.setString(3, qna.getQcontent());
			pstmt.setString(4, qna.getQname());
			pstmt.setInt(5, qna.getRef());
			pstmt.setInt(6, qna.getReStep());
			pstmt.setInt(7, qna.getReLevel());
			pstmt.setInt(8, qna.getQstatus());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertQna 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
				
	}
	
	//글번호를 전달받아 QNA 테이블에 저장된 게시글을 검색하여 반환하는 메소드
	public QnaDTO selectQna(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		QnaDTO qna=null;
		try {
			con=getConnection();
			
			String sql="select * from qna where q_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rs=pstmt.executeQuery();
			
			if(rs.next()) {
				qna=new QnaDTO();
				qna.setQno(rs.getInt("q_no"));
				qna.setQtitle(rs.getString("q_title"));
				qna.setQcontent(rs.getString("q_content"));
				qna.setQname(rs.getString("q_name"));
				qna.setQdate(rs.getString("q_date"));
				qna.setRef(rs.getInt("ref"));
				qna.setReStep(rs.getInt("re_step"));
				qna.setReLevel(rs.getInt("re_level"));
				qna.setQstatus(rs.getInt("q_status"));	
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectQna 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qna;
	}

	//게시글을 전달받아 QNA 테이블에 저장된 게시글을 변경고 변경행의 갯수를 반환하는 메소드
	public int updateQna(QnaDTO qna) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update qna set q_title=?,q_content=?,q_status=? where q_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, qna.getQtitle());
			pstmt.setString(2, qna.getQcontent());
			pstmt.setInt(3, qna.getQstatus());
			pstmt.setInt(4, qna.getQno());
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateQna 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;		
	}
	
	//글번호와 상태정보를 전달받아 QNA 테이블에 저장된 게시글의 상태를 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateStatus(int num, int status) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update qna set q_status=? where q_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, status);
			pstmt.setInt(2, num);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateStatus 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;		
	}
	
	//글번호를 전달받아 Notice 테이블에 저장된 관련게시글을 모두 삭제하고 삭제행의 갯수를 반환하는 메소드
	public int deleteQna(int num) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from qna where ref=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteQna 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	
	//관리자페이지 관련
	//글번호와 상태정보를 전달받아 QNA 테이블에 저장된 게시글의 상태정보를 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateStatus(String no, int status) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update qna set q_status=? where q_no=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, status);
			pstmt.setString(2, no);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateStatus 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	
	//QNA 테이블에 저장된 모든 회원정보를 검색하여 반환하는 메소드
	public List<QnaDTO> allQnaList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<QnaDTO> qnaList=new ArrayList<QnaDTO>();
		try {
			con=getConnection();
			
			String sql="select * from qna order by q_no desc";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				QnaDTO qna=new QnaDTO();
				qna=new QnaDTO();
				qna.setQno(rs.getInt("q_no"));
				qna.setQtitle(rs.getString("q_title"));
				qna.setQcontent(rs.getString("q_content"));
				qna.setQname(rs.getString("q_name"));
				qna.setQdate(rs.getString("q_date"));
				qna.setRef(rs.getInt("ref"));
				qna.setReStep(rs.getInt("re_step"));
				qna.setReLevel(rs.getInt("re_level"));
				qna.setQstatus(rs.getInt("q_status"));
				qnaList.add(qna);
			}
		} catch (SQLException e) {
			System.out.println("[에러]AllQnaList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return qnaList;
	}
}