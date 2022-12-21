package project.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.dto.MemberDTO;

public class MemberDAO extends JdbcDAO{
	private static MemberDAO _dao;
	
	private MemberDAO() {
		
	}
	
	static {
		_dao = new MemberDAO();
	}
	
	public static MemberDAO getDAO() {
		return _dao;
	}
	
	public int insertMember(MemberDTO member) {
		Connection con = null;
		PreparedStatement pstmt = null;
		int rows = 0;
		try {
			con = getConnection();
			
			String sql = "insert into member values(?,?,?,?,?,?,?,?,1)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, member.getuId());
			pstmt.setString(2, member.getuName());
			pstmt.setString(3, member.getuPw());
			pstmt.setString(4, member.getuAddressU());
			pstmt.setString(5, member.getuAddressD());
			pstmt.setString(6, member.getuAddressN());
			pstmt.setString(7, member.getuPhone());
			pstmt.setString(8, member.getuEmail());
			
			
			
			rows = pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]insertMember 메소드 SQL 오류 = " + e.getMessage());
		}finally {
			close (con, pstmt);
		}
		return rows;
	}
	
	public MemberDTO selectMember(String uId) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDTO member = null;
		try {
			con = getConnection();
			
			String sql = "select * from member where u_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uId);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberDTO();
				member.setuId(rs.getString("u_id"));
				member.setuName(rs.getString("u_name"));
				member.setuPw(rs.getString("u_pw"));
				member.setuAddressU(rs.getString("u_address_u"));
				member.setuAddressD(rs.getString("u_address_d"));
				member.setuAddressN(rs.getString("u_address_n"));
				member.setuPhone(rs.getString("u_phone"));
				member.setuEmail(rs.getString("u_email"));
				member.setuStatus(rs.getInt("u_status"));
			
				
			}
		}catch(SQLException e) {
			System.out.println("[에러] selectMember 메소드의 SQL 오류=" + e.getMessage());
		}finally {
			close(con,pstmt,rs);
		}
		return member;
	}
	
	public MemberDTO selectMemberE(String uEmail) {
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		MemberDTO member = null;
		try {
			con = getConnection();
			
			String sql = "select * from member where u_email=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, uEmail);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				member = new MemberDTO();
				member.setuId(rs.getString("u_id"));
				member.setuName(rs.getString("u_name"));
				member.setuPw(rs.getString("u_pw"));
				member.setuAddressU(rs.getString("u_address_u"));
				member.setuAddressD(rs.getString("u_address_d"));
				member.setuAddressN(rs.getString("u_address_n"));
				member.setuPhone(rs.getString("u_phone"));
				member.setuEmail(rs.getString("u_email"));
				member.setuStatus(rs.getInt("u_status"));
			
				
			}
		}catch(SQLException e) {
			System.out.println("[에러] selectMember 메소드의 SQL 오류=" + e.getMessage());
		}finally {
			close(con,pstmt,rs);
		}
		return member;
	}
	
	
	
	
	
	//관리자페이지 관련
	//아이디와 상태정보를 전달받아 MEMBER 테이블에 저장된 회원의 상태정보를 변경하고 변경행의 갯수를 반환하는 메소드
	public int updateStatus(String id, int status) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update member set u_status=? where u_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setInt(1, status);
			pstmt.setString(2, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateStatus 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
	//MEMBER 테이블에 저장된 모든 회원정보를 검색하여 반환하는 메소드
	public List<MemberDTO> selectMemberList() {
		Connection con=null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<MemberDTO> memberList=new ArrayList<MemberDTO>();
		try {
			con=getConnection();
			
			String sql="select * from member order by u_id";
			pstmt=con.prepareStatement(sql);
			
			rs=pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO member=new MemberDTO();
				member.setuId(rs.getString("u_id"));
				member.setuName(rs.getString("u_name"));
				member.setuPw(rs.getString("u_pw"));
				member.setuAddressU(rs.getString("u_address_u"));
				member.setuAddressD(rs.getString("u_address_d"));
				member.setuAddressN(rs.getString("u_address_n"));
				member.setuPhone(rs.getString("u_phone"));
				member.setuEmail(rs.getString("u_email"));
				member.setuStatus(rs.getInt("u_status"));
				memberList.add(member);
			}
		} catch (SQLException e) {
			System.out.println("[에러]selectMemberList 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt, rs);
		}
		return memberList;
	}
	
	//아이디를 전달받아 MEMBER 테이블에 저장된 회원정보를 삭제하고 삭제행의 갯수를 반환하는 메소드
	public int deleteMember(String id) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="delete from member where u_id=?";
			pstmt=con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]deleteMember 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		} 
		return rows;
	}
	
	public int updateMember(MemberDTO member) {
		Connection con=null;
		PreparedStatement pstmt=null;
		int rows=0;
		try {
			con=getConnection();
			
			String sql="update member set u_name=?,u_pw=?,u_email=?,u_address_u = ?,u_address_d = ?,u_address_n = ?,u_phone=? where u_id=?";
			pstmt=con.prepareStatement(sql);
			
			pstmt.setString(1, member.getuName());
			pstmt.setString(2, member.getuPw());
			pstmt.setString(3, member.getuEmail());
			pstmt.setString(4, member.getuAddressU());
			pstmt.setString(5, member.getuAddressD());
			pstmt.setString(6, member.getuAddressN());
			pstmt.setString(7, member.getuPhone());
			pstmt.setString(8, member.getuId());
			rows=pstmt.executeUpdate();
		} catch (SQLException e) {
			System.out.println("[에러]updateMember 메소드의 SQL 오류 = "+e.getMessage());
		} finally {
			close(con, pstmt);
		}
		return rows;
	}
}
