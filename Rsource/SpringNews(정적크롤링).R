############DB연동
#install.packages("DBI")
#install.packages("RJDBC")
library(DBI)
library(RJDBC)

drv <- JDBC("oracle.jdbc.driver.OracleDriver","C:/ojdbc6.jar")
conn <- dbConnect(drv, "jdbc:oracle:thin:@localhost:1521:xe", "news","news")


#정적크롤링
#install.packages('rvest')
library(rvest)

#MBC뉴스페이지
url <- "http://imnews.imbc.com/news/2018/society/article/5080481_22673.html?menuid=society"
text <- read_html(url, encoding="UTF-8")

#뉴스 제목
Tnodes <- html_nodes(text, "#news_content_1 > div > section > section.header > h1")
title <- html_text(Tnodes)

i <- 1
for (i in 1:6) {
  #타이틀
  tcs <- paste("#news_content_",i," > div > section > section.header > h1", sep="")
  Tnodes <- html_nodes(text, tcs)
  title <- html_text(Tnodes)
  title <- gsub(title, pattern=c("'"), replacement = '"')
  
  #내용
  ccs <- paste("#news_content_",i," > div > section > section.body > section", sep="")
  Cnodes <- html_nodes(text, ccs)
  content <- html_text(Cnodes, trim = TRUE )
  content <- gsub(content, pattern=c("'"), replacement = '"')#문자열 치환
  
  #글쓴이
  wcs <- paste("#news_content_",i," > div > section > section.header > section > span:nth-child(1)", sep="")
  Wnodes <- html_nodes(text, wcs)
  writer <- html_text(Wnodes)
  
  #날짜
  dcs <- paste("#news_content_",i," > div > section > section.header > section > span:nth-child(2)", sep="")
  Dnodes <- html_nodes(text, dcs)
  date <- html_text(Dnodes)
  #date값을 공백 기준으로 분리 
  day <- strsplit(date, " ")[[1]][2]
  
  dbSendUpdate(conn, paste("INSERT INTO news VALUES
                             (NEWS_SEQ.nextval, '",writer,"', '",title,"', '",content,"', '",day,"', 0)",sep="")) #데이터 삽입
}


 





library(RCurl)
library(XML)
library(dplyr) # Optional package (for pipe operator)


#사진
Pnodes <- html_nodes(text, "#news_content_1 > div > section > section.body > figure > div > img")
img_tag_pattern <- "<img.*?>"
img_tag <- Pnodes %>% regmatches(regexpr(img_tag_pattern, .))
src_href_pattern <- "(?<=src=\\\").*?(?=\\\")"
src_href <- img_tag %>% regmatches(regexpr(src_href_pattern, ., perl=T))

#이미지 저장
download.file(src_href, "output/test_image1")


#내용
Cnodes <- html_nodes(text, "#news_content_1 > div > section > section.body > section")
content <- html_text(Cnodes, trim = TRUE )





###########Java연동

#C:\Program Files\R\R-3.5.1\bin\x64
#Rserve --RS-encoding utf8


install.packages("rJava")
install.packages("memoise")
install.packages("KoNLP")

install.packages("wordcloud")
install.packages("wordcloud2")

install.packages("Rserve")
library(Rserve)


###########DB연동
install.packages("DBI")
library(DBI)
install.packages("RJDBC")
library(RJDBC)

drv <- JDBC("oracle.jdbc.driver.OracleDriver","C:/ojdbc6.jar")
conn <- dbConnect(drv, "jdbc:oracle:thin:@localhost:1521:xe", "news","news")

dbListTables(conn)

result1 <- dbReadTable(conn, "NEWS")#테이블이름은 꼭 대문자로 적어줌
result2 <- dbGetQuery(conn, "SELECT * FROM NEWS")
rs <- dbSendQuery(conn, "SELECT * FROM NEWS")
ret1 <- dbFetch(rs, 1) 	  
ret2 <- dbFetch(rs, 1)



