import org.w3c.tidy.Tidy


// configuration ------------------------------------------------------------ \\

def final charset = 'UTF-8'

def final tidy = new Tidy()
tidy.setXHTML(true)
tidy.setShowWarnings(false)
tidy.setInputEncoding(charset)
tidy.setOutputEncoding(charset)
tidy.setQuiet(true)

def final parser = new XmlSlurper()
parser.setFeature("http://apache.org/xml/features/nonvalidating/load-external-dtd", false)



// functions ---------------------------------------------------------------- \\

def log = { message ->
  println new Date().toString() + " $message"
}

def queryString = { params ->
  params.collect { k,v -> "${URLEncoder.encode(k.toString(), charset)}=${URLEncoder.encode(v.toString(), charset)}" }.join('&')
}

def urlWithParams = { base, params ->
  params ? "${base}?${queryString(params)}" : base
}

def connect = { url ->
  def conn = new URL(url).openConnection();
  conn.setRequestProperty("Accept-Charset", charset);
  def headers, response
  try {
    (headers, response) = [conn.headerFields, conn.inputStream.text]
  } catch (java.net.UnknownHostException e) {
    // do nothing
  }
  return [headers, response]
}

def connectAndPrint = { url ->
  def (headers, response) = connect(url)
  log headers
  log response
  return [headers, response]
}

def convertToXhtml = { html ->
  def baos = new ByteArrayOutputStream()
  tidy.parse(new ByteArrayInputStream(html.getBytes(charset)), baos)
  return baos.toString(charset)
}

def exit = {
  log "something went wrong"
  System.exit(0)
}



// logic -------------------------------------------------------------------- \\

while (true) {
  // def (headers, response) = connectAndPrint('http://captive.apple.com/hotspot-detect.html', null)
  def (headers, response) = connect('http://captive.apple.com/hotspot-detect.html')
  def checkValue

  log "response=${response}"

  if (response) {
    checkValue = parser.parseText(convertToXhtml(response)).head.title
    log "checkValue=${checkValue}"
  }

  if (checkValue == 'Success') {
    log "Connection is up"
    sleep(3000)
  }

  if (checkValue != 'Success') {
    log "We're not connected anymore"

    // 'networksetup -setairportpower en0 off'.execute()
    // sleep(2000)
    // 'networksetup -setairportpower en0 on'.execute()
    // sleep(5000)
    // TODO: do not continue until wifi connection is verified

    // request hotspot detect page - if not success, continue
    (headers, response) = connect(urlWithParams('https://guestauth.baptisthealth.net/login.html', [redirect: 'captive.apple.com/hotspot-detect.html']))
    log "response='${response}'"
    
    def html = parser.parseText(convertToXhtml(response))
    log "html='${html}'"
    
    if (response) {
      checkValue = html.head.title
      log "checkValue='${checkValue}'"
    }

    if (checkValue == 'Success') {
      log "Connection is up"
      sleep(3000)
    }

    if (checkValue != 'Success') {
      // log html.meta.each { log "meta=${it.text()}" }

      exit()
    }

    // request refresh url and put it to xml

    // sleep(10000)
  }
}



// scratch ------------------------------------------------------------------ \\

// def response = '<HTML><HEAD><TITLE>Cisco Systems Inc. Web Authentication Redirect</TITLE><META http-equiv="Cache-control" content="no-cache"><META http-equiv="Pragma" content="no-cache"><META http-equiv="Expires" content="-1"><META http-equiv="refresh" content="1; URL=https://guestauth.baptisthealth.net/login.html?redirect=captive.apple.com/hotspot-detect.html"></HEAD></HTML>'
// def response = '<HTML><HEAD><TITLE>Success</TITLE></HEAD><BODY>Success</BODY></HTML>'

// connectAndPrint 'http://captive.apple.com/hotspot-detect.html', null

// connectAndPrint 'https://guestauth.baptisthealth.net/login.html', [redirect: 'captive.apple.com/hotspot-detect.html']

// [null:[HTTP/1.1 200 OK], Content-Length:[364], Content-Type:[text/html], Server:[HTTP Appgw]]
// <HTML><HEAD><TITLE>Cisco Systems Inc. Web Authentication Redirect</TITLE><META http-equiv="Cache-control" content="no-cache"><META http-equiv="Pragma" content="no-cache"><META http-equiv="Expires" content="-1"><META http-equiv="refresh" content="1; URL=https://guestauth.baptisthealth.net/login.html?redirect=captive.apple.com/hotspot-detect.html"></HEAD></HTML>

