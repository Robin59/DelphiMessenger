unit Delphi_Messenger_Main;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, IPPeerClient, IPPeerServer, System.Tether.Manager, System.Tether.AppProfile, System.Actions,
  Vcl.ActnList, Vcl.ComCtrls;

const
  _TETHERING_MANAGER_TEXT_='TetheringManager_RGMessenger';
  _TETHERING_PROFILE_TEXT_='TetheringAppProfile_RGMessenger';
type
  TForm_Messenger_Main = class(TForm)
    Edit_Sended_Message: TEdit;
    Button_Send_Message: TButton;
    TetheringAppProfile: TTetheringAppProfile;
    TetheringManager: TTetheringManager;
    RichEdit: TRichEdit;
    ActionList: TActionList;
    procedure Button_Send_MessageClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit_Sended_MessageKeyPress(Sender: TObject; var Key: Char);
    procedure TetheringManagerRequestManagerPassword(const Sender: TObject; const ARemoteIdentifier: string; var Password: string);
    procedure TetheringManagerEndManagersDiscovery(const Sender: TObject; const ARemoteManagers: TTetheringManagerInfoList);
    procedure TetheringManagerEndProfilesDiscovery(const Sender: TObject; const ARemoteProfiles: TTetheringProfileInfoList);
    procedure TetheringAppProfileResourceReceived(const Sender: TObject; const AResource: TRemoteResource);
  private
    { Déclarations privées }
    User_Id:String;
    session_password:String;
    PROCEDURE Add_Message_to_RichEdit(CONST xAuthor:String; CONST xMessage_Added:String);
  public
    { Déclarations publiques }
  end;

var
  Form_Messenger_Main: TForm_Messenger_Main;

implementation

{$R *.dfm}

PROCEDURE TForm_Messenger_Main.Add_Message_to_RichEdit(CONST xAuthor:String; CONST xMessage_Added:String);
BEGIN
  if RichEdit.Text=''
    then RichEdit.Text:=xAuthor+' : '+xMessage_Added
    else RichEdit.Text:=RichEdit.Text+#13+xAuthor+' : '+xMessage_Added;
END;

procedure TForm_Messenger_Main.Button_Send_MessageClick(Sender: TObject);

  procedure Send_String_To_Others_Messenger(const xSenderID, xMessageToSend:String);
  var
    i_RemoteProfile: TTetheringProfileInfo;
  begin
    try
      for i_RemoteProfile in TetheringManager.RemoteProfiles
        do TetheringAppProfile.SendString(i_RemoteProfile, xSenderID, xMessageToSend);
    except
      on E : ETetheringException do
          begin
            //to do
            ShowMessage(E.ClassName+' Error in Send_String_To_Others_Messenger procedure : '+E.Message);
          end;
      on E : Exception
        do ShowMessage(E.ClassName+' Error in Send_String_To_Others_Messenger procedure : '+E.Message);
    end;
  end;

begin
  Send_String_To_Others_Messenger(User_Id,Edit_Sended_Message.Text);
  //to do
  Add_Message_to_RichEdit(User_Id,Edit_Sended_Message.Text);
  Edit_Sended_Message.Text:='';
end;

procedure TForm_Messenger_Main.Edit_Sended_MessageKeyPress(Sender: TObject; var Key: Char);
begin
  //to do : send on ctr+enter
end;

procedure TForm_Messenger_Main.FormCreate(Sender: TObject);

  function Get_ID:String; // Will be change later
  var
    Temp : PChar;
    Size : Cardinal;
  begin
    Size:=254;
    Temp:=StrAlloc(Size);
    IF GetComputerName(Temp,Size)
    THEN Result:=Temp
    ELSE Result:='';
    StrDispose(Temp);
    Result.Trim;
  end;

begin
  TetheringAppProfile.Text:=_TETHERING_PROFILE_TEXT_;
  TetheringManager.Text:=_TETHERING_MANAGER_TEXT_;
  session_password:='Temp_Password';// to do : change the password system
  RichEdit.Text:='';
  User_Id:=Get_ID;
  TetheringManager.Password:=session_password;
  TetheringManager.DiscoverManagers;
end;

procedure TForm_Messenger_Main.TetheringAppProfileResourceReceived(const Sender: TObject; const AResource: TRemoteResource);
begin
  if AResource.ResType = TRemoteResourceType.Data then
    begin
       Add_Message_to_RichEdit('Received : ',AResource.Value.AsString);
    end;
end;

procedure TForm_Messenger_Main.TetheringManagerEndManagersDiscovery(const Sender: TObject; const ARemoteManagers: TTetheringManagerInfoList);
var
  i_Manager:Smallint;
begin
  FOR i_Manager := 0 to ARemoteManagers.Count - 1 DO
    BEGIN
      IF (ARemoteManagers[I_Manager].ManagerText=_TETHERING_MANAGER_TEXT_)
        THEN TetheringManager.PairManager(ARemoteManagers[I_Manager]);
    END;
end;

procedure TForm_Messenger_Main.TetheringManagerEndProfilesDiscovery(const Sender: TObject; const ARemoteProfiles: TTetheringProfileInfoList);
var
  i_Profile:SmallInt;
begin
  for i_Profile:=0 to TetheringManager.RemoteProfiles.Count-1 do
   begin
     if(TetheringManager.RemoteProfiles[i_Profile].ProfileText=_TETHERING_PROFILE_TEXT_) then
       begin
            TetheringAppProfile.Connect(TetheringManager.RemoteProfiles[i_Profile]);
            //index_profile:=i_Profile;
       end;
   end
end;

procedure TForm_Messenger_Main.TetheringManagerRequestManagerPassword(const Sender: TObject; const ARemoteIdentifier: string; var Password: string);
begin
  Password:=session_password;
end;

end.
