Attribute VB_Name = "modRegistrarSimulacao"
Option Explicit

Public Sub RegistrarSimulacao()
    Dim wsTela As Worksheet, wsBanco As Worksheet
    Dim usuario As String, racional As String
    Dim taxa As Variant, proxLinha As Long, novoID As Long
    Dim ultimaLinhaID As Long

    Set wsTela = ThisWorkbook.Worksheets("Simulador_Escola")
    Set wsBanco = ThisWorkbook.Worksheets("Banco_de_Dados")

    usuario = Trim$(CStr(wsTela.Range("B22").Value))
    racional = Trim$(CStr(wsTela.Range("C25").Value))
    taxa = wsTela.Range("C26").Value

    If Not ValidarSimulacao(usuario, racional, taxa) Then Exit Sub

    Application.Calculate
    proxLinha = wsBanco.Cells(wsBanco.Rows.Count, "A").End(xlUp).Row + 1
    If proxLinha < 4 Then proxLinha = 4
    ultimaLinhaID = proxLinha - 1
    If ultimaLinhaID < 4 Then
        novoID = 1
    ElseIf Application.WorksheetFunction.Count(wsBanco.Range("A4:A" & ultimaLinhaID)) = 0 Then
        novoID = 1
    Else
        novoID = Application.WorksheetFunction.Max(wsBanco.Range("A4:A" & ultimaLinhaID)) + 1
    End If

    With wsBanco
        .Cells(proxLinha, "A").Value = novoID
        .Cells(proxLinha, "B").Value = Now
        .Cells(proxLinha, "C").Value = CDbl(taxa)
        .Cells(proxLinha, "D").Value = racional
        .Cells(proxLinha, "E").Value = wsTela.Range("C35").Value
        .Cells(proxLinha, "F").Value = wsTela.Range("D35").Value
        .Cells(proxLinha, "G").Value = usuario
        .Cells(proxLinha, "B").NumberFormat = "dd/mm/yyyy hh:mm:ss"
        .Cells(proxLinha, "C").NumberFormat = "0.00%"
        .Cells(proxLinha, "F").NumberFormat = "R$ #,##0.00"
    End With

    LimparCampos
    MsgBox "Simulação registrada com sucesso.", vbInformation, "Projeto 1 — PNAE"
End Sub

Private Function ValidarSimulacao(ByVal usuario As String, ByVal racional As String, ByVal taxa As Variant) As Boolean
    ValidarSimulacao = False
    If Len(usuario) = 0 Then
        MsgBox "Informe o usuário responsável pela simulação.", vbExclamation, "Campo obrigatório"
        Exit Function
    End If
    If Len(racional) = 0 Then
        MsgBox "Informe o racional do fator de ajuste.", vbExclamation, "Campo obrigatório"
        Exit Function
    End If
    If IsError(taxa) Or Not IsNumeric(taxa) Then
        MsgBox "Informe um fator de ajuste numérico.", vbExclamation, "Valor inválido"
        Exit Function
    End If
    ValidarSimulacao = True
End Function

Private Sub LimparCampos()
    With ThisWorkbook.Worksheets("Simulador_Escola")
        .Range("B22").ClearContents
        .Range("C25").ClearContents
        .Range("C26").ClearContents
    End With
End Sub
