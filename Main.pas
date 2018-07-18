unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OoMisc, AdPort, Menus, ActnList, ImgList, ExtCtrls,
  ComCtrls, ToolWin, TeeProcs, TeeStore, TeEngine, Chart, Series,
  TeeComma, StdCtrls, TeeScroB, Buttons, CheckLst, Math, RxCombos, TeeLisB,
  TeCanvas, TeeEdit, EditChar, TeeBezie, TeeFunci, TeeEdiSeri, Grids,
  TeeInspector, Filters, DBCtrls, DB, DBGrids, DateUtils,
  RXDBCtrl, RxMemDS, rxStrUtils, RXCtrls, cxStyles,
  cxCustomData, cxGraphics, cxFilter, cxData, cxDataStorage, cxEdit,
  cxDBData, cxNavigator, cxDBNavigator, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGridLevel, cxClasses, cxControls,
  cxGridCustomView, cxGrid, cxDBLookupComboBox, cxPropertiesStore,
  cxContainer, cxTextEdit, cxMemo, rxPlacemnt, cxSplitter,
  TeePreviewPanel, cxPC, cxLookAndFeelPainters, cxButtons, AdPacket, AdWnPort, dxmdaset,
  TeeNavigator, TeeChartGrid, cxMaskEdit,
  cxDropDownEdit, cxLabel, rxMRUList, TeeChartActions, cxSpinEdit, cxGroupBox,
  RXSpin, cxCheckBox, VclTee.TeeGDIPlus, cxLookAndFeels, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans,
  dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky,
  dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013White,
  dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp,
  dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  dxSkinscxPCPainter, dxBarBuiltInMenu, System.ImageList, System.Actions, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2016Colorful, dxSkinOffice2016Dark, dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark, dxSkinVisualStudio2013Light;

type
  TAutoSeriesTypes  = record
    Caption   : string;
    ClassName : string;

  end;


const
  INIT_CHART_CAPACITY = 10000;

    AutoSeriesTypes : array[0..8] of TAutoSeriesTypes =
    (
    (Caption:'Line';            ClassName: 'TLineSeries.Create'     ),
    (Caption:'Horizontal Line'; ClassName: 'THorizLineSeries'  ),
    (Caption:'Fast Line';       ClassName: 'TFastLineSeries' ),
    (Caption:'Bar';             ClassName: 'TBarSeries'  ),
    (Caption:'HorizBar';        ClassName: 'THorizBarSeries'  ),
    (Caption:'Area';            ClassName: 'TAreaSeries'  ),
    (Caption:'HorizArea';       ClassName: 'THorizAreaSeries'   ),
    (Caption:'Point';           ClassName: 'TPointSeries'  ),
    (Caption:'Bezier';          ClassName: 'TBezierSeries'  )
    );


type
  Tba  =  array of byte;
  Tpba = ^Tba;



  TfrmMain = class(TForm)
    ActionList1: TActionList;
    MainMenu1: TMainMenu;
    ComPort: TApdComPort;
    FormStorage1: TFormStorage;
    ImageList1: TImageList;
    actSetComPortOpt: TAction;
    Commportsettings1: TMenuItem;
    StatusBar: TStatusBar;
    ChartEditor: TChartEditor;
    PanelCenter: TPanel;
    PanelRight: TPanel;
    PanelTop: TPanel;
    PanelBottom: TPanel;
    cxSplitter1: TcxSplitter;
    ChartPreviewer: TChartPreviewer;
    TeeCommander1: TTeeCommander;
    PanelLeft: TPanel;
    cxSplitter2: TcxSplitter;
    PanelLeft_Top: TPanel;
    PanelLeft_Client: TPanel;
    ChartListBox: TChartListBox;
    actReceivingSettingsDialog: TAction;
    Datareceivingsettings1: TMenuItem;
    actStartStopReceiving: TAction;
    Settings1: TMenuItem;
    Graph1: TMenuItem;
    actClearAllSeries: TAction;
    Data_packet: TApdDataPacket;
    ApdWinsockPort1: TApdWinsockPort;
    actTestTerminal: TAction;
    actTestTerminal1: TMenuItem;
    cxPageControl2: TcxPageControl;
    cxtabProperty: TcxTabSheet;
    cxtabChartDataGrid: TcxTabSheet;
    ChartGrid1: TChartGrid;
    ChartGridNavigator1: TChartGridNavigator;
    pnlChartGrid_top: TPanel;
    cbAllowAppend: TCheckBox;
    cbAllowInsertSeries: TCheckBox;
    cbShowColors: TCheckBox;
    cbShowLAbels: TCheckBox;
    actFillSampleValues: TAction;

    ChartListBoxppMenu: TPopupMenu;
    Showedit: TMenuItem;
    Editseriesdatasource1: TMenuItem;
    Editseries1: TMenuItem;

    cbAutoSeriesType: TcxComboBox;
    cxLabel1: TcxLabel;
    Timer1: TTimer;
    actSaveChart: TAction;
    actLoadChart: TAction;
    MRUManager: TMRUManager;
    opdLoadChart: TOpenDialog;
    svdSaveChart: TSaveDialog;
    Loadchart1: TMenuItem;
    Savechart1: TMenuItem;
    actSeparateSeries: TAction;
    actClearChartData: TAction;
    Chart: TChart;
    Series1: TLineSeries;
    ChartActionGrid1: TChartActionGrid;
    ChartActionAxes1: TChartActionAxes;
    actSeparateVisibleSeries: TAction;
    ChartScrollBar1: TChartScrollBar;
    RxSpinButton1: TRxSpinButton;
    cxLabel2: TcxLabel;
    edXmin: TcxTextEdit;
    grpXscaling: TcxGroupBox;
    cxLabel3: TcxLabel;
    edXmax: TcxTextEdit;
    cxLabel4: TcxLabel;
    btnApplyXScale: TcxButton;
    btnAutomaticXScale: TcxButton;
    est1: TMenuItem;
    actTestDataStream: TAction;
    actTestDataStream1: TMenuItem;
    grpRecvWindow: TcxGroupBox;
    edWindowSize: TcxTextEdit;
    cxLabel5: TcxLabel;
    cbEnableWindow: TcxCheckBox;
    cxButton1: TcxButton;
    BitBtn1: TBitBtn;
    edTimeBase: TEdit;
    Label1: TLabel;
    cxbtnRecvStartStop: TButton;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    procedure actSetComPortOptExecute(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure FormStorage1RestorePlacement(Sender: TObject);
    procedure actReceivingSettingsDialogExecute(Sender: TObject);
    procedure actStartStopReceivingExecute(Sender: TObject);
    procedure actClearAllSeriesExecute(Sender: TObject);
    procedure actTestTerminalExecute(Sender: TObject);
    procedure FormStorage1SavePlacement(Sender: TObject);
    procedure Data_packetPacket(Sender: TObject; Data: Pointer; Size: Integer);
    procedure cbAllowAppendClick(Sender: TObject);
    procedure cbAllowInsertSeriesClick(Sender: TObject);
    procedure cbShowColorsClick(Sender: TObject);
    procedure cbShowLAbelsClick(Sender: TObject);
    procedure actFillSampleValuesExecute(Sender: TObject);
    procedure edTimeBaseExit(Sender: TObject);
    procedure Showedit1Click(Sender: TObject);
    procedure Editseriesdatasource1Click(Sender: TObject);
    procedure Editseries1Click(Sender: TObject);
    procedure Data_packetTimeout(Sender: TObject);
    procedure ComPortTriggerAvail(CP: TObject; Count: Word);
    procedure Timer1Timer(Sender: TObject);
    procedure actSaveChartExecute(Sender: TObject);
    procedure MRUManagerClick(Sender: TObject; const RecentName,
      Caption: string; UserData: Integer);
    procedure actLoadChartExecute(Sender: TObject);
    procedure PanelMiddleClick(Sender: TObject);
    procedure actSeparateSeriesExecute(Sender: TObject);
    procedure actClearChartDataExecute(Sender: TObject);
    procedure actSeparateVisibleSeriesExecute(Sender: TObject);
    procedure edTimeBaseChange(Sender: TObject);
    procedure ChartAfterDraw(Sender: TObject);
    procedure edXminPropertiesChange(Sender: TObject);
    procedure btnApplyXScaleClick(Sender: TObject);
    procedure btnAutomaticXScaleClick(Sender: TObject);
    procedure RxSpinButton1BottomClick(Sender: TObject);
    procedure RxSpinButton1TopClick(Sender: TObject);
    procedure actTestDataStreamExecute(Sender: TObject);
    procedure edWindowSizeExit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    receiving_in_progr: boolean;
    time_base         : double;
    delim_sym_str     : TCharSet;
    sampl_buf         : array of array of double; // Накапливающий буфер сэмплов для отправки в графики
    smpl_num          : integer;  // Количество сэмплов накопленное в буфере
    vals_num          : integer;  // Максимальное количество параметров обнаруженное в пакетах
    smplb_dim1        : integer;  // Текущая размерность 1 буфера сэмплов
    smplb_dim2        : integer;  // Текущая размерность 2 буфера сэмплов
    tmp_smpls         : array of double; // Промежуточный буфер сэмплов при обработке текущего пакета

    point_num         : integer;  // Количество точек выведеных на график

    two_delim_as_val  : boolean;
    receiv_byte_cnt   : integer;
    receiv_pack_cnt   : integer;

    time_base_chaged  : boolean;
    current_file_name : string;

    procedure ActivateAll(Sender: TObject);
    procedure ActivateComPort;
    procedure UpdateStatusBar;
    procedure SetStateStartStopButton;
    procedure AppendToChartNewSamples;
    procedure UpdateXminmax_edit;

  public
    procedure PrepareRecv;
  end;

var
  frmMain: TfrmMain;

implementation

uses ComPortSettings, AdPackEd, Terminal, Test_data_stream;
{$R *.dfm}


procedure TfrmMain.FormCreate(Sender: TObject);
var inifname:string;
    i : integer;
begin
  //DecimalSeparator := '.';
  receiving_in_progr := false;
  SetStateStartStopButton;
  inifname := ExtractFileName(Application.ExeName);
  inifname := ChangeFileExt(inifname, '.ini');
  FormStorage1.IniFileName:= ExtractFilePath(Application.ExeName)+ inifname;
  //ClearChart;
  TeeDefaultCapacity := INIT_CHART_CAPACITY;
  //ColorPalette[0] := clRed;
  //ColorPalette[1] := clBlue;
  //ColorPalette[2] := clPurple;
  //ColorPalette[3] := clGreen;
  //ColorPalette[4] := clNavy;
  //ColorPalette[5] := clTeal;
  time_base_chaged := False;

  //TeeUseMouseWheel := True;
  TeeCommander1.Panel := Chart;
  TeeCommander1.ChartEditor := ChartEditor;
  TeeCommander1.Previewer := ChartPreviewer;

  ChartEditor.Chart := Chart;
  ChartPreviewer.Chart := Chart;

  cbAllowAppendClick(self);
  cbAllowInsertSeriesClick(Self);
  cbShowColorsClick(Self);
  cbShowLAbelsClick(Self);
  smplb_dim1 := 100000;
  smplb_dim2 := 10;
  SetLength(sampl_buf, smplb_dim1, smplb_dim2);
  SetLength(tmp_smpls, smplb_dim2);
  vals_num := 0;
  time_base := StrToFloat(edTimeBase.Text);
  cbAutoSeriesType.Properties.Items.Clear;
  for i := 0 to Length(AutoSeriesTypes) - 1 do
  begin
    cbAutoSeriesType.Properties.Items.Add(AutoSeriesTypes[i].Caption);
  end;
  cbAutoSeriesType.ItemIndex := 0;

  actClearAllSeriesExecute(Self);
end;


procedure TfrmMain.FormStorage1RestorePlacement(Sender: TObject);
begin
  Data_packet.StartString := CtrlStrToStr(FormStorage1.StoredValue['PackedStartString']);
  Data_packet.EndString := CtrlStrToStr(FormStorage1.StoredValue['PackedEndString']);
  ActivateComPort;
  UpdateStatusBar;
end;



procedure TfrmMain.actLoadChartExecute(Sender: TObject);
begin
  if opdLoadChart.Execute=True then
  begin
    LoadChartFromFile( TCustomChart( Chart ), opdLoadChart.FileName );
    MRUManager.Add(opdLoadChart.FileName, 0);
    current_file_name := opdLoadChart.FileName;
  end;
end;

procedure TfrmMain.actReceivingSettingsDialogExecute(Sender: TObject);
begin
  if receiving_in_progr then
  begin
    ShowMessage('Receiving must be ended!');
    Abort;
  end;

  EditPacket( Data_packet,FormStorage1);

end;

procedure TfrmMain.actSaveChartExecute(Sender: TObject);
begin
  svdSaveChart.FileName := current_file_name;
  if svdSaveChart.Execute=True then
  begin
     SaveChartToFile(Chart, svdSaveChart.FileName);
     MRUManager.Add(svdSaveChart.FileName, 0);
     current_file_name := svdSaveChart.FileName;
  end;

end;

procedure TfrmMain.actSeparateSeriesExecute(Sender: TObject);
var
  i,n      : integer;
  axs      : TchartAxis;
begin
  n := Chart.CustomAxes.Count;

  for i:=0 to n-1 do
  begin
    axs := Chart.CustomAxes[i];
    axs.StartPosition := 100*i/n + 1;
    axs.EndPosition   := 100*(i+1)/n - 1
  end;
end;


procedure TfrmMain.actSeparateVisibleSeriesExecute(Sender: TObject);
var
  i,n,k    : integer;
  axs      : TChartAxis;
begin
  n := 0;
  for i:=0 to Chart.SeriesCount - 1 do
  begin
    if Chart.Series[i].Visible = true then inc(n);
  end;

  k := 0;
  for i:=0 to Chart.SeriesCount - 1 do
  begin
    if  Chart.Series[i].Visible = true then
    begin
      axs := Chart.Series[i].GetVertAxis;
      axs.StartPosition := 100*k/n + 1;
      axs.EndPosition   := 100*(k+1)/n - 1;
      inc(k);
    end;
  end;

end;

procedure TfrmMain.actSetComPortOptExecute(Sender: TObject);
begin
  if receiving_in_progr then
  begin
    ShowMessage('Receiving must be ended!');
    Abort;
  end;

  try
    with  TfrmComPortSettings.Create(Self) do
    begin
      APDComPort:= ComPort;
      try
        ShowModal;
      finally
        Free;
      end;
    end;
  finally
    UpdateStatusBar;
  end;
end;

procedure TfrmMain.actTestDataStreamExecute(Sender: TObject);
begin
  if receiving_in_progr then
  begin
    ShowMessage('Receiving must be ended!');
    Abort;
  end;

    with  TfrmTestDataStream.Create(Self) do
    begin
      Show;
    end;

end;

procedure TfrmMain.actTestTerminalExecute(Sender: TObject);
begin
  if receiving_in_progr then
  begin
    ShowMessage('Receiving must be ended!');
    Abort;
  end;

  try
    Self.Visible :=false;
    with  TfrmTestTerminal.Create(Self) do
    begin
      ComPort.OnTriggerAvail := Nil;
      StatusBar.Panels[0].text:=Self.StatusBar.Panels[0].text;
      ShowModal;
      Free;
    end;
  finally
    Self.Visible :=true;

  end;
end;


procedure TfrmMain.cbAllowAppendClick(Sender: TObject);
begin
  ChartGrid1.AllowAppend:=cbAllowAppend.Checked;
end;

procedure TfrmMain.cbAllowInsertSeriesClick(Sender: TObject);
begin
  ChartGrid1.AllowInsertSeries:=cbAllowInsertSeries.Checked;
end;

procedure TfrmMain.cbShowColorsClick(Sender: TObject);
begin
  ChartGrid1.ShowColors:=cbShowColors.Checked;
end;

procedure TfrmMain.cbShowLAbelsClick(Sender: TObject);
begin
  ChartGrid1.ShowLabels:=cbShowLabels.Checked;
end;

procedure TfrmMain.UpdateXminmax_edit;
begin
  edXmin.Text := format('%.4g',[Chart.BottomAxis.Minimum]);
  edXmax.Text := format('%.4g',[Chart.BottomAxis.Maximum]);
end;

procedure TfrmMain.btnApplyXScaleClick(Sender: TObject);
var  minf, maxf : extended;
begin
  minf := StrToFloat(edXmin.Text);
  maxf := StrToFloat(edXmax.Text);
  Chart.BottomAxis.Automatic := False;
  Chart.BottomAxis.Minimum := minf;
  Chart.BottomAxis.Maximum := maxf;
  Chart.Repaint;
  ChartScrollBar1.RecalcPosition;
end;


procedure TfrmMain.btnAutomaticXScaleClick(Sender: TObject);
begin
  Chart.BottomAxis.Automatic := True;
  Chart.Repaint;
  ChartScrollBar1.RecalcPosition;
end;


procedure TfrmMain.RxSpinButton1BottomClick(Sender: TObject);
var  minf, maxf : extended;
begin
  minf := Chart.BottomAxis.Minimum;
  maxf := Chart.BottomAxis.Maximum;

  maxf := minf + (maxf - minf)/2;

  Chart.BottomAxis.Automatic := False;
  Chart.BottomAxis.Minimum := minf;
  Chart.BottomAxis.Maximum := maxf;
  Chart.Repaint;
  ChartScrollBar1.RecalcPosition;
end;

procedure TfrmMain.RxSpinButton1TopClick(Sender: TObject);
var  minf, maxf : extended;
begin
  minf := Chart.BottomAxis.Minimum;
  maxf := Chart.BottomAxis.Maximum;

  maxf := minf + (maxf - minf)*2;

  Chart.BottomAxis.Automatic := False;
  Chart.BottomAxis.Minimum := minf;
  Chart.BottomAxis.Maximum := maxf;
  Chart.Repaint;
  ChartScrollBar1.RecalcPosition;
end;


procedure TfrmMain.ChartAfterDraw(Sender: TObject);
begin
  UpdateXminmax_edit;
end;


procedure TfrmMain.ComPortTriggerAvail(CP: TObject; Count: Word);
begin
  receiv_byte_cnt := receiv_byte_cnt + Count;
end;

procedure TfrmMain.SetStateStartStopButton;
begin
  if receiving_in_progr=True then
  begin
     cxbtnRecvStartStop.Caption := 'Stop receiving';
     cxbtnRecvStartStop.Font.Color := clRed;
     cxbtnRecvStartStop.ImageIndex := 56;
  end
  else
  begin
     cxbtnRecvStartStop.Caption := 'Start receiving';
     cxbtnRecvStartStop.Font.Color := clBlue;
     cxbtnRecvStartStop.ImageIndex := 55;
  end;
end;




procedure TfrmMain.Showedit1Click(Sender: TObject);
begin
  ChartListBox.ShowEditor;
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
  StatusBar.Panels[1].Text := 'Received bytes = ' +  IntToStr( receiv_byte_cnt) +
  ', Received packets = ' + IntToStr(receiv_pack_cnt);
  AppendToChartNewSamples;
end;

procedure TfrmMain.PrepareRecv;
var  str: string;
     i : integer;
begin
  // Проведем парсинг строки
  delim_sym_str := [];
  str := CtrlStrToStr(FormStorage1.StoredValue['DelimSymbols']);
  for i := 1 to Length(str) do
  begin
    delim_sym_str := delim_sym_str + [Chr(Ord(str[i]))];
  end;
  two_delim_as_val := FormStorage1.StoredValue['TwoDelimAsEmptVal'];

  receiv_byte_cnt := 0;
  receiv_pack_cnt := 0;
  point_num       := 0;
  time_base := StrToFloat(edTimeBase.Text);
end;

procedure TfrmMain.actStartStopReceivingExecute(Sender: TObject);
begin
  if receiving_in_progr=True then
  begin
    receiving_in_progr:=False;
    Data_packet.Enabled := False;
    ComPort.PutString(CtrlStrToStr(FormStorage1.StoredValue['DeactivatingStr'] ));
    ComPort.FlushOutBuffer;
    if FormStorage1.StoredValue['AutoCloseComport']=True then
    begin
      ComPort.Open:= False;
    end;
  end
  else
  begin
    if ComPort.Open = False then
    begin
      try
        ComPort.Open:= True;
      except
        ShowMessage('Comport not open!');
        UpdateStatusBar;
        Abort;
      end;
    end;
    PrepareRecv;
    receiving_in_progr  := True;
    ComPort.FlushInBuffer;
    Data_packet.Enabled := True;
    ComPort.PutString(CtrlStrToStr(FormStorage1.StoredValue['ActivatingStr'] ));
  end;
  SetStateStartStopButton;
  UpdateStatusBar;
end;




procedure TfrmMain.FormStorage1SavePlacement(Sender: TObject);
begin
  FormStorage1.StoredValues.SaveValues;
end;



procedure TfrmMain.MRUManagerClick(Sender: TObject; const RecentName,
  Caption: string; UserData: Integer);
begin
  LoadChartFromFile( TCustomChart( Chart ), RecentName);
  current_file_name := RecentName;
end;

procedure TfrmMain.PanelMiddleClick(Sender: TObject);
begin

end;


{-------------------------------------------------------------------------------
  Инициализация компонентов главного окна приложения по событию таймера
--------------------------------------------------------------------------------}
procedure TfrmMain.actClearAllSeriesExecute(Sender: TObject);
begin
  Chart.RemoveAllSeries;
  Chart.CustomAxes.Clear;

end;

procedure TfrmMain.actClearChartDataExecute(Sender: TObject);
var i : integer;
begin
  for i := 0 to Chart.SeriesCount - 1 do
  begin
    Chart.Series[i].Clear;

  end;
end;

procedure TfrmMain.actFillSampleValuesExecute(Sender: TObject);
begin
  Chart.SeriesList.FillSampleValues(1000);
end;

procedure TfrmMain.ActivateAll(Sender: TObject);
begin
  ActivateComPort;
  UpdateStatusBar;
end;




{-------------------------------------------------------------------------------
  Включаем COM порт
--------------------------------------------------------------------------------}
procedure TfrmMain.ActivateComPort;
var mstr:string;
begin
  try
    ComPort.Open:=true;
    if (ComPort.Open = false) then Abort;
  except
    mstr := 'It was not possible to open port Com'+IntToStr(ComPort.ComNumber)+ '. Do you want to change settings? ';
    if MessageDlg(mstr, mtError , [mbYes, mbNo], 0) = mrYes then
    begin
      actSetComPortOptExecute(Self);
    end;
  end;
end;




procedure TfrmMain.UpdateStatusBar;
var str,s:string;
begin
  with StatusBar do
  begin
    str:='Com'+IntToStr(ComPort.ComNumber);
    str:=str+' '+IntToStr(ComPort.Baud);
    str:=str+' '+IntToStr(ComPort.DataBits);
    case  ComPort.Parity of
    pNone:  s:='N';
    pOdd:   s:='O';
    pEven:  s:='E';
    pMark:  s:='M';
    pSpace: s:='S';
    end;
    str:=str+' '+s;
    str:=str+' '+IntToStr(ComPort.StopBits);

    if ComPort.Open then
      str:=str+'. Port open'
    else
      str:=str+'. Port close';
    panels[0].text:=str;
  end;
end;

procedure TfrmMain.Editseries1Click(Sender: TObject);
begin
  EditSeriesDialog(Self,ChartListBox.SelectedSeries);
end;

procedure TfrmMain.Editseriesdatasource1Click(Sender: TObject);
begin
  EditSeriesDataSource(Self,ChartListBox.SelectedSeries);
end;

procedure TfrmMain.edTimeBaseChange(Sender: TObject);
begin
  time_base_chaged := True;
end;

procedure TfrmMain.edTimeBaseExit(Sender: TObject);
var i,j: integer;
begin
  try
    time_base := StrToFloat(edTimeBase.Text);
    // Пересчитать метки у графиков

    if time_base_chaged = True then
    begin
      for i := 0 to Chart.SeriesCount - 1 do
      begin
        for j := 0 to Chart.Series[i].Count - 1 do
        begin
          Chart.Series[i].XValue[j] := j* time_base;
        end;
      end;
    end;

  except
    ShowMessage('Value is not a float point number!');
    edTimeBase.SetFocus;
  end;
  time_base_chaged := False;
end;



procedure TfrmMain.edWindowSizeExit(Sender: TObject);
var  val:double;
begin
  try
    val :=  StrToFloat(edWindowSize.text);
    if val <= 0 then
    begin
      ShowMessage('Null or negative value not valid!');
      edWindowSize.SetFocus;
    end;

  except
    edWindowSize.SetFocus;
  end;
end;

procedure TfrmMain.edXminPropertiesChange(Sender: TObject);
begin

end;

{-------------------------------------------------------------------------------

--------------------------------------------------------------------------------}
procedure TfrmMain.AppendToChartNewSamples;
var
    Series:TChartSeries;
    axis  : TChartAxis;
    i, j , n    : integer;

begin
  if smpl_num=0 then exit;

  while Chart.SeriesCount<vals_num do
  begin
    // Создать новый график
    case cbAutoSeriesType.ItemIndex of
    0:  Series := TLineSeries.Create(Chart);
    1:  Series := THorizLineSeries.Create(Chart);
    2:  Series := TFastLineSeries.Create(Chart);
    3:  Series := TBarSeries.Create(Chart);
    4:  Series := THorizBarSeries.Create(Chart);
    5:  Series := TAreaSeries.Create(Chart);
    6:  Series := THorizAreaSeries.Create(Chart);
    7:  Series := TPointSeries.Create(Chart);
    8:  Series := TBezierSeries.Create(Chart);
    else
      Series := TFastLineSeries.Create(Chart);
    end;

    axis := TChartAxis.Create(Chart);
    Series.CustomVertAxis := axis;
    Chart.AddSeries(Series);
  end;


  for i := 0 to vals_num - 1 do
  begin
    n :=  point_num;
    for j := 0 to smpl_num - 1 do
    begin
      Chart.Series[i].AddXY( n*time_base, sampl_buf[j][i]);
      inc(n);
    end;
  end;

  point_num := point_num +  smpl_num;

  if cbEnableWindow.Checked then
  begin
    Chart.BottomAxis.Automatic := False;
    Chart.BottomAxis.Minimum := point_num*time_base - StrToFloat(edWindowSize.Text);
    Chart.BottomAxis.Maximum := point_num*time_base;
  end
  else
  begin
    if Chart.BottomAxis.Automatic = False then
      Chart.BottomAxis.Automatic := True;
  end;
  

  //Chart.UndoZoom;
  //Chart.Series[i].repaint;

  smpl_num := 0;


end;


procedure TfrmMain.BitBtn1Click(Sender: TObject);
var i, j: integer;
begin

  for i := 0 to vals_num - 1 do
  begin
    for j := Chart.Series[i].Count-1 downto 0 do
    begin
      if (Chart.Series[i].XValue[j] < Chart.BottomAxis.Minimum) or
         (Chart.Series[i].XValue[j] > Chart.BottomAxis.Maximum)then
      begin

        Chart.Series[i].Delete(j);
      end;
    end;
  end;
end;

procedure TfrmMain.Data_packetTimeout(Sender: TObject);
begin
    Data_packet.Enabled := False;
    receiving_in_progr := False;
    SetStateStartStopButton;
    if FormStorage1.StoredValue['AutoCloseComport']=True then
    begin
      ComPort.Open:= False;
    end;

    ShowMessage('Receiving timeout!');
end;


{-------------------------------------------------------------------------------
  Прием пакета из порта
--------------------------------------------------------------------------------}
procedure TfrmMain.Data_packetPacket(Sender: TObject; Data: Pointer; Size: Integer);
var
  packstr     : string;
  tstr        : string;
  n , i , pos, plen    : integer;
  err           : boolean;

begin
  // Переносим данные в строку
 // packstr := Copy(PByte(Data), 0, Size - Length(Data_packet.EndString));


  SetString(packstr, PAnsiChar(Data),  Size - Length(Data_packet.EndString));

  plen:= Length(packstr);
  n   := 0;
  pos := 1;
  err := False;
  while True do
  begin
    tstr := '';
    while (pos <= plen)  do
    begin
      if packstr[pos] in delim_sym_str then
      begin
        inc(pos);
        if Length(tstr)<>0 then break;
        if two_delim_as_val = True then
        begin
          tstr := '0';
          break;
        end;
      end
      else
      begin
        tstr := tstr + packstr[pos];
        inc(pos);
      end;
    end;

    if Length(tstr)<>0 then
    begin
      try
        tmp_smpls[n] := StrToFloat(tstr) ;
      except
        err := True;
      end;
      if err=True then break;
      n := n + 1;
      if Length(tmp_smpls)<n  then SetLength(tmp_smpls, n);

    end
    else
      break;
  end;

  if err=False then
  begin

    if smplb_dim2<n then
    begin
      smplb_dim2 := n;
      SetLength(sampl_buf, smplb_dim1, smplb_dim2);
    end;
    for i:=0 to n-1 do sampl_buf[smpl_num][i] := tmp_smpls[i];

    inc(smpl_num);

    if smpl_num>smplb_dim1 then
    begin
      smplb_dim1 :=  smpl_num + 100;
      SetLength(sampl_buf, smplb_dim1, smplb_dim2);
    end;
    inc(receiv_pack_cnt);
    if vals_num<n then vals_num:=n;
    
  end;

end;




{-------------------------------------------------------------------------------
  Закрытие окна приложения
--------------------------------------------------------------------------------}
procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin

  ComPort.Open := false;
end;




end.


