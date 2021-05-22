package com.sbs.untact2.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sbs.untact2.dto.Article;
import com.sbs.untact2.dto.Board;
import com.sbs.untact2.dto.Reply;
import com.sbs.untact2.dto.ResultData;
import com.sbs.untact2.dto.Rq;
import com.sbs.untact2.service.ArticleService;
import com.sbs.untact2.service.ReplyService;
import com.sbs.untact2.util.Util;

@Controller
public class MpaUsrWineController {
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ReplyService replyService;

	@RequestMapping("/mpaUsr/article/winewrite")
	public String showWineWrite(HttpServletRequest req, @RequestParam(defaultValue = "3") int boardId) {
		Board board = articleService.getBoardById(boardId);

		if (board == null) {
			return Util.msgAndBack(req, "존재하지않는 게시판 입니다.");
		}

		req.setAttribute("board", board);
		return "mpaUsr/article/winewrite";
	}

	@RequestMapping("/mpaUsr/article/doWineWrite")
	public String doWineWrite(HttpServletRequest req, int boardId, String title, String body, String wineKinds,
			String wineCountry, String winePlace, int wineVintage, String wineVariety, String wineAlcohol,
			String wineML, String winePrice) {

		Rq rq = (Rq) req.getAttribute("rq");
		int memberId = rq.getLoginedMemberId();
		ResultData writeWineRd = articleService.writeWine(memberId, boardId, title, body, wineKinds, wineCountry,
				winePlace, wineVintage, wineVariety, wineAlcohol, wineML, winePrice);

		if (writeWineRd.isFail()) {
			return Util.msgAndBack(req, writeWineRd.getMsg());
		}

		return Util.msgAndReplace(req, writeWineRd.getMsg(),
				"../article/winedetail?id=" + writeWineRd.getBody().get("id"));
	}

	// wine 정보 보여주기
	@RequestMapping("/mpaUsr/article/winedetail")
	public String showDetail(Integer id, HttpServletRequest req, @RequestParam(defaultValue = "3") int boardId
			) {
		//String relTypeCode, int relId
		
		
		articleService.increaseArticleHit(id);
		Article article = articleService.getArticleForPrintById(id);
		List<Reply> replies = replyService.getForPrintRepliesByRelTypeCodeAndRelId("article", id);

		if (article == null) {
			return Util.msgAndBack(req, "해당 게시글이 존재하지 않습니다.");
		}

		Board board = articleService.getBoardById(article.getBoardId());

		//int totalCount = replyService.getReplyTotalCount(relTypeCode, relId);

		//req.setAttribute("totalCount", totalCount);

		req.setAttribute("replies", replies);
		req.setAttribute("article", article);
		req.setAttribute("board", board);

		return "mpaUsr/article/winedetail";
	}

	@RequestMapping("/mpaUsr/article/winelist")
	public String showList(HttpServletRequest req, @RequestParam(defaultValue = "3") int boardId,
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
	
	@RequestMapping("/mpaUsr/article/doWineDelete")
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
	
	

}
