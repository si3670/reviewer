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
import com.sbs.untact2.dto.Reply;
import com.sbs.untact2.dto.ResultData;
import com.sbs.untact2.dto.Rq;
import com.sbs.untact2.service.ArticleService;
import com.sbs.untact2.service.ReplyService;
import com.sbs.untact2.util.Util;

@Controller
public class MpaUsrArticleController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ReplyService replyService;

	@RequestMapping("/mpaUsr/article/write")
	public String showWrite(HttpServletRequest req, @RequestParam(defaultValue = "1") int boardId) {
		Board board = articleService.getBoardById(boardId);

		if (board == null) {
			return Util.msgAndBack(req, "존재하지않는 게시판 입니다.");
		}

		req.setAttribute("board", board);
		return "mpaUsr/article/write";
	}

	@RequestMapping("/mpaUsr/article/doWrite")
	public String doWrite(HttpServletRequest req, int boardId, String title, String body) {
		if (Util.isEmpty(title)) {
			return Util.msgAndBack(req, "title을 입력해주세요.");
		}
		if (Util.isEmpty(body)) {
			return Util.msgAndBack(req, "body을 입력해주세요.");
		}

		Rq rq = (Rq) req.getAttribute("rq");

		int memberId = rq.getLoginedMemberId();

		ResultData writeArticleRd = articleService.writeArticle(boardId, memberId, title, body);

		if (writeArticleRd.isFail()) {
			return Util.msgAndBack(req, writeArticleRd.getMsg());
		}

		return Util.msgAndReplace(req, writeArticleRd.getMsg(),
				"../article/detail?id=" + writeArticleRd.getBody().get("id"));
	}

	@RequestMapping("/mpaUsr/article/detail")
	public String showDetail(Integer id, HttpServletRequest req, @RequestParam(defaultValue = "1") int boardId) {
		articleService.increaseArticleHit(id);
		Article article = articleService.getArticleForPrintById(id);
		List<Reply> replies = replyService.getForPrintRepliesByRelTypeCodeAndRelId(boardId, "article", id);

		if (article == null) {
			return Util.msgAndBack(req, "해당 게시글이 존재하지 않습니다.");
		}

		Board board = articleService.getBoardById(article.getBoardId());

		req.setAttribute("replies", replies);
		req.setAttribute("article", article);
		req.setAttribute("board", board);

		return "mpaUsr/article/detail";
	}

	@RequestMapping("/mpaUsr/article/doDelete")
	public String doDelete(Integer id, HttpServletRequest req) {
		if (Util.isEmpty(id)) {
			return Util.msgAndBack(req, "id을 입력해주세요.");
		}

		ResultData rd = articleService.deleteArticleById(id);

		if (rd.isFail()) {
			return Util.msgAndBack(req, rd.getMsg());
		}
		String replaceUri = "../article/list?boardId=" + rd.getBody().get("boardId");
		return Util.msgAndReplace(req, rd.getMsg(), replaceUri);
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

		return "mpaUsr/article/list";
	}

}
