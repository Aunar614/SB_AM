package com.khg.exam.demo.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Controller
public class UsrHomeController {
	
	@RequestMapping("usr/home/getString")
	@ResponseBody
	public String getString() {
		
		return "hi";
	}
	
	@RequestMapping("usr/home/getInt")
	@ResponseBody
	public int getInt() {
		
		return 10;
	}
	
	@RequestMapping("usr/home/getFloat")
	@ResponseBody
	public float getFloat() {
		
		return 10.5f;
	}
	
	@RequestMapping("usr/home/getDouble")
	@ResponseBody
	public double getDouble() {
		
		return 10.5;
	}
	
	@RequestMapping("usr/home/getBoolean")
	@ResponseBody
	public boolean getBoolean() {
		
		return true;
	}
	
	@RequestMapping("usr/home/getChar")
	@ResponseBody
	public char getChar() {
		
		return 'a';
	}
	
	@RequestMapping("usr/home/getList")
	@ResponseBody
	public List<String> getList() {
		List<String> list = new ArrayList<>();
		list.add("철수나이");
		list.add("영희나이");
		
		return list;
	}
	
	@RequestMapping("usr/home/getArticles")
	@ResponseBody
	public List<Article> getArticles() {
		Article article1 = new Article(1, "title1");
		Article article2 = new Article(2, "title2");
		
		List<Article> articles = new ArrayList<>();
		articles.add(article1);
		articles.add(article2);
		
		return articles;
	}
}

@Data
@NoArgsConstructor
@AllArgsConstructor
class Article {
	private int id;
	private String title;
	
}