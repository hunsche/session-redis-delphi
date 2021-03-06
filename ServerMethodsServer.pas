unit ServerMethodsServer;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth, DBXPlatform;

type
{$METHODINFO ON}
  TServerMethods1 = class(TComponent)
  private
    { Private declarations }
  public
    { Public declarations }
    function updateEmpresa(ID: Integer): string;
    function Empresa: string;
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
  end;
{$METHODINFO OFF}

implementation


uses System.StrUtils, Redis.Client, Vcl.Dialogs, uSession, Web.HTTPApp,
  Datasnap.DSHTTPWebBroker, uRedisConfig, Redis.Values, REST.Json;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

function TServerMethods1.Empresa: string;
var
  AModule: TWebModule;
  ASession: TSession;
  AAuth: string;
begin
  AModule := GetDataSnapWebModule;
  AAuth := AModule.Request.Authorization;
  ASession := TSessionManager.GetInstance(AAuth);
  try
    Result := ASession.empresa.ToString;
  finally
    ASession.Free;
  end;
end;

function TServerMethods1.updateEmpresa(ID: Integer): string;
var
  AModule: TWebModule;
  ARedisConfig: TRedisConfig;
  ARedis: TRedisClient;
  AValue: TRedisString;
  ASession: TSession;
  AAuth: string;
begin
  AModule := GetDataSnapWebModule;
  AAuth := AModule.Request.Authorization;
  ARedisConfig := TRedisConfig.Create;
  try
    ARedis := TRedisClient.Create(ARedisConfig.Host, ARedisConfig.Port);
    try
      ARedis.Connect;
      AValue := ARedis.GET(AAuth);
      if not AValue.IsNull then
        ASession :=  TJson.JsonToObject<TSession>(AValue.Value)
      else
        ASession := TSession.Create;
      try
        ASession.empresa := ID;
        ARedis.&SET(AAuth, TJson.ObjectToJsonString(ASession));
      finally
        ASession.Free;
      end;
    finally
      ARedis.Free;
    end;
  finally
    ARedisConfig.Free;
  end;

  result := 'empresa alterada para ' + ID.ToString;
end;

end.

