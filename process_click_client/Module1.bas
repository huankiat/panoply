Attribute VB_Name = "Module1"
Sub httpOut(ByVal cellName As String, ByVal cellNumber As Double, ByRef cellID As Long)
    'POST end point
    Dim jsonStr As String
    
    jsonStr = "{""channel"":{""description"":" & """" & cellName & """" & ", ""value"":" & cellNumber & "}}"
    
    Set objHTTP = CreateObject("MSXML2.ServerXMLHTTP")
    
    
    URL = "http://panoply-staging.herokuapp.com/api/channels.json"
    objHTTP.Open "POST", URL, False
    objHTTP.setRequestHeader "Accept", "application/json"
    objHTTP.setRequestHeader "Content-type", "application/json"

    objHTTP.Send (jsonStr)
    Dim responseArray() As String
    
    responseArray = Split(objHTTP.responseText, ",")
    cellID = Mid(responseArray(0), 7)
    
    
End Sub

Function channelRetrieve() As Variant
    'GET end point (full list of channels)
    
    Dim jsonStr As String
    Dim JSON_array() As String
    
    Set objHTTP = CreateObject("MSXML2.ServerXMLHTTP")
    
    'send to url to retrieve all channels available
    URL = "http://panoply-staging.herokuapp.com/api/channels.json"
    objHTTP.Open "GET", URL, False
    objHTTP.setRequestHeader "Accept", "application/json"
    objHTTP.setRequestHeader "Content-type", "application/json"
    objHTTP.Send ("")
    
    jsonStr = objHTTP.responseText
    
    JSON_array = parseJSON(jsonStr)
    channelRetrieve = JSON_array
    
End Function

Function valRetrieve(ByVal channelID As Integer) As Double
    'GET end point - value retrieval for a channel
    
    Dim jsonStr As String
    Dim JSON_array() As String
    
    Set objHTTP = CreateObject("MSXML2.ServerXMLHTTP")
    
    'send to url to retrieve all channels available
    channelStr = CStr(channelID)
    URL = "http://panoply-staging.herokuapp.com/api/channels/" & channelStr & ".json"
    objHTTP.Open "GET", URL, False
    objHTTP.setRequestHeader "Accept", "application/json"
    objHTTP.setRequestHeader "Content-type", "application/json"
    objHTTP.Send ("")
    
    jsonStr = objHTTP.responseText
    
    valRetrieve = parseValJSON(jsonStr)
    ActiveCell.Name = "Sub_" & parseIDJSON(jsonStr) & "_" & parseDesJSON(jsonStr)
    ActiveCell.Value = parseValJSON(jsonStr)
    
    
End Function


Function parseJSON(ByRef jsonStr As String) As Variant
    'Parse the JSON return for all channels into array
    
    Dim jsonTruncate As String
    Dim totalLen As Long
    Dim intIndex As Integer
    Dim parseJSON_int() As String
    Dim searchStr As String
    
    searchStr = "description"
    
    totalLen = Len(jsonStr)
    jsonTruncate = Mid(jsonStr, 15, totalLen - 17)
    parseJSON_int = Split(jsonTruncate, "},{")
    
    Dim parseJSON_final() As String
    array_size = UBound(parseJSON_int)
    ReDim parseJSON_final(2, array_size)
    
    'Get descriptions objects from JSON
    For intIndex = LBound(parseJSON_int) To UBound(parseJSON_int)
        Dim start_num As Long
        Dim end_num As Long
        
        start_num = InStr(1, parseJSON_int(intIndex), searchStr) + Len(searchStr) + 3
        end_num = Len(parseJSON_int(intIndex))
        id_length = InStr(1, parseJSON_int(intIndex), searchStr) - 8 '8 being the totallength+1 of "id":,"
        
        'Parse descriptions
        parseJSON_final(1, intIndex) = Mid(parseJSON_int(intIndex), start_num, end_num - start_num)
        'Parse ID
        parseJSON_final(0, intIndex) = Mid(parseJSON_int(intIndex), 6, id_length)
    Next
    
    
    parseJSON = parseJSON_final
    
End Function
Function parseValJSON(ByRef jsonStr As String) As Double
    'Parse the JSON return for all channels into array
    
    Dim jsonTruncate As String
    Dim totalLen As Long
    Dim intIndex As Integer
    Dim parseJSON_int() As String
    Dim searchStr_01 As String
    Dim searchStr_02 As String
    
    searchStr_01 = "description"
    searchStr_02 = "value"
    
    totalLen = Len(jsonStr)
    jsonTruncate = Mid(jsonStr, 13, totalLen - 14)
    parseJSON_int = Split(jsonTruncate, ",")
    If Len(parseJSON_int(2)) > 9 Then
        parseValJSON = Mid(parseJSON_int(2), 9)
    Else
        parseValJSON = 10
    End If
    
End Function
Function parseDesJSON(ByRef jsonStr As String) As String
    'Parse the JSON return for all channels into array
    
    Dim jsonTruncate As String
    Dim totalLen As Long
    Dim intIndex As Integer
    Dim parseJSON_int() As String
    Dim searchStr_01 As String
    Dim searchStr_02 As String
    
    searchStr_01 = "description"
    searchStr_02 = "value"
    
    totalLen = Len(jsonStr)
    jsonTruncate = Mid(jsonStr, 13, totalLen - 14)
    parseJSON_int = Split(jsonTruncate, ",")
    
    parseDesJSON = Mid(parseJSON_int(1), Len(searchStr_01) + 5, Len(parseJSON_int(1)) - Len(searchStr_01) - 5)
    
End Function
Function parseIDJSON(ByRef jsonStr As String) As String
    'Parse the JSON return for all channels into array
    
    Dim jsonTruncate As String
    Dim totalLen As Long
    Dim intIndex As Integer
    Dim parseJSON_int() As String
       
    totalLen = Len(jsonStr)
    jsonTruncate = Mid(jsonStr, 13, totalLen - 14)
    parseJSON_int = Split(jsonTruncate, ",")
    
    parseIDJSON = Mid(parseJSON_int(0), 6)
    
End Function

Function subRefresh(ByVal channelID As Integer) As Double

    Dim jsonStr As String
    Dim JSON_array() As String
    
    Set objHTTP = CreateObject("MSXML2.ServerXMLHTTP")
    
    'send to url to retrieve all channels available
    channelStr = CStr(channelID)
    URL = "http://panoply-staging.herokuapp.com/api/channels/" & channelStr & ".json"
    objHTTP.Open "GET", URL, False
    objHTTP.setRequestHeader "Accept", "application/json"
    objHTTP.setRequestHeader "Content-type", "application/json"
    objHTTP.Send ("")
    
    jsonStr = objHTTP.responseText
    
    subRefresh = parseValJSON(jsonStr)
    
    
    
End Function
Function pubRefresh(ByVal cellID As Long, ByVal cellDes As String, ByVal cellVal As Double) As String
    Dim jsonStr As String
    
    jsonStr = "{""channel"":{""id"":" & cellID & ", ""description"":" & """" & cellDes & """" & ", ""value"":" & cellVal & "}}"
    
    Set objHTTP = CreateObject("MSXML2.ServerXMLHTTP")
    
    
    URL = "http://panoply-staging.herokuapp.com/api/channels/" & cellID & ".json"
    objHTTP.Open "PUT", URL, False
    objHTTP.setRequestHeader "Accept", "application/json"
    objHTTP.setRequestHeader "Content-type", "application/json"

    objHTTP.Send (jsonStr)
    
    pubRefresh = objHTTP.responseText
    
    
End Function



