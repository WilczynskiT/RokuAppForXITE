sub init()
  m.top.functionName = "sendRequest"
end sub

sub sendRequest()
  m.top.observeField("data", "mapData")
  m.top.observeField("jsonResponse", "onJsonResponse")
  http = createObject("roUrlTransfer")
  http.RetainBodyOnError(true)
  port = createObject("roMessagePort")
  http.setPort(port)
  http.setCertificatesFile("common:/certs/ca-bundle.crt")
  http.InitClientCertificates()
  http.enablehostverification(false)
  http.enablepeerverification(false)
  http.setUrl(m.top.url)
  if http.AsyncGetToString() Then
    msg = wait(10000, port)
    if (type(msg) = "roUrlEvent")
      if (msg.getresponsecode() > 0 and  msg.getresponsecode() < 400)
        m.top.jsonResponse = msg.getstring()
      end if
      http.asynccancel()
    else if (msg = invalid)
      ? "request fail"
      http.asynccancel()
    end if
  end if
end sub

sub onJsonResponse(event)
  response = event.getData()
  data = parseJSON(response)
  m.top.data = data
end sub

function returnString(title as object) as string
  if type(title) = "Integer" or type(title) = "roInt" 
    return Str(title)
  end if
  return title
end function

function isShouldAdd(title as object) as boolean
  stringTitle = returnString(title)
  return m.top.searchText = "" or Instr(1, LCase(stringTitle), LCase(m.top.searchText)) <> 0
end function

function setGenre(id as integer) as string
  newGenre = m.genreDict[Str(id)]
  if newGenre <> invalid then return newGenre
  return ""
end function

sub mapData()
  m.genreDict = createGenreDictionary()
  mappedData = []
  for each item in m.top.data.videos
      if isShouldAdd(item.title)
        singleObject = CreateObject("roAssociativeArray")
        singleObject["title"] = returnString(item.title)
        singleObject["cover"] = item.image_url
        singleObject["genre"] = setGenre(item.genre_id)
        singleObject["artist"] = item.artist
        singleObject["year"] = item.release_year
        singleObject["id"] = item.id
        mappedData.push(singleObject)
        end if
    end for
  m.top.mappedData = mappedData
end sub

function createGenreDictionary()
  dict = {}
  for each item in m.top.data.genres
      dict[Str(item.id)] = item.name
  end for
  return dict
end function
