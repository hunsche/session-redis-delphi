program PrjServer;
{$APPTYPE GUI}

uses
  Vcl.Forms,
  Web.WebReq,
  IdHTTPWebBrokerBridge,
  FormServer in 'FormServer.pas' {Form1},
  ServerMethodsServer in 'ServerMethodsServer.pas',
  WebModuleServer in 'WebModuleServer.pas' {WebModule1: TWebModule},
  Redis.Client in 'delphiredisclient\sources\Redis.Client.pas',
  Redis.Command in 'delphiredisclient\sources\Redis.Command.pas',
  Redis.Commons in 'delphiredisclient\sources\Redis.Commons.pas',
  Redis.NetLib.Factory in 'delphiredisclient\sources\Redis.NetLib.Factory.pas',
  Redis.NetLib.INDY in 'delphiredisclient\sources\Redis.NetLib.INDY.pas',
  Redis.Values in 'delphiredisclient\sources\Redis.Values.pas',
  RedisMQ.Commands in 'delphiredisclient\sources\RedisMQ.Commands.pas',
  RedisMQ in 'delphiredisclient\sources\RedisMQ.pas',
  uSession in 'uSession.pas';

{$R *.res}

begin
  if WebRequestHandler <> nil then
    WebRequestHandler.WebModuleClass := WebModuleClass;
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
