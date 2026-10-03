Attribute VB_Name = "modSimulador"
Option Explicit

Public Sub RegistrarSimulacao()
    Dim wsSim As Worksheet
    Dim wsBanco As Worksheet
    Dim taxa As Variant
    Dim racional As String
    Dim usuario As String
    Dim proximaLinha As Long
    Dim novoID As Long

    Set wsSim = ThisWorkbook.Worksheets("Simulador_Escola")
    Set wsBanco = ThisWorkbook.Worksheets("Banco_de_Dados")

    taxa = wsSim.Range("C26").Value
    racional = Trim$(CStr(wsSim.Range("C25").Value))
    usuario = Trim$(CStr(wsSim.Range("C22").Value))

    If Not ValidarSimulacao(taxa, racional, usuario) Then Exit Sub

    proximaLinha = wsBanco.Cells(wsBanco.Rows.Count, "A").End(xlUp).Row + 1
    If proximaLinha < 5 Then proximaLinha = 5

    If proximaLinha = 5 Then
        novoID = 1
    Else
        novoID = Application.WorksheetFunction.Max(wsBanco.Range("A5:A" & proximaLinha - 1)) + 1
    End If

    With wsBanco
        .Cells(proximaLinha, "A").Value = novoID
        .Cells(proximaLinha, "B").Value = Now
        .Cells(proximaLinha, "B").NumberFormat = "dd/mm/yyyy hh:mm"
        .Cells(proximaLinha, "C").Value = CDbl(taxa)
        .Cells(proximaLinha, "C").NumberFormat = "0.0%"
        .Cells(proximaLinha, "D").Value = racional
        .Cells(proximaLinha, "E").Value = wsSim.Range("C35").Value
        .Cells(proximaLinha, "F").Value = wsSim.Range("D35").Value
        .Cells(proximaLinha, "F").NumberFormat = "R$ #,##0.00"
        .Cells(proximaLinha, "G").Value = usuario
    End With

    LimparCampos
    MsgBox "Simulação registrada com sucesso.", vbInformation
End Sub

Private Function ValidarSimulacao(ByVal taxa As Variant, ByVal racional As String, ByVal usuario As String) As Boolean
    If IsError(taxa) Then
        MsgBox "O Fator de Ajuste precisa ser numérico.", vbExclamation
        Exit Function
    End If

    If Len(Trim$(CStr(taxa))) = 0 Or Not IsNumeric(taxa) Then
        MsgBox "O Fator de Ajuste precisa ser numérico.", vbExclamation
        Exit Function
    End If

    If Len(racional) = 0 Then
        MsgBox "Informe o racional da taxa antes de registrar a simulação.", vbExclamation
        Exit Function
    End If

    If Len(usuario) = 0 Then
        MsgBox "Informe o Usuário da Simulação antes de registrar.", vbExclamation
        Exit Function
    End If

    ValidarSimulacao = True
End Function

Private Sub LimparCampos()
    With ThisWorkbook.Worksheets("Simulador_Escola")
        .Range("C22").ClearContents
        .Range("C25").ClearContents
        .Range("C26").ClearContents
    End With
End Sub
