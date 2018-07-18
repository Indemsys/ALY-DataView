unit ComPortSettings;

interface

uses

  Windows,
  SysUtils, Messages,
  Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, StdCtrls, AdPort, OoMisc, AdTSel, Mask,
  rxPlacemnt, rxToolEdit;

type
  TfrmComPortSettings = class(TForm)
    GroupBox2: TGroupBox;
    Label4: TLabel;
    fedLogFileName: TFilenameEdit;
    edLogSize: TEdit;
    Label5: TLabel;
    rgrLogMode: TRadioGroup;
    FormStorage1: TFormStorage;
    cbLoggingHEX: TCheckBox;
    btnLogClear: TButton;
    btnLogDump: TButton;
    btnLogAppend: TButton;
    btnApply: TButton;
    cbLoggingAllHEX: TCheckBox;
    GroupBox3: TGroupBox;
    Label3: TLabel;
    Label6: TLabel;
    fedTraceFileName: TFilenameEdit;
    edTraceSize: TEdit;
    rgrTraceMode: TRadioGroup;
    cbTraceHEX: TCheckBox;
    btnTraceClear: TButton;
    btnTraceDump: TButton;
    btnTraceAppend: TButton;
    cbTraceAllHEX: TCheckBox;
    procedure rgrLogModeClick(Sender: TObject);
    procedure rgrTraceModeClick(Sender: TObject);    
    procedure cbLoggingHEXClick(Sender: TObject);
    procedure btnLogClearClick(Sender: TObject);
    procedure btnLogDumpClick(Sender: TObject);
    procedure btnLogAppendClick(Sender: TObject);
    procedure cbLoggingAllHEXClick(Sender: TObject);
    procedure cbTraceHEXClick(Sender: TObject);
    procedure cbTraceAllHEXClick(Sender: TObject);
    procedure btnTraceClearClick(Sender: TObject);
    procedure btnTraceAppendClick(Sender: TObject);
    procedure btnTraceDumpClick(Sender: TObject);
  private
    fComPort:TApdComPort;
    procedure SetComPort(value :TApdComPort);

  published
    FlowControlBox: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    DTRRTS: TCheckBox;
    RTSCTS: TCheckBox;
    SoftwareXmit: TCheckBox;
    SoftwareRcv: TCheckBox;
    Edit1: TEdit;
    Edit2: TEdit;
    Paritys: TRadioGroup;
    Databits: TRadioGroup;
    Stopbits: TRadioGroup;
    Comports: TGroupBox;
    btnOK: TButton;
    btnCancel: TButton;
    PortComboBox: TComboBox;
    GroupBox1: TGroupBox;
    cbxBaud: TComboBox;
    rgrDTR: TRadioGroup;
    rgrRTS: TRadioGroup;
    property  APDComPort: TApdComPort read fComPort write SetComPort;
    procedure btnApplyClick(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure PortComboBoxChange(Sender: TObject);
    procedure StateLogging;
    procedure StateTracing;
  public


  end;

var
  frmComPortSettings: TfrmComPortSettings;

implementation

{$R *.dfm}


const
  BaudValues : array[0..9] of Word =
    (30, 60, 120, 240, 480, 960, 1920, 3840, 5760, 11520);



procedure TfrmComPortSettings.SetComPort(value :TApdComPort);
var
  E : TDeviceSelectionForm;
Const BoolArray : array [false..true] of byte = (1, 0);
begin
  fComPort:=value;

  {Gather all tapi devices and ports}
  E := TDeviceSelectionForm.Create(Self);
  try
    E.EnumComPorts;
    PortComboBox.Items := E.PortItemList;
  finally;
    E.Free;
  end;

 { Highlite the active device in the list }
  with PortComboBox do
    if (fComPort.TapiMode = tmOff) or (fComPort.TapiMode = tmAuto) then begin
      ItemIndex := Items.IndexOf(DirectTo+IntToStr(fComPort.ComNumber));
    end;
  rgrDTR.ItemIndex:=BoolArray[fComPort.DTR];
  rgrRTS.ItemIndex:=BoolArray[fComPort.RTS];
  cbxBaud.Text:=IntToStr(fComPort.Baud);
  Paritys.ItemIndex := Ord(fComPort.Parity);
  Databits.ItemIndex := 8-fComPort.Databits;
  Stopbits.ItemIndex := Pred(fComPort.Stopbits);

  {Hardware flow}
  DTRRTS.Checked := hwfUseDTR in fComPort.HWFlowOptions;
  RTSCTS.Checked := hwfUseRTS in fComPort.HWFlowOptions;

  {Software flow}
  SoftwareXmit.Checked := (fComPort.SWFlowOptions = swfBoth) or
                          (fComPort.SWFlowOptions = swfTransmit);
  SoftwareRcv.Checked := (fComPort.SWFlowOptions = swfBoth) or
                         (fComPort.SWFlowOptions  = swfReceive);
  Edit1.Text := IntToStr(Ord(fComPort.XOnChar));
  Edit2.Text := IntToStr(Ord(fComPort.XOffChar));

  StateLogging;
  StateTracing;
end;

procedure TfrmComPortSettings.rgrLogModeClick(Sender: TObject);
var n:integer;
begin
  try
    n := StrToInt(edLogSize.text);
  finally

  end;
  if fedLogFileName.FileName <> '' then
  begin
    case rgrLogMode.ItemIndex of
    0:  begin
          fComPort.logging := tlOff;
        end;
    1:  begin
          fComPort.LogSize := n;
          fComPort.LogName := fedLogFileName.FileName;
          fComPort.logging := tlOn;
        end;
    2:  begin
          fComPort.logging := tlPause;
        end;
    end;
  end;
  StateLogging;
end;

procedure TfrmComPortSettings.btnLogClearClick(Sender: TObject);
begin
  fComPort.LogName := fedLogFileName.FileName;
  fComPort.logging := tlClear;
  StateLogging;
end;

procedure TfrmComPortSettings.btnLogDumpClick(Sender: TObject);
begin
  fComPort.LogName := fedLogFileName.FileName;
  fComPort.logging := tlDump;
  StateLogging;
end;

procedure TfrmComPortSettings.btnLogAppendClick(Sender: TObject);
begin
  fComPort.LogName := fedLogFileName.FileName;
  fComPort.logging := tlAppend;
  StateLogging;
end;


procedure TfrmComPortSettings.cbLoggingHEXClick(Sender: TObject);
begin
  fComPort.LogHex := cbLoggingHEX.Checked;
end;

procedure TfrmComPortSettings.cbLoggingAllHEXClick(Sender: TObject);
begin
  fComPort.LogAllHex := cbLoggingAllHEX.Checked;
end;


procedure TfrmComPortSettings.StateLogging;
begin
  case fComPort.logging   of
  tlOff:   begin
            rgrLogMode.ItemIndex  := 0;
            btnLogAppend.Enabled  := false;
            btnLogClear.Enabled   := false;
            btnLogDump.Enabled    := false;
           end;
  tlOn:    begin
            rgrLogMode.ItemIndex  := 1;
            btnLogAppend.Enabled  := true;
            btnLogClear.Enabled   := true;
            btnLogDump.Enabled    := true;
           end;
  tlPause: begin
            rgrLogMode.ItemIndex  := 2;
            btnLogAppend.Enabled  := true;
            btnLogClear.Enabled   := true;
            btnLogDump.Enabled    := true;
           end;
  end;
  cbLoggingHEX.Checked    := fComPort.LogHex;
  cbLoggingAllHEX.Checked := fComPort.LogAllHex;
  fedLogFileName.FileName := fComPort.LogName;
  edLogSize.Text          := IntToStr(fComPort.LogSize);
end;

procedure TfrmComPortSettings.StateTracing;
begin
  case fComPort.Tracing   of
  tlOff:   begin
            rgrTraceMode.ItemIndex  := 0;
            btnTraceAppend.Enabled  := false;
            btnTraceClear.Enabled   := false;
            btnTraceDump.Enabled    := false;
           end;
  tlOn:    begin
            rgrTraceMode.ItemIndex  := 1;
            btnTraceAppend.Enabled  := true;
            btnTraceClear.Enabled   := true;
            btnTraceDump.Enabled    := true;
           end;
  tlPause: begin
            rgrTraceMode.ItemIndex  := 2;
            btnTraceAppend.Enabled  := true;
            btnTraceClear.Enabled   := true;
            btnTraceDump.Enabled    := true;
           end;
  end;
  cbTraceHEX.Checked        := fComPort.TraceHex;
  cbTraceAllHEX.Checked     := fComPort.TraceAllHex;
  fedTraceFileName.FileName := fComPort.TraceName;
  edTraceSize.Text            := IntToStr(fComPort.TraceSize);
end;


procedure TfrmComPortSettings.rgrTraceModeClick(Sender: TObject);
var n:integer;
begin
  try
    n := StrToInt(edTraceSize.text);
  finally

  end;
  if fedTraceFileName.FileName <> '' then
  begin
    case rgrTraceMode.ItemIndex of
    0:  begin
          fComPort.tracing := tlOff;
        end;
    1:  begin
          fComPort.TraceSize := n;
          fComPort.TraceName := fedTraceFileName.FileName;
          fComPort.tracing := tlOn;
        end;
    2:  begin
          fComPort.tracing := tlPause;
        end;
    end;
  end;
  StateTracing;
end;

procedure TfrmComPortSettings.cbTraceHEXClick(Sender: TObject);
begin
  fComPort.TraceHex := cbTraceHEX.Checked;
end;

procedure TfrmComPortSettings.cbTraceAllHEXClick(Sender: TObject);
begin
  fComPort.TraceAllHex := cbTraceAllHEX.Checked;
end;

procedure TfrmComPortSettings.btnTraceClearClick(Sender: TObject);
begin
  fComPort.TraceName := fedTraceFileName.FileName;
  fComPort.tracing := tlClear;
  StateTracing;
end;

procedure TfrmComPortSettings.btnTraceAppendClick(Sender: TObject);
begin
  fComPort.TraceName := fedTraceFileName.FileName;
  fComPort.tracing := tlAppend;
  StateTracing;
end;

procedure TfrmComPortSettings.btnTraceDumpClick(Sender: TObject);
begin
  fComPort.TraceName := fedTraceFileName.FileName;
  fComPort.tracing := tlDump;
  StateTracing;
end;


procedure TfrmComPortSettings.btnApplyClick(Sender: TObject);
var
  HWOpts : THWFlowOptionSet;
  SWOpts : TSWFlowOptions;
  Temp   : Integer;
  Code   : Integer;
  mstr   :string;
Const LogicArray : array [0..1] of boolean = (True,False);
begin
  fComPort.Open := false;
  {Update ComPort from dialog controls}
  fComPort.Baud := StrToInt(cbxBaud.Text);
  fComPort.Parity := TParity(Paritys.ItemIndex);
  fComPort.Databits := 8-Databits.ItemIndex;
  fComPort.Stopbits := Succ(Stopbits.ItemIndex);
  fComPort.DTR:=LogicArray[rgrDTR.ItemIndex];
  fComPort.RTS:=LogicArray[rgrRTS.ItemIndex];
  {Update HW flow}
  HWOpts := [];
  if DTRRTS.Checked then
    HWOpts := [hwfUseDTR, hwfRequireDSR];
  if RTSCTS.Checked then begin
    Include(HWOpts, hwfUseRTS);
    Include(HWOpts, hwfRequireCTS);
  end;
  fComPort.HWFlowOptions := HWOpts;

  {Update SW flow}
  if SoftwareXmit.Checked then
    if SoftwareRcv.Checked then
      SWOpts := swfBoth
    else
      SWOpts := swfTransmit
  else if SoftwareRcv.Checked then
    SWOpts := swfReceive
  else
    SWOpts := swfNone;
  fComPort.SWFlowOptions := SWOpts;

  Val(Edit1.Text, Temp, Code);
  if Code = 0 then
    fComPort.XOnChar := AnsiChar(Temp);
  Val(Edit2.Text, Temp, Code);
  if Code = 0 then
    fComPort.XOffChar := AnsiChar(Temp);

  fComPort.TraceName := fedTraceFileName.FileName;
  fComPort.LogName   := fedLogFileName.FileName;

  StateLogging;
  StateTracing;
    
  try
    fComPort.Open:=true;
  except
    mstr := 'Порт Com'+IntToStr(fComPort.ComNumber) + ' открыть не удалось! Изменить установки?' ;
    MessageDlg(mstr, mtError	, [mbOk], 0);
  end;

end;

procedure TfrmComPortSettings.CancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmComPortSettings.PortComboBoxChange(Sender: TObject);
var
  DeviceName : string;
begin
  DeviceName := PortComboBox.Items[PortComboBox.ItemIndex];
  if Pos(DirectTo, DeviceName) > 0 then begin
    fComPort.TapiMode := tmOff;
    fComPort.ComNumber := StrToInt(Copy(DeviceName, Length(DirectTo)+1, Length(DeviceName)));
  end else begin
    fComPort.TapiMode := tmAuto;
    fComPort.ComNumber := 0;
  end;
end;












end.
