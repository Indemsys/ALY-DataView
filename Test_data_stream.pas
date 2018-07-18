unit Test_data_stream;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TfrmTestDataStream = class(TForm)
    btnStartStop: TBitBtn;
    btnExit: TBitBtn;
    edDelimeter: TEdit;
    Label1: TLabel;
    edSeriesCount: TEdit;
    Label2: TLabel;
    Timer1: TTimer;
    edInterval: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    procedure btnExitClick(Sender: TObject);
    procedure btnStartStopClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    series_count : integer;

  public
    { Public declarations }
  end;

var
  frmTestDataStream: TfrmTestDataStream;


implementation

uses Main;

{$R *.dfm}


procedure TfrmTestDataStream.btnExitClick(Sender: TObject);
begin
  Timer1.Enabled := False;
  Free;
end;

procedure TfrmTestDataStream.btnStartStopClick(Sender: TObject);
begin
  if Timer1.Enabled then
  begin
    Timer1.Enabled := False;
    btnStartStop.Caption := 'Start';
  end
  else
  begin
    try
      Timer1.Interval := StrToInt(edInterval.Text);
    finally
      edInterval.SetFocus;
    end;

    try
      series_count := StrToInt(edSeriesCount.Text);
    finally
      edSeriesCount.SetFocus;
    end;

    frmMain.PrepareRecv;
    btnStartStop.Caption := 'Stop';
    Timer1.Enabled := True;
  end;


end;


procedure TfrmTestDataStream.Timer1Timer(Sender: TObject);
var  str: ShortString;
     i:   integer;
     buf: array[0..128] of char;

begin
  str := '';
  for i := 0 to series_count - 1 do
  begin
    str := str + format('%d', [Random(100)]);
    if i<>series_count - 1 then  str := str + edDelimeter.Text;
  end;

  str := str + #13#10;
  Move(str[1],buf, Length(str));

  frmMain.Data_packetPacket(Self, @buf[0], Length(str));

end;

procedure TfrmTestDataStream.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;


end.
