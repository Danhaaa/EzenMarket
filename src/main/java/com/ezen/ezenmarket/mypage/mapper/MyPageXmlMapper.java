package com.ezen.ezenmarket.mypage.mapper;

import java.util.List;

import com.ezen.ezenmarket.mypage.dto.Post;
import com.ezen.ezenmarket.mypage.dto.Profile;
import com.ezen.ezenmarket.mypage.dto.Review;

public interface MyPageXmlMapper {
	
	public List<Post> getPost(Integer user_num);
	
	public List<Post> getZzim(Integer user_num);
	
	public List<Review> getReviewList(Integer user_number);
	
	public void updatePost(Integer post_Id);
	
	public void deletePost(Integer post_Id);
	
	public void deleteZzim(Post p);	
	
	public Integer getReviewCount(Integer user_number);
	
	public Integer getPostCount(Integer user_number);
	
	public Profile getUserProfile(Integer user_number);
	
	public Integer nickCheck(String nickName);
	
	public void modifyNick(String nickName);
	
	public void modifyIntro(String userintro);


	
}