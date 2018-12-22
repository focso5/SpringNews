#정적크롤링
install.packages('rvest')
library(rvest)

#MBC뉴스페이지
url <- "http://imnews.imbc.com/news/2018/society/article/5080481_22673.html?menuid=society"
text <- read_html(url, encoding="UTF-8")

#뉴스 제목
Tnodes <- html_nodes(text, "#news_content_1 > div > section > section.header > h1")
title <- html_text(Tnodes)

for (i in 1:6) {
  Tnodes <- html_nodes(text, "#news_content_[i] > div > section > section.header > h1")
  title <- html_text(Tnodes)
  dbSendUpdate(conn, paste("INSERT INTO detail_country VALUES
                             ('",iso[i],"', '",name[i],"', '",title[j],"', ' ')",sep="")) #데이터 삽입
}


#글쓴이
Wnodes <- html_nodes(text, "#news_content_1 > div > section > section.header > section > span:nth-child(1)")
writer <- html_text(Wnodes)

#날짜
Dnodes <- html_nodes(text, "#news_content_1 > div > section > section.header > section > span:nth-child(2)")
date <- html_text(Dnodes)



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



