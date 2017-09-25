unit uSession;

interface

uses Redis.Client, REST.Json;

type

  TSession = class
  private
    Fempresa: Integer;
    Fbasic: string;
    function Getempresa: Integer;
  public
    property empresa: Integer read Getempresa write Fempresa;
    property basic: string read Fbasic write fbasic;

  end;

var
  FSession: TSession;

implementation

{ TSession }

{ TSession }

function TSession.Getempresa: Integer;
var
  ARedis: TRedisClient;
  ASession: TSession;
begin
  ARedis := TRedisClient.Create('192.168.99.100', 32768);
  try
    ARedis.Connect;
    if not ARedis.GET(basic).IsNull then
    begin
      ASession := TJson.JsonToObject<TSession>(ARedis.GET(basic).Value);
      try
        Fempresa := ASession.fempresa;
      finally
        ASession.Free;
      end;
    end;
  finally
    ARedis.Free;
  end;
  Result := Fempresa;
end;

{ TSession }

initialization
  if not Assigned(FSession) then
    FSession := TSession.Create;

finalization
  FSession.Free;

end.