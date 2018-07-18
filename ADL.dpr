program ADL;

uses
  Forms,
  Main in 'Main.pas' {frmMain},
  ComPortSettings in 'ComPortSettings.pas' {frmComPortSettings},
  adpacked in 'adpacked.pas' {PacketEditor},
  Terminal in 'Terminal.pas' {frmTestTerminal},
  Test_data_stream in 'Test_data_stream.pas' {frmTestDataStream};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ALY DataLanding';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
