package com.ezen.ezenmarket.mypage.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.annotations.Param;

import com.ezen.ezenmarket.mypage.dto.Post;

public interface MyPageService {
	
	public String getSaleList(HttpServletRequest req);
	
	public String getZzimList(HttpServletRequest req);
	
	public String getReviewList(HttpServletRequest req);
	
	public void updatePost(Integer post_Id);
	
	public void deletePost(Integer post_Id);
	
	public int nickCheck(String nickName);
	
	public void modifyNick(String nickName);
	
	public void modifyIntro(String userintro);
	
	public String getmanagement(HttpServletRequest req);
	

}
