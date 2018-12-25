#java -jar selenium-server-standalone.jar -port 4445


#브라우저를 제어하기 위한 패키지
#install.packages("RSelenium")
library(RSelenium)

#사이트 접속
remDr <- remoteDriver(remoteServerAddr ="localhost", port = 4445, browserName = "chrome")
remDr$open()
site <- paste("http://imnews.imbc.com/replay/2018/nw1700/article/5085287_23836.html?menuid=society")
remDr$navigate(site)
webElem <- remDr$findElement("css","body")


###########Java연동

#C:\Program Files\R\R-3.5.1\bin\x64
#Rserve --RS-encoding utf8


#install.packages("rJava")
#install.packages("memoise")
#install.packages("KoNLP")

#install.packages("wordcloud")
#install.packages("wordcloud2")

#install.packages("Rserve")
library(Rserve)


#SQL연동
#install.packages("DBI")
library(DBI)
#install.packages("RJDBC")
library(RJDBC)

drv <- JDBC("oracle.jdbc.driver.OracleDriver","C:/ojdbc6.jar")
conn <- dbConnect(drv, "jdbc:oracle:thin:@localhost:1521:xe", "news","news")



i <- 1
for(i in 1:6){
  #뉴스 제목
  tcs <- paste("#news_content_",i," > div > section > section.header > h1", sep="")
  Tnodes <- remDr$findElement(using = 'css', tcs)
  title <- Tnodes$getElementText()
  title <- gsub(title, pattern=c("'"), replacement = '"')
  
  #내용
  ccs <- paste("#news_content_",i," > div > section > section.body > section", sep="")
  Cnodes <- remDr$findElement(using = 'css', ccs)
  content <- Cnodes$getElementText()
  content <- gsub(content, pattern=c("'"), replacement = '"')
  
  
  #글쓴이
  wcs <- paste("#news_content_",i," > div > section > section.header > section > span:nth-child(1)", sep="")
  Wnodes <- remDr$findElement(using = 'css', wcs)
  writer <- Wnodes$getElementText()
  
  #날짜
  dcs <- paste("#news_content_",i," > div > section > section.header > section > span:nth-child(2)", sep="")
  Dnodes <- remDr$findElement(using = 'css', dcs)
  date <- Dnodes$getElementText()
  
  #date값을 공백 기준으로 분리 
  day <- strsplit(date[[1]], " ")[[1]][2]
  
  
  #내용 삽입
  dbSendUpdate(conn, paste("INSERT INTO news VALUES
                             (NEWS_SEQ.nextval, '",writer,"', '",title,"', '",content,"', '",day,"', 0)",sep=""))
  
  #스크롤내리기
  remDr$executeScript("scrollBy(0,2000)",args = list(webElem))
  Sys.sleep(1)
}

