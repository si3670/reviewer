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
wineKinds CHAR(100) DEFAULT "" NOT NULL COMMENT '와인종류',
wineCountry CHAR(100) DEFAULT "" NOT NULL COMMENT '와인생산국',
winePlace CHAR(100) DEFAULT "" NOT NULL COMMENT '와인생산지',
wineVintage INT(10) UNSIGNED DEFAULT 0 NOT NULL COMMENT '와인빈티지',
wineVariety CHAR(100) DEFAULT "" NOT NULL COMMENT '와인품종',
wineAlcohol CHAR(100) DEFAULT "" NOT NULL COMMENT '와인알코올',
wineML CHAR(100) DEFAULT "" NOT NULL COMMENT '와인용량',
winePrice CHAR(100) DEFAULT "" NOT NULL COMMENT '와인권장가'
);
SELECT * FROM article;
#테스트 게시판
#1번 회원이 1번 게시판에 글 작성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
boardId = 1,
memberId = 1,
title = "셀러 오픈 프로모션 안내",
`body` = "깊고 진한 루비 컬러와 과일향, 부드러운 타닌의 조화가 뛰어난 
도맨 상타 뒥 지공다스 오 리우디를 특별한 가격에 만나보세요!";

INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
boardId = 1,
memberId = 1,
title = "셀러 소믈리에 멘토를 만나보세요!",
`body` = "베테랑 전문가 분들과 와인 리뷰와 전문적인 지식을 여러분과 공유합니다.";

#1번 회원이 2번 게시판에 글 작성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
boardId = 2,
memberId = 1,
title = "와인 추천해주세요!",
`body` = "모스카토 다스티 종류 와인 추천해주세요 :D";

#2번 회원이 1번 게시판에 글 작성
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
boardId = 1,
memberId = 2,
title = "답변 이벤트 안내 및 활동 주의사항",
`body` = "좋은 답변을 응원합니다!";

#wine게시글
INSERT INTO article
SET regDate = NOW(),
updateDate = NOW(),
boardId = 3,
memberId = 1,
title = "Pétrus Pomerol",
`body` = "검은 자두, 블루베리, 장미, 실론 티, 제비꽃, 초콜릿 코팅한 체리, 
감초, 계피, 시가 향이 느껴진다. 풀 바디의 와인으로 촘촘하고 조밀한 동시에 매끄럽고 
섬세한 타닌, 흠잡을 데 없는 산도, 미네랄 풍미 충만한 아주 긴 피니시가 느껴진다.",
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
`code` = "Notice";

INSERT INTO board
SET regDate = NOW(),
updateDate = NOW(),
`name` = "자유게시판",
`code` = "Free";

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
email = 'si367038@gmail.com',
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
email = 'si367038@gmail.com',
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
email = 'si367038@gmail.com',
cellphoneNo = '01012341234'; 

ALTER TABLE `member` MODIFY COLUMN loginPw VARCHAR(100)  NOT NULL;
UPDATE `member`
SET loginPw = SHA2(loginPw, 256);

SELECT * FROM `member`;


# 부가정보테이블
# 댓글 테이블 추가
CREATE TABLE attr (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT,
    regDate DATETIME NOT NULL,
    updateDate DATETIME NOT NULL,
    `relTypeCode` CHAR(20) NOT NULL,
    `relId` INT(10) UNSIGNED NOT NULL,
    `typeCode` CHAR(30) NOT NULL,
    `type2Code` CHAR(70) NOT NULL,
    `value` TEXT NOT NULL
);

# attr 유니크 인덱스 걸기
## 중복변수 생성금지
## 변수찾는 속도 최적화
ALTER TABLE `attr` ADD UNIQUE INDEX (`relTypeCode`, `relId`, `typeCode`, `type2Code`);

## 특정 조건을 만족하는 회원 또는 게시물(기타 데이터)를 빠르게 찾기 위해서
ALTER TABLE `attr` ADD INDEX (`relTypeCode`, `typeCode`, `type2Code`);

# attr에 만료날짜 추가
ALTER TABLE `attr` ADD COLUMN `expireDate` DATETIME NULL AFTER `value`;

# 댓글 테이블 생성
CREATE TABLE `reply` (
    id INT(10) UNSIGNED NOT NULL PRIMARY KEY AUTO_INCREMENT COMMENT '번호',
    regDate DATETIME NOT NULL COMMENT '작성날짜',
    updateDate DATETIME NOT NULL COMMENT '수정날짜',
    relTypeCode CHAR(50) NOT NULL COMMENT '관련 데이터 타입',
    relId INT(10) UNSIGNED NOT NULL COMMENT '관련 데이터 ID',
    parentId INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '부모댓글 ID',
    memberId INT(10) UNSIGNED NOT NULL COMMENT '회원 ID',
    delStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '삭제여부',
    delDate DATETIME COMMENT '삭제날짜',
    `body` TEXT NOT NULL COMMENT '내용',
    blindStatus TINYINT(1) UNSIGNED NOT NULL DEFAULT 0 COMMENT '블라인드여부',
    blindDate DATETIME COMMENT '블라인드날짜',
    hitCount INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '조회수',
    repliesCount INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '댓글수',
    likeCount INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '좋아요수',
    dislikeCount INT(10) UNSIGNED NOT NULL DEFAULT 0 COMMENT '싫어요수'
);

# 특정 데이터에 관련된 댓글을 읽어는 속도를 빠르게 하기위해
# 인덱스를 건다.
ALTER TABLE `reply` ADD KEY (`relTypeCode`, `relId`);


SELECT * FROM reply 


