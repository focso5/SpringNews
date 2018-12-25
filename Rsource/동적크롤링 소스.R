###############동적 크롤링
#java -jar selenium-server-standalone.jar -port 4445

#install.packages("RSelenium")
library(RSelenium)#브라우저를 제어하기 위한 패키지
#사이트 접속
remDr <- remoteDriver(remoteServerAddr ="localhost", port = 4445, browserName = "chrome")
remDr$open()
remDr$navigate("http://imnews.imbc.com/index_pc.html")


#구글 페이지 접속 후 JAVA검색
remDr <- remoteDriver(remoteServerAddr ="localhost", port = 4445, browserName = "chrome")
remDr$open()
remDr$navigate("http://www.google.com/ncr")
webElem <- remDr$findElement(using = "css","[name = 'q']")
webElem$sendKeysToActiveElement(list("JAVA",key="enter"))


#yes24페이지 스크롤 내리기
site <- paste("http://www.yes24.com/24/goods/40936880")
remDr$navigate(site)
webElem <- remDr$findElement("css","body")
#remDr$executeAsyncScript("scrollTo(0,document.body.scrollHeight-200)",args= list(webElem))
remDr$executeScript("scrollBy(0,2000)",args = list(webElem))
Sys.sleep(1)
remDr$executeScript("scrollBy(0,2000)",args = list(webElem))
Sys.sleep(1)
remDr$executeScript("scrollBy(0,2000)",args = list(webElem))
Sys.sleep(1)
remDr$executeScript("scrollBy(0,2000)",args = list(webElem))
Sys.sleep(3)
repl_v = NULL
endFlag <- FALSE
page <- 3
repeat{
  for(index in 1:5){
    fullContentLinkCSS <- paste('#PartContent',index, sep="")
    fullContentLink <- remDr$findElements(using = 'css', fullContentLinkCSS)
    print(fullContentLink)
    if(length(fullContentLink) == 0){
      endFlag <- TRUE
      break
     }
   sapply(fullContentLink,function(x){x$clickElement()})
   Sys.sleep(1)
   fullContentCSS <- paste('#FullContent',index, sep = "")
   fullContent <- remDr$findElements(using = 'css',fullContentCSS)
   print(fullContent)
   repl <- sapply(fullContent, function(x){x$getElementText()})
   print(repl)
   repl_v <- c(repl_v,unlist(repl))
  }
  if(endFlag)
    break;
  
  page <- page+1;
  if(page == 5){
    page <- page+1;
  }
  nextPaageCSS <- paste('#Div_Review > p:nth-child(11) > a:nth-child(",page,")',sep="")
  nextPaageLink <- remDr$findElements(using = 'css',nextPaageCSS)
  if(page == 14)
    page<-3
    sapply(nextPaageLink,function(x){x$clickElement()})
    Sys.sleep(5)
    remDr$executeScript("scrollBy(0,-3000)",args = list(webElem))
    #print(page)
}
  write(repl_v,"yes24.txt")
















