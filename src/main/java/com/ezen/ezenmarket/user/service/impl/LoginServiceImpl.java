package com.ezen.ezenmarket.user.service.impl;

import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ezen.ezenmarket.user.controller.LogOutController;
import com.ezen.ezenmarket.user.dto.User;
import com.ezen.ezenmarket.user.mapper.UserMapper;
import com.ezen.ezenmarket.user.service.LoginService;


@Service
public class LoginServiceImpl implements LoginService{
	
	
	@Autowired
	UserMapper userMapper;
	
	
	@Override
	public boolean login(String user_id, String user_pw, HttpServletRequest req, HttpServletResponse resp) {
		
		List<User> userList = userMapper.getUserList();
		
		HttpSession session = req.getSession();
				
		for (User user : userList) {
			if (user_id.equals(user.getUser_ID()) && user_pw.equals(user.getUser_PW())) {
		    	// getSession()�� ������ ������ �ִ� ������ ��ȯ�ϰ�, ������ �ű� ������ �����Ѵ�
				 // ������ �α��� ȸ�� ������ �����Ѵ�
				session.setAttribute("login", "yes");
				session.setAttribute("nickname", user.getNickname());
				
				// ��Ű�� user_id ����
				Cookie cookie = new Cookie("user_id", user_id);
				cookie.setPath(req.getContextPath());
				resp.addCookie(cookie);
				
				return true;
 
			} else {
				
				session.setAttribute("errorMsg", "�α��� ������ �ùٸ��� �ʽ��ϴ�.");
			}
		}
		return false;
		
	}
	
	
	@Override
	public void logout(HttpServletRequest req, HttpServletResponse resp) {
		
		
		req.getSession().invalidate();
		
		
	}
	

	
}
