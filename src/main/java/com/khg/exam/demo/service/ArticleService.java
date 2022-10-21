package com.khg.exam.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.khg.exam.demo.repository.ArticleRepository;
import com.khg.exam.demo.util.Ut;
import com.khg.exam.demo.vo.Article;
import com.khg.exam.demo.vo.ResultData;

@Service
public class ArticleService {

	@Autowired
	private ArticleRepository articleRepository;

	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;

	}

	// 서비스메서드
	public Article getArticle(int id) {
		
		return articleRepository.getArticle(id);
		
	}
	
	public List<Article> getArticles() {
		
		return articleRepository.getArticles();
	}

	public ResultData<Integer> writeArticle(int memberId, String title, String body) {

		articleRepository.writeArticle(memberId, title, body);
		int id = articleRepository.getLastInsertId();
		
		return ResultData.from("S-1", Ut.f("%d번 게시물이 생성되었습니다", id), id);
	}

	public void deleteArticle(int id) {

		articleRepository.deleteArticle(id);
	}

	public void modifyArticle(int id, String title, String body) {
		
		articleRepository.modifyArticle(id, title, body);
	}

}
