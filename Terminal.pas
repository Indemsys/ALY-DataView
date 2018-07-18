unit Terminal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OoMisc, ADTrmEmu, ExtCtrls, ToolWin, ComCtrls, StdCtrls,
  AdStatLt, RXCtrls, rxPlacemnt, Mask, rxToolEdit, DB,
  Buttons, Grids, DBGrids, AppEvnts, DBCtrls, ImgList, System.ImageList;

type
  TfrmTestTerminal = class(TForm)
    AdVT100Emulator1: TAdVT100Emulator;
    ApdSLController1: TApdSLController;
    Panel1: TPanel;
    aslTXD: TApdStatusLight;
    Label1: TLabel;
    aslRXD: TApdStatusLight;
    aslCTS: TApdStatusLight;
    aslDCD: TApdStatusLight;
    aslDSR: TApdStatusLight;
    aslRING: TApdStatusLight;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    aslERROR: TApdStatusLight;
    Label7: TLabel;
    aslBREAK: TApdStatusLight;
    Label8: TLabel;
    StatusBar: TStatusBar;
    FormStorage1: TFormStorage;
    PageControl1: TPageControl;
    tbsTerminal: TTabSheet;
    ToolBar1: TToolBar;
    btnEraseTerminal: TToolButton;
    AdTerminal1: TAdTerminal;
    Panel2: TPanel;
    fedCaptureFile: TFilenameEdit;
    Label9: TLabel;
    cbCaptureMode: TComboBox;
    Label10: TLabel;
    FontDialog1: TFontDialog;
    btnTerminalFont: TToolButton;
    ApplicationEvents1: TApplicationEvents;
    ImageList1: TImageList;
    procedure btnEraseTerminalClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbCaptureModeChange(Sender: TObject);
    procedure UpdateCaptureControls;
    procedure fedCaptureFileAfterDialog(Sender: TObject; var Name: String;
      var Action: Boolean);
    procedure btnTerminalFontClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
  end;

var
  frmTestTerminal: TfrmTestTerminal;

implementation

uses Main;

{$R *.dfm}


procedure TfrmTestTerminal.FormCreate(Sender: TObject);
begin
  AdTerminal1.Enabled := true;
  ApdSLController1.Monitoring := true;
end;

procedure TfrmTestTerminal.FormShow(Sender: TObject);
begin
  UpdateCaptureControls;
end;

procedure TfrmTestTerminal.btnEraseTerminalClick(Sender: TObject);
begin
  AdTerminal1.Clear;
end;

procedure TfrmTestTerminal.UpdateCaptureControls;
begin
  fedCaptureFile.FileName := AdTerminal1.CaptureFile;
  case AdTerminal1.Capture of
  cmOff:    cbCaptureMode.ItemIndex := 0;
  cmOn:     cbCaptureMode.ItemIndex := 1;
  cmAppend: cbCaptureMode.ItemIndex := 2;
  end;
end;

procedure TfrmTestTerminal.cbCaptureModeChange(Sender: TObject);
begin
  case cbCaptureMode.ItemIndex of
  0: AdTerminal1.Capture := cmOff;
  1: AdTerminal1.Capture := cmOn;
  2: AdTerminal1.Capture := cmAppend;
  end;
end;

procedure TfrmTestTerminal.fedCaptureFileAfterDialog(Sender: TObject;
  var Name: String; var Action: Boolean);
begin
  AdTerminal1.CaptureFile := name;
  UpdateCaptureControls;
end;

procedure TfrmTestTerminal.btnTerminalFontClick(Sender: TObject);
begin
  with FontDialog1 do
  begin
    Font := AdTerminal1.font;
    if Execute = true then
    begin
      AdTerminal1.font := Font;
    end;
  end;
end;




procedure TfrmTestTerminal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ApdSLController1.Monitoring := False;
  ApdSLController1.Free;
  AdTerminal1.Enabled := False;

end;

end.
