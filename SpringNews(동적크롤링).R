#install.packages("RSelenium")
library(RSelenium)#브라우저를 제어하기 위한 패키지
#install.packages('rvest')
#library(rvest)
#사이트 접속
remDr <- remoteDriver(remoteServerAddr ="localhost", port = 4445, browserName = "chrome")
remDr$open()
site <- paste("http://imnews.imbc.com/replay/2018/nw1700/article/5085287_23836.html?menuid=society")
remDr$navigate(site)
text <- read_html(site, encoding="UTF-8")
webElem <- remDr$findElement("css","body")


library(DBI)
library(RJDBC)

drv <- JDBC("oracle.jdbc.driver.OracleDriver","C:/ojdbc6.jar")
conn <- dbConnect(drv, "jdbc:oracle:thin:@localhost:1521:xe", "news","news")




i <- 1
for(i in 1:6){
  if(i >= 6){
    break
  }
  #뉴스 제목
  tcs <- paste("#news_content_",i," > div > section > section.header > h1", sep="")
  Tnodes <- html_nodes(text, tcs)
  title <- html_text(Tnodes)
  title <- gsub(title, pattern=c("'"), replacement = '"')
  
  #내용
  ccs <- paste("#news_content_",i," > div > section > section.body > section", sep="")
  Cnodes <- html_nodes(text, ccs)
  content <- html_text(Cnodes, trim = TRUE )
  content <- gsub(content, pattern=c("'"), replacement = '"')
  
  
  #글쓴이
  wcs <- paste("#news_content_",i," > div > section > section.header > section > span:nth-child(1)", sep="")
  Wnodes <- html_nodes(text, wcs)
  writer <- html_text(Wnodes)
  
  #날짜
  dcs <- paste("#news_content_",i," > div > section > section.header > section > span:nth-child(2)", sep="")
  Dnodes <- html_nodes(text, dcs)
  date <- html_text(Dnodes)
  str_replace_all(date, "[\r\n]" , " ") 
  #date값을 공백 기준으로 분리 
  day <- strsplit(date, " ")[[1]][1]
  
  dbSendUpdate(conn, paste("INSERT INTO news VALUES
                             (NEWS_SEQ.nextval, '",writer,"', '",title,"', '",content,"', '",day,"', 0)",sep=""))
  
  
  remDr$executeScript("scrollBy(0,2000)",args = list(webElem))
  
  Sys.sleep(1)
}

remDr$executeScript("scrollBy(0,2000)",args = list(webElem))
Sys.sleep(1)
remDr$executeScript("scrollBy(0,2000)",args = list(webElem))
Sys.sleep(1)
remDr$executeScript("scrollBy(0,2000)",args = list(webElem))
Sys.sleep(1)
remDr$executeScript("scrollBy(0,2000)",args = list(webElem))
Sys.sleep(1)
remDr$executeScript("scrollBy(0,2000)",args = list(webElem))
Sys.sleep(1)
remDr$executeScript("scrollBy(0,2000)",args = list(webElem))
Sys.sleep(3)
