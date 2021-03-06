unit WebModuleServer;

interface

uses
  System.SysUtils, System.Classes, Web.HTTPApp, Datasnap.DSHTTPCommon,
  Datasnap.DSHTTPWebBroker, Datasnap.DSServer,
  Datasnap.DSAuth, IPPeerServer, Datasnap.DSCommonServer, Datasnap.DSHTTP,
  Redis.Client;

type
  TWebModule1 = class(TWebModule)
    DSHTTPWebDispatcher1: TDSHTTPWebDispatcher;
    DSServer1: TDSServer;
   DSAuthenticationManager1: TDSAuthenticationManager;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
    procedure DSAuthenticationManager1UserAuthorize(Sender: TObject;
      EventObject: TDSAuthorizeEventObject; var valid: Boolean);
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject;
      const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure WebModule1DefaultHandlerAction(Sender: TObject;
      Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
  end;

var
  WebModuleClass: TComponentClass = TWebModule1;

implementation


{$R *.dfm}

uses ServerMethodsServer, Web.WebReq, Vcl.Dialogs, Winapi.CommDlg, uSession,
  REST.JSON, uRedisConfig;

procedure TWebModule1.WebModule1DefaultHandlerAction(Sender: TObject;
  Request: TWebRequest; Response: TWebResponse; var Handled: Boolean);
begin
  Response.Content :=
    '<html>' +
    '<head><title>DataSnap Server</title></head>' +
    '<body>DataSnap Server</body>' +
    '</html>';
end;

procedure TWebModule1.DSServerClass1GetClass(
  DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsServer.TServerMethods1;
end;

procedure TWebModule1.DSAuthenticationManager1UserAuthenticate(
  Sender: TObject; const Protocol, Context, User, Password: string;
  var valid: Boolean; UserRoles: TStrings);
begin
  valid := True;
end;

procedure TWebModule1.DSAuthenticationManager1UserAuthorize(
  Sender: TObject; EventObject: TDSAuthorizeEventObject;
  var valid: Boolean);
begin
  valid := True;
end;

initialization
finalization
  Web.WebReq.FreeWebModules;

end.

