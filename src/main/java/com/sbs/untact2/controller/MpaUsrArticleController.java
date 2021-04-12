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
public class MpaUsrArticleController {
	@Autowired
	private ArticleService articleService;

	private String msgAndBack(HttpServletRequest req, String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		return "common/redirect";
	}

	private String msgAndReplace(HttpServletRequest req, String msg, String redirectUrl) {
		req.setAttribute("msg", msg);
		req.setAttribute("redirectUrl", redirectUrl);
		return "common/redirect";
	}



	@RequestMapping("/mpaUsr/article/doWrite")
	@ResponseBody
	public ResultData doWrite(String title, String body) {
		if (Util.isEmpty(title)) {
			return new ResultData("F-1", "title을 입력해주세요.");
		}
		if (Util.isEmpty(body)) {
			return new ResultData("F-2", "body을 입력해주세요.");
		}

		return articleService.writeArticle(title, body);
	}

	@RequestMapping("/mpaUsr/article/getArticle")
	@ResponseBody
	public ResultData getArticle(Integer id) {
		articleService.increaseArticleHit(id);
		if (Util.isEmpty(id)) {
			return new ResultData("F-1", "id을 입력해주세요.");
		}
		Article article = articleService.getArticleById(id);

		if (article == null) {
			return new ResultData("F-1", id + "번 글은 존재하지 않습니다.", "id", id);
		}

		return new ResultData("P-1", article.getId() + "번 게시물 입니다.", "article", article);
	}

	@RequestMapping("/mpaUsr/article/doDelete")
	public String doDelete(Integer id, HttpServletRequest req) {
		if (Util.isEmpty(id)) {
			return msgAndBack(req, "id을 입력해주세요.");
		}

		ResultData rd = articleService.deleteArticleById(id);

		if (rd.isFail()) {
			return msgAndBack(req, rd.getMsg());
		}
		String redirectUrl = "../article/list?boardId=" + rd.getBody().get("boardId");
		return msgAndReplace(req, rd.getMsg(), redirectUrl);
	}

	@RequestMapping("/mpaUsr/article/doModify")
	@ResponseBody
	public ResultData doModify(Integer id, String title, String body) {
		if (Util.isEmpty(id)) {
			return new ResultData("F-1", "id을 입력해주세요.");
		}
		if (Util.isEmpty(title)) {
			return new ResultData("F-2", "title을 입력해주세요.");
		}
		if (Util.isEmpty(body)) {
			return new ResultData("F-3", "body을 입력해주세요.");
		}

		Article article = articleService.getArticleById(id);

		if (article == null) {
			return new ResultData("F-4", "존재하지 않는 게시물 번호입니다.");
		}

		return articleService.modifyArticle(id, title, body);
	}

	@RequestMapping("/mpaUsr/article/list")
	public String showList(HttpServletRequest req, @RequestParam(defaultValue = "1") int boardId,
			@RequestParam(defaultValue = "1") int page, String searchKeyword,
			@RequestParam(defaultValue = "titleAndBody") String searchKeywordType) {
		Board board = articleService.getBoardById(boardId);

		if (board == null) {
			return msgAndBack(req, "존재하지않는 게시판 입니다.");
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

		int itemsInAPage = 20;
		int totalPage = (int) Math.ceil(totalCount / (double) itemsInAPage);

		req.setAttribute("page", page);
		req.setAttribute("totalPage", totalPage);

		List<Article> articles = articleService.getForPrintArticles(boardId, page, itemsInAPage, searchKeyword,
				searchKeywordType);

		req.setAttribute("articles", articles);

		return "mpaUsr/article/list";
	}

}
