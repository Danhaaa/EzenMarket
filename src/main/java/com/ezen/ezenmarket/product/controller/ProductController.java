package com.ezen.ezenmarket.product.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.CookieGenerator;

import com.ezen.ezenmarket.product.dto.Post;
import com.ezen.ezenmarket.product.mapper.ProductMapper;
import com.ezen.ezenmarket.product.service.ProductService;
import com.ezen.ezenmarket.user.dto.User;

import lombok.extern.log4j.Log4j2;

@Log4j2
@Controller
public class ProductController {
	
	@Autowired
	ProductMapper productMapper;
	
	@Autowired
	ProductService productService;	// 내가 추가한 것

	
	@GetMapping(value="/search")
	public String searchProduct() {
		
		return "product/product_search";
	}
	
	@GetMapping(value="/register")
	public String registerProduct() {
		
		return "product/product_register";
	}
	
	/* 여기부터 내가 만든 것! 위의 것은 건들지 말기!!*/
	
	/* 카테고리별로 상품 조회하기 (+페이징) */
	// http://localhost:8888/ezenmarket/category?category_id=1&page=2
	@GetMapping("/category")
	public String cateList(@RequestParam(required = false, defaultValue = "1") Integer category_id,
	                       @RequestParam(required = false, defaultValue = "1") Integer page,
	                       HttpServletRequest req, Model model) {
		model.addAttribute("id", productService.paging(req, category_id));
		model.addAttribute("cateList", req.getAttribute("boards"));		
		model.addAttribute("page",  req.getParameter("page"));
		model.addAttribute("pagination_start", req.getAttribute("pagination_start"));
		model.addAttribute("pagination_end", req.getAttribute("pagination_end"));
		log.info("--------------------category_id" + category_id);
		
		return "product/product_menu";
	}

	
	 /* 상품 상세페이지(상품정보 + 상품이미지정보 + 판매자정보) */
	@GetMapping(value="/product")
	public String productDetail(@RequestParam("id") Integer post_id, 
												HttpServletRequest request, 
												HttpServletResponse response, 
												Model model) {
		             
		Post p =  productService.getDetails(post_id);	
		int cntProd = productService.cntProdBySeller(p.getUser_number());	
		model.addAttribute("cntProd", cntProd);	
		model.addAttribute("post", p); 	
			
		// 판매자가 등록한 연관상품 목록 가져오기
		List<Post> lists = productService.getRelatedProd(p.getUser_number(), p.getPost_id());
		if(lists != null && lists.size() > 4) {
			model.addAttribute("lists", lists.subList(0, 4));			
		} else if(lists != null){
			model.addAttribute("lists", lists);
		}
		
		// 찜목록 개수 가져오기
		int cntWishlist = productService.cntWishlist(p.getPost_id());		
		model.addAttribute("cntWishlist", cntWishlist);
				
		
		/* 조회수 가져오기 (새로고침 시  중복 방지) */			
		
		// 이전에 생성된 쿠키가 있는지 확인
	    boolean isVisited = false;
	    Cookie[] cookies = request.getCookies();
	    
	    // 1) 쿠키O & 쿠키에 현재 상품의 id 값이 포함된 경우 -> 이전에 방문한 것으로 간주
	    if (cookies != null) {
	        for (Cookie cookie : cookies) {
	            if (cookie.getName().equals("visit_cookie") && cookie.getValue().contains(p.getPost_id().toString())) {
	                isVisited = true;	             
	                break;
	            }
	        }
	    }
	    
	    // 쿠키가 없거나, 쿠키는 있지만 현재 상품의 id값이 포함되지 않은 경우 -> 새로운 쿠키를 생성 or 이전 쿠키의 값을 업데이트
	    if (!isVisited) {
	        String visitCookieValue = "";
	        
	        if (cookies != null) {
	        	// 2) 쿠키O&방문X  -> 기존 쿠키의 값에 현재 상품의 id값을 추가
	            for (Cookie cookie : cookies) {
	                if (cookie.getName().equals("visit_cookie")) {
	                    visitCookieValue = cookie.getValue();	     
	                    break;
	                }
	            }
	        } 
	        
	        // 3) 쿠키X&방문X  -> new cookie 생성 & id 추가
	        visitCookieValue += "/" + p.getPost_id();
	        Cookie newCookie = new Cookie("visit_cookie", visitCookieValue);
	        newCookie.setMaxAge(60 * 60 * 24);	// 쿠키는 24시간(하루) 동안 유효
	        response.addCookie(newCookie);	     
	        productService.plusView(p.getPost_id());
	    }
		
		return "product/product_detail";
		
	}

	
}