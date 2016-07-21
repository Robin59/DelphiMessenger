program Delphi_Messenger;

uses
  Vcl.Forms,
  Delphi_Messenger_Main in 'Delphi_Messenger_Main.pas' {Form_Messenger_Main};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm_Messenger_Main, Form_Messenger_Main);
  Application.Run;
end.
