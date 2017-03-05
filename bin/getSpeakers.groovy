

def urlString = "https://api.cfp.io/api/speakers/accepted"

def url = new URL(urlString)
def connection = url.openConnection()
connection.setRequestMethod("GET")
connection.setRequestProperty("Referer", "https://breizhcamp.cfp.io/")
connection.setRequestProperty("accept", "application/json"); 

connection.connect()

if (connection.responseCode != 200) {
    println "HTTP Error for URL ${urlString}"
    println "Error ${connection.responseCode} for talk ${talkId}"
}
else {
    println connection.content.text
}
