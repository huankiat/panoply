VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} RePublishForm 
   Caption         =   "RePublish"
   ClientHeight    =   3180
   ClientLeft      =   40
   ClientTop       =   -60
   ClientWidth     =   4720
   OleObjectBlob   =   "RePublishForm.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "RePublishForm"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Send_Click()
    Call RePublishCell(Label2.Caption, Label3.Caption)
    ActiveCell.Value = TextBox1.Value
    Call RefreshCell
    RePublishForm.Hide
    
End Sub
