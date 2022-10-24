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
	public Article getForPrintArticle(int id) {
		
		return articleRepository.getForPrintArticle(id);
		
	}
	
	public List<Article> getForPrintArticles() {
		
		return articleRepository.getArticles();
	}

	public ResultData<Integer> writeArticle(int memberId, String title, String body) {

		articleRepository.writeArticle(memberId, title, body);
		int id = articleRepository.getLastInsertId();
		
		return ResultData.from("S-1", Ut.f("%d번 게시물이 생성되었습니다", id), "id", id);
	}

	public void deleteArticle(int id) {

		articleRepository.deleteArticle(id);
	}

	public ResultData<Article> modifyArticle(int id, String title, String body) {
		
		articleRepository.modifyArticle(id, title, body);
		
		Article article = getForPrintArticle(id);
		
		return ResultData.from("S-1", Ut.f("%d번 게시물을 수정했습니다", id), "article", article);
	}

	public ResultData actorCanModfy(int loginedMemberId, Article article) {
		
		if (article.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", "해당 게시물에 대한 권한이 없습니다");
		}
		
		return ResultData.from("S-1", "수정 가능");
	}

}
