DROP DATABASE IF EXISTS insta;
CREATE DATABASE insta;
USE insta;

CREATE TABLE article(
id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
boardId INT(10) UNSIGNED NOT NULL,
memberId INT(10) UNSIGNED NOT NULL,
title CHAR(100) NOT NULL,
`body` TEXT NOT NULL,
blindStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '블라인드여부',
blindDate DATETIME COMMENT '블라인드날짜',
delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부',
delDate DATETIME COMMENT '삭제날짜',
hitCount INT(10) UNSIGNED DEFAULT 0 NOT NULL,
repliesCount INT(10) UNSIGNED DEFAULT 0 NOT NULL,
likeCount INT(10) UNSIGNED DEFAULT 0  NOT NULL,
dislikeCount INT(10) UNSIGNED DEFAULT 0  NOT NULL
);

#테스트 게시판
#1번 회원이 1번 게시판에 글 작성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
boardId = 1,
memberId = 1,
title = "제목1",
`body` = "내용1";

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
boardId = 1,
memberId = 1,
title = "제목2",
`body` = "내용2";

#1번 회원이 2번 게시판에 글 작성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
boardId = 2,
memberId = 1,
title = "제목3",
`body` = "내용3";

#2번 회원이 1번 게시판에 글 작성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
boardId = 1,
memberId = 2,
title = "제목4",
`body` = "내용4";

SELECT  LAST_INSERT_ID();

CREATE TABLE board(
id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
regDate DATETIME NOT NULL,
updateDate DATETIME NOT NULL,
`name` CHAR(20) NOT NULL UNIQUE,
`code` CHAR(20) NOT NULL UNIQUE,
blindStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '블라인드여부',
blindDate DATETIME COMMENT '블라인드날짜',
delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부',
delDate DATETIME COMMENT '삭제날짜',
hitCount INT(10) UNSIGNED DEFAULT 0 NOT NULL,
repliesCount INT(10) UNSIGNED DEFAULT 0 NOT NULL,
likeCount INT(10) UNSIGNED DEFAULT 0  NOT NULL,
dislikeCount INT(10) UNSIGNED DEFAULT 0  NOT NULL
);


INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`name` = "공지사항",
`code` = "notice";

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`name` = "자유게시판",
`code` = "free";

SELECT * FROM board;

