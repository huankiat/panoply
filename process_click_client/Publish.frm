VERSION 5.00
Begin {C62A69F0-16DC-11CE-9E98-00AA00574A4F} Publish 
   Caption         =   "Publish Form"
   ClientHeight    =   2520
   ClientLeft      =   40
   ClientTop       =   -60
   ClientWidth     =   4580
   OleObjectBlob   =   "Publish.frx":0000
   StartUpPosition =   1  'CenterOwner
End
Attribute VB_Name = "Publish"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub CommandButton1_Click()
    Dim cellID As Long
    
    cellID = 0
    numName = UserForm2.TextBox1.text
    Call httpOut(numName, ActiveCell.Value, cellID)
    ActiveCell.Name = "Pub_" & cellID & "_" & numName
    UserForm2.Hide
End Sub
