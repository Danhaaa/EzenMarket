package com.ezen.ezenmarket.admin.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.ezen.ezenmarket.admin.dto.ReportDTO;
import com.ezen.ezenmarket.admin.dto.UserListDTO;

public interface AdminMapper{

	@Select("SELECT * FROM userlist ORDER BY user_number DESC")
	List<UserListDTO> getUser();
	
	@Update("UPDATE userlist SET banned=1 WHERE user_number=#{user_number}")
	Integer banUser(UserListDTO userlist);
	
	@Update("UPDATE userlist SET banned=0 WHERE user_number=#{user_number}")
	Integer unbanUser(UserListDTO userlist);
	
	
	@Select("SELECT * FROM report ORDER BY report_id DESC")
	List<ReportDTO> getReport();
	@Update("UPDATE report SET report_status=1 WHERE report_id"
			+ "=#{report_id}")
	Integer updateReport(ReportDTO report);
	
}
