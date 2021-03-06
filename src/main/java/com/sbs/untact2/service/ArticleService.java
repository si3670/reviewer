package com.sbs.untact2.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sbs.untact2.dao.ArticleDao;
import com.sbs.untact2.dto.Article;
import com.sbs.untact2.dto.Board;
import com.sbs.untact2.dto.ResultData;

@Service
public class ArticleService {
	@Autowired
	private ArticleDao articleDao;

	public ResultData writeArticle(int boardId, int memberId, String title, String body) {

		articleDao.writeArticle(boardId, memberId, title, body);

		int id = articleDao.getLastInsertId();
		return new ResultData("S-1", "게시물이 작성되었습니다.", "id", id);
	}

	public Article getArticleById(int id) {
		return articleDao.getArticleById(id);
	}



	public ResultData modifyArticle(int id, String title, String body) {
		Article article = getArticleById(id);

		if (isEmpty(article)) {
			return new ResultData("F-1", "존재하지 않는 게시물입니다.", "id", id);
		}

		articleDao.modifyArticle(id, title, body);
		return new ResultData("P-1", "게시물을 수정하였습니다.", "article", article);
	}

	// article이 null, delstatus가 1인 경우 수정,삭제됨
	private boolean isEmpty(Article article) {
		if (article == null) {
			return true;
		} else if (article.isDelStatus()) {
			return true;
		}

		return false;
	}

	public Board getBoardById(int id) {
		return articleDao.getBoardById(id);
	}

	public int getArticlesTotalCount(int boardId, String searchKeyword, String searchKeywordType) {
		return articleDao.getArticlesTotalCount(boardId, searchKeyword, searchKeywordType);
	}

	public List<Article> getForPrintArticles(int boardId, int page, int itemsInAPage, String searchKeyword,
			String searchKeywordType) {
		int limitStart = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		return articleDao.getForPrintArticles(boardId, limitStart, limitTake, searchKeyword, searchKeywordType);
	}

	public void increaseArticleHit(Integer id) {
		articleDao.increaseArticleHit(id);

	}

	public Article getArticleForPrintById(int id) {
		return articleDao.getArticleForPrintById(id);
	}

	// 와인 게시물 글 작성
	public ResultData writeWine(int memberId, int boardId, String title, String body, String wineKinds,
			String wineCountry, String winePlace, int wineVintage, String wineVariety, String wineAlcohol,
			String wineML, String winePrice) {
		
		articleDao.writeWine(memberId, boardId, title, body, wineKinds, wineCountry, winePlace, wineVintage,
				wineVariety, wineAlcohol, wineML, winePrice);
		int id = articleDao.getLastInsertId();
		return new ResultData("S-1", "게시물이 작성되었습니다.", "id", id);
	}
	// 와인 게시물 글 수정
	public ResultData wineModify(int id, String title, String body, String wineKinds, String wineCountry,
			String winePlace, int wineVintage, String wineVariety, String wineAlcohol, String wineML,
			String winePrice) {
		Article article = getArticleById(id);
		
		if (isEmpty(article)) {
			return new ResultData("F-1", "존재하지 않는 게시물입니다.", "id", id);
		}
		articleDao.wineModify(id, title, body, wineKinds, wineCountry, winePlace, wineVintage, wineVariety,
				wineAlcohol, wineML, winePrice);
		return new ResultData("P-1", "게시물을 수정하였습니다.", "article", article);
	}
	// 게시물 글 삭제
	public ResultData deleteArticleById(int id) {
		Article article = getArticleById(id);

		if (isEmpty(article)) {
			return new ResultData("F-1", "존재하지 않는 게시물입니다.", "id", id);
		}
		articleDao.deleteArticleById(id);
		return new ResultData("S-1", "게시물이 삭제되었습니다.", "id", id, "boardId", article.getBoardId());
	}

}
