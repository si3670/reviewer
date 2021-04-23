package com.sbs.untact2.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sbs.untact2.dto.Article;
import com.sbs.untact2.dto.Board;
import com.sbs.untact2.dto.ResultData;
import com.sbs.untact2.service.ArticleService;
import com.sbs.untact2.util.Util;

@Controller
public class MpaUsrWineArticleController {
	@Autowired
	private ArticleService articleService;

	@RequestMapping("/mpaUsr/article/winewrite")
	public String showWrite(HttpServletRequest req, @RequestParam(defaultValue = "1") int boardId) {
		Board board = articleService.getBoardById(boardId);

		if (board == null) {
			return Util.msgAndBack(req, "존재하지않는 게시판 입니다.");
		}

		req.setAttribute("board", board);
		return "mpaUsr/article/write";
	}

	@RequestMapping("/mpaUsr/article/dowineWrite")
	public String doWrite(HttpServletRequest req, int boardId, String title, String body) {
		if (Util.isEmpty(title)) {
			return Util.msgAndBack(req, "title을 입력해주세요.");
		}
		if (Util.isEmpty(body)) {
			return Util.msgAndBack(req, "body을 입력해주세요.");
		}
		
		int memberId = 3;
		
		ResultData writeArticleRd = articleService.writeArticle(boardId, memberId, title, body);

		if ( writeArticleRd.isFail() ) {
			return Util.msgAndBack(req, writeArticleRd.getMsg());
		}

		return Util.msgAndReplace(req, writeArticleRd.getMsg(), "../article/detail?id=" + writeArticleRd.getBody().get("id"));
	}
	
	//wine 정보 보여주기
	@RequestMapping("/mpaUsr/article/winedetail")
	public String showDetail(Integer id, HttpServletRequest req) {
		articleService.increaseArticleHit(id);
		if (Util.isEmpty(id)) {
			return Util.msgAndBack(req, "id을 입력해주세요.");
		}
		Article article = articleService.getArticleForPrintById(id);

		if (article == null) {
			return Util.msgAndBack(req, "해당 게시글이 존재하지 않습니다.");
		}
		
		Board board = articleService.getBoardById(article.getBoardId());
		
		req.setAttribute("article", article);
		req.setAttribute("board", board);

		return "mpaUsr/article/winedetail";
	}

	@RequestMapping("/mpaUsr/article/winelist")
	public String showList(HttpServletRequest req, @RequestParam(defaultValue = "1") int boardId,
			@RequestParam(defaultValue = "1") int page, String searchKeyword,
			@RequestParam(defaultValue = "titleAndBody") String searchKeywordType) {
		Board board = articleService.getBoardById(boardId);

		if (board == null) {
			return Util.msgAndBack(req, "존재하지않는 게시판 입니다.");
		}

		if (searchKeywordType != null) {
			searchKeywordType = searchKeywordType.trim();
		}

		if (searchKeywordType == null || searchKeywordType.length() == 0) {
			searchKeywordType = "titleAndBody";
		}

		if (searchKeyword != null && searchKeyword.length() == 0) {
			searchKeyword = null;
		}

		if (searchKeyword != null) {
			searchKeyword = searchKeyword.trim();
		}

		if (searchKeyword == null) {
			searchKeywordType = null;
		}

		req.setAttribute("board", board);

		int totalCount = articleService.getArticlesTotalCount(boardId, searchKeyword, searchKeywordType);

		req.setAttribute("totalCount", totalCount);

		int itemsInAPage = 5;
		int totalPage = (int) Math.ceil(totalCount / (double) itemsInAPage);

		req.setAttribute("page", page);
		req.setAttribute("totalPage", totalPage);

		List<Article> articles = articleService.getForPrintArticles(boardId, page, itemsInAPage, searchKeyword,
				searchKeywordType);

		req.setAttribute("articles", articles);

		return "mpaUsr/article/winelist";
	}

}
