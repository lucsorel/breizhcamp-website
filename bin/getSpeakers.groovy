

def urlString = "https://api.cfp.io/v0/schedule/speakers"

def url = new URL(urlString)
def connection = url.openConnection()
connection.setRequestMethod("GET")
connection.setRequestProperty("X-Tenant-Id", "breizhcamp")
connection.setRequestProperty("accept", "application/json")

connection.connect()

if (connection.responseCode != 200) {
    println "HTTP Error for URL ${urlString}"
    println "Error ${connection.responseCode}"
}
else {
    println connection.content.text
}
