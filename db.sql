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
dislikeCount INT(10) UNSIGNED DEFAULT 0  NOT NULL,
wineKinds CHAR(100) NOT NULL COMMENT '와인종류',
wineCountry CHAR(100) NOT NULL COMMENT '와인생산국',
winePlace CHAR(100) NOT NULL COMMENT '와인생산지',
wineVintage INT(10) UNSIGNED NOT NULL COMMENT '와인빈티지',
wineVariety CHAR(100) NOT NULL COMMENT '와인품종',
wineAlcohol CHAR(100) NOT NULL COMMENT '와인알코올',
wineML CHAR(100) NOT NULL COMMENT '와인용량',
winePrice CHAR(100) NOT NULL COMMENT '와인권장가'
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

#wine게시글
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
boardId = 3,
memberId = 1,
title = "petrus pomerol",
`body` = "dry",
wineKinds = "red",
wineCountry ="France",
winePlace ="Pomerol",
wineVintage =2006,
wineVariety ="Merlot",
wineAlcohol = "13.5%",
wineML ="750.0ml",
winePrice ="4,300,000";

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
boardId = 4,
memberId = 1,
title = "petrus pomerol",
`body` = "sweet",
wineKinds = "white",
wineCountry ="France",
winePlace ="Pomerol",
wineVintage =2006,
wineVariety ="Merlot",
wineAlcohol = "13.5%",
wineML ="750.0ml",
winePrice = "4,300,000";

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
boardId = 5,
memberId = 1,
title = "petrus pomerol",
`body` = "Sparkling",
wineKinds = "white",
wineCountry ="France",
winePlace ="Pomerol",
wineVintage =2006,
wineVariety ="Merlot",
wineAlcohol = "13.5%",
wineML ="750.0ml",
winePrice = "4,300,000";

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

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`name` = "DryWine",
`code` = "dryWine";

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`name` = "SweetWine",
`code` = "sweetWine";

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`name` = "SparklingWine",
`code` = "SparklingWine";

SELECT * FROM article;

# 회원 테이블 생성
CREATE TABLE `member` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '번호',
    regDate DATETIME NOT NULL COMMENT '작성날짜',
    updateDate DATETIME NOT NULL COMMENT '수정날짜',
    loginId CHAR(20) NOT NULL UNIQUE COMMENT '로그인아이디',
    loginPw VARCHAR(50) NOT NULL COMMENT '로그인비번',
    `name` CHAR(50) NOT NULL COMMENT '이름',
    nickname CHAR(50) NOT NULL COMMENT '별명',
    email CHAR(50) NOT NULL COMMENT '이메일',
    cellphoneNo CHAR(15) NOT NULL COMMENT '휴대전화번호',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '탈퇴여부',
    delDate DATETIME COMMENT '탈퇴날짜'
);

# 회원 테스트 데이터 생성
## 1번 회원 생성
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'user1',
loginPw = 'user1',
`name` = '유저1이름',
nickname = '유저1별명',
email = 'jangka512@gmail.com',
cellphoneNo = '01012341234';

# 회원 테스트 데이터 생성
## 2번 회원 생성
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'user2',
loginPw = 'user2',
`name` = '유저2이름',
nickname = '유저2별명',
email = 'jangka512@gmail.com',
cellphoneNo = '01012341234';

# 회원 테스트 데이터 생성
## 3번 회원 생성
INSERT INTO `member`
SET regDate = NOW(),
updateDate = NOW(),
loginId = 'user3',
loginPw = 'user3',
`name` = '유저3이름',
nickname = '유저3별명',
email = 'jangka512@gmail.com',
cellphoneNo = '01012341234'; 

ALTER TABLE `member` MODIFY COLUMN loginPw VARCHAR(100)  NOT NULL;

