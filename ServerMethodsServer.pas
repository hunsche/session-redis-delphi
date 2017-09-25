unit ServerMethodsServer;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth;

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


uses System.StrUtils, Redis.Client, Vcl.Dialogs, uSession;

function TServerMethods1.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods1.Empresa: string;
begin
  Result := FSession.empresa.ToString;
end;

function TServerMethods1.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;
function TServerMethods1.updateEmpresa(ID: Integer): string;
begin
  result := 'empresa alterada para ' + ID.ToString;
end;

end.
