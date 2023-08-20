Attribute VB_Name = "Module1"
Sub StockAnalysis()

'Declare variables required for the summary tables to populate on each worksheet.
Dim ws As Worksheet

Dim ticker As String
Dim yearly_change As Double
Dim perc_change As Long
Dim stock_vol As Double
Dim tot_stock_vol As Double

Dim open_price As Double
Dim close_price As Double

Dim gr8_perc_inc As Double
Dim gr8_perc_dec As Double
Dim gr8_tot_vol As Double
Dim gr8_tot_vol_ticker As Double

Dim max_ticker As String
Dim max_value As Double

Dim min_ticker As String
Dim min_value As Double

'Set ws = ThisWorkbook.sheets("ws")
For Each ws In Worksheets

'Print 'header row' for summary table
ws.Cells(1, 9).Value = "Ticker"
ws.Cells(1, 10).Value = "Yearly Change"
ws.Cells(1, 11).Value = "Percentage Change"
ws.Cells(1, 12).Value = "Total Stock Volume"

'Set for loop variables
Dim i As Double
Dim j As Double



'Print headings for summary calculations table
ws.Cells(1, 16).Value = "Ticker"
ws.Cells(1, 17).Value = "Value"
ws.Cells(2, 15).Value = "Greatest % Increase"
ws.Cells(3, 15).Value = "Greatest % Decrease"
ws.Cells(4, 15).Value = "Greatest Total Volume"
                                                                          

                                                                          
    'Populate Summary Tables:
                                                                          
    'Define initial variables required to populate summary table
    Dim lastrow As Long
        'lastrow = ActiveSheet.UsedRange.Rows(ActiveSheet.UsedRange.Rows.Count).Row
        lastrow = ws.Cells(Rows.Count, 1).End(xlUp).Row
    
    Dim Summary_Table_Row As Long
        Summary_Table_Row = 2
    tot_stock_vol = 0
    open_price = ws.Cells(2, 3).Value
    
    'For Loop to create summary table
    For i = 2 To lastrow
           close_price = ws.Cells(i, 6).Value
          
           
            'Loop through <ticker> column to retrieve unique values
            If ws.Cells(i + 1, 1).Value <> ws.Cells(i, 1).Value Then
            
            'If the <ticker> changes, do this
            ticker = ws.Cells(i, 1).Value
            
            'Calculate yearly change
            yearly_change = close_price - open_price
            
            
            
            
            'Print each unique <ticker>  value in column I
            ws.Cells(Summary_Table_Row, 9).Value = ticker
            
        
            'Print each Yearly Change value in column J
            ws.Cells(Summary_Table_Row, 10).Value = yearly_change
            
                'Conditional colour formatting to reflect +/- Yearly Change values
                If yearly_change > 0 Then
                ws.Cells(Summary_Table_Row, 10).Interior.ColorIndex = 4
                
                ElseIf yearly_change < 0 Then
                ws.Cells(Summary_Table_Row, 10).Interior.ColorIndex = 3
                
                End If
        
        
        
            'Calculate Percentage Change
            If yearly_change = 0 Or open_price = 0 Then
                ws.Cells(Summary_Table_Row, 11).Value = 0
            
            Else
                ws.Cells(Summary_Table_Row, 11).Value = Format(yearly_change / open_price, "#.##%")
            
            End If
            
            
            
            'Calculate the Total Stock Volume
            tot_stock_vol = tot_stock_vol + ws.Cells(i, 7).Value
            
            'Print each Total Stock Volume value in column L
            ws.Cells(Summary_Table_Row, 12).Value = tot_stock_vol
           
            
        
            'Reset variables and go to next <ticker>
            Summary_Table_Row = Summary_Table_Row + 1
            tot_stock_vol = 0
            End If
           
    Next i
    
        'Greatest % Increase & Greatest % Decreaase values
        ws.Cells(2, 17).Value = Application.WorksheetFunction.Max(ws.Range("K2:K" & Summary_Table_Row - 1))
        ws.Cells(3, 17).Value = Application.WorksheetFunction.Min(ws.Range("K2:K" & Summary_Table_Row - 1))
        ws.Cells(4, 17).Value = Application.WorksheetFunction.Max(ws.Range("L2:L" & Summary_Table_Row - 1))
    
        'Greatest % Increase
        'ws.Cells(2, 16).Value =
        
        'Greatest % Decrease
        'ws.Cells(2, 16).Value =
        
        'Greatest Total Volume
        'ws.Cells(2, 16).Value =
    
        'Autofit columns for clear visibility
        ws.Cells.EntireColumn.AutoFit
        
    Next
    
        
  
  
End Sub


