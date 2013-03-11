Attribute VB_Name = "Module2"
Sub AddToCellMenu()
    Dim ContextMenu As CommandBar
    Dim MySubMenu As CommandBarControl
    Dim array_int As Long
    
    
    AllChannels = channelRetrieve
    array_size = UBound(AllChannels, 2)
    
    Application.CommandBars("Cell").Reset
    
    
    ' Delete the controls first to avoid duplicates.
    Call DeleteFromCellMenu

    ' Set ContextMenu to the Cell context menu.
    Set ContextMenu = Application.CommandBars("Cell")
    
    ' Add Publish to first menu
    With ContextMenu.Controls.Add(Type:=msoControlButton, before:=1)
        .OnAction = "ShowForm2"
        .FaceId = 4169
        .Caption = "Publish New"
        .Tag = "My_Publish_Tag"
    End With
     ' Subscript Existing Channels
    Set MySubMenu = ContextMenu.Controls.Add(Type:=msoControlPopup, before:=2)
    
    With MySubMenu
        .Caption = "Subscribe"
        .Tag = "My_Publish_Tag"
        
            For array_int = LBound(AllChannels, 1) To array_size
                channel = CInt(AllChannels(0, array_int))
                With .Controls.Add(Type:=msoControlButton)
                    .OnAction = "valRetrieve(" & channel & ")"
                    .FaceId = 487
                    .Caption = AllChannels(0, array_int) & "-" & AllChannels(1, array_int)
                End With
            Next
        
    End With
    ' Republish Existing Channels
    Set MySubMenu = ContextMenu.Controls.Add(Type:=msoControlPopup, before:=3)
    
    With MySubMenu
        .Caption = "RePublish"
        .Tag = "My_Publish_Tag"
        
            For array_int = LBound(AllChannels, 1) To array_size
                channel = CInt(AllChannels(0, array_int))
                With .Controls.Add(Type:=msoControlButton)
                    .OnAction = " 'ShowForm3 " & """" & Replace(str(AllChannels(0, array_int)), " ", "") & """" & "," & """" & AllChannels(1, array_int) & """" & "'"
                    .FaceId = 487
                    .Caption = AllChannels(0, array_int) & "-" & AllChannels(1, array_int)
                End With
            Next
        
    End With
    
    With ContextMenu.Controls.Add(Type:=msoControlButton, before:=4)
        .OnAction = "RefreshCell()"
        .FaceId = 37
        .Caption = "Refresh Data"
        .Tag = "My_Publish_Tag"
    End With
    
   


    ' Add a separator to the Cell context menu.
    ContextMenu.Controls(5).BeginGroup = True
End Sub

Sub DeleteFromCellMenu()
    Dim ContextMenu As CommandBar
    Dim ctrl As CommandBarControl

    ' Set ContextMenu to the Cell context menu.
    Set ContextMenu = Application.CommandBars("Cell")

    ' Delete the custom controls with the Tag : My_Cell_Control_Tag.
    For Each ctrl In ContextMenu.Controls
        If ctrl.Tag = "My_Publish_Tag" Then
            ctrl.Delete
        End If
    Next ctrl

    ' Delete the custom built-in Save button.
    'On Error Resume Next
    'ContextMenu.FindControl(Id:=3).Delete
    'On Error GoTo 0
End Sub

Sub RePublishCell(ByVal channelID As String, ByVal channelDes As String)
    'Republish cells
    
    ActiveCell.Name = "Pub_" & channelID & "_" & channelDes
    
End Sub

Sub RefreshCell()
    Dim nm As Name
    Dim str() As String
    Dim val As Double
    Dim output As String
    
    For Each nm In ActiveWorkbook.Names
        str = Split(nm.Name, "_")
        If str(0) = "Sub" Then
            Range(nm.Value).Value = subRefresh(str(1))
        End If
        If str(0) = "Pub" Then
            Value = Range(nm.Value).Value
            output = pubRefresh(str(1), str(2), Value)
        End If
        
    Next nm
    Call AddToCellMenu
    
End Sub


Sub ShowForm()
    UserForm1.Show
    
End Sub

Sub ShowForm2()
    Publish.Show
End Sub

Sub ShowForm3(ByVal channelID As String, ByVal channelDes As String)

    RePublishForm.Label2 = channelID
    RePublishForm.Label3 = channelDes
    RePublishForm.Show
    
End Sub
