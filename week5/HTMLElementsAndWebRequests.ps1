$scraped_page = Invoke-WebRequest -TimeoutSec 10 http://localhost/ToBeScraped.html

# 9. get link count
#$scraped_page.Links.Count

# 10. get the links as html elements
#$scraped_page.Links

# 11. get the links and display only the URL and its text
#$scraped_page.Links | select outerText, href

# 12. get out text of every element with tag h2
#$h2s=$scraped_page.ParsedHtml.body.getElementsByTagName("h2") | select outerText
#$h2s


# 13. print innterText of every div element that has the class as "div-1"
$divs1=$scraped_page.ParsedHtml.body.getElementsByTagName("div") | `
where { $_.getAttributeNode("class").value -ilike "div-1" } | select innerText

$divs1