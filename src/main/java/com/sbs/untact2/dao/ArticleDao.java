package com.sbs.untact2.dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import com.sbs.untact2.dto.Article;
import com.sbs.untact2.dto.Board;

@Mapper
public interface ArticleDao {

	boolean modifyArticle(@Param("id") int id, @Param("title") String title, @Param("body") String body);

	void writeArticle(@Param("boardId") int boardId, @Param("memberId") int memberId, @Param("title") String title,
			@Param("body") String body);

	Article getArticleById(@Param("id") int id);

	int getLastInsertId();

	void deleteArticleById(@Param("id") int id);

	Board getBoardById(@Param("id") int id);

	int getArticlesTotalCount(@Param("boardId") int boardId, @Param("searchKeyword") String searchKeyword,
			@Param("searchKeywordType") String searchKeywordType);

	List<Article> getForPrintArticles(@Param("boardId") int boardId, @Param("limitStart") int limitStart,
			@Param("limitTake") int limitTake, @Param("searchKeyword") String searchKeyword,
			@Param("searchKeywordType") String searchKeywordType);

	void increaseArticleHit(@Param("id") int id);

	Article getArticleForPrintById(@Param("id") int id);

	void writeWine(@Param("memberId") int memberId, @Param("boardId") int boardId, @Param("title") String title,
			@Param("body") String body, @Param("wineKinds") String wineKinds, @Param("wineCountry") String wineCountry,
			@Param("winePlace") String winePlace, @Param("wineVintage") int wineVintage,
			@Param("wineVariety") String wineVariety, @Param("wineAlcohol") String wineAlcohol,
			@Param("wineML") String wineML, @Param("winePrice") String winePrice);

	void wineModify(@Param("id") int id, @Param("title") String title, @Param("body") String body,
			@Param("wineKinds") String wineKinds, @Param("wineCountry") String wineCountry,
			@Param("winePlace") String winePlace, @Param("wineVintage") int wineVintage,
			@Param("wineVariety") String wineVariety, @Param("wineAlcohol") String wineAlcohol,
			@Param("wineML") String wineML, @Param("winePrice") String winePrice);

}
