unit uSession;

interface

uses Redis.Client, REST.Json, uRedisConfig;

type

  TSession = class
  private
    Fempresa: Integer;
  public
    property empresa: Integer read Fempresa write Fempresa;
  end;

  TSessionManager = class
  public
    class function GetInstance(Auth: string): TSession;
  end;

implementation

uses
  Redis.Values;

{ TSessionManager }

class function TSessionManager.GetInstance(Auth: string): TSession;
var
  ARedis: TRedisClient;
  ARedisConfig: TRedisConfig;
  AValue: TRedisString;
begin
  Result := nil;
  ARedisConfig := TRedisConfig.Create;
  try
    ARedis := TRedisClient.Create(ARedisConfig.Host, ARedisConfig.Port);
    try
      ARedis.Connect;
      AValue := ARedis.GET(Auth);
      if not AValue.IsNull then
      begin
        Result := TJson.JsonToObject<TSession>(AValue.Value);
      end;
    finally
      ARedis.Free;
    end;
  finally
    ARedisConfig.Free;
  end;
end;

end.
