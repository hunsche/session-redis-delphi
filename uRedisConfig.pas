unit uRedisConfig;

interface

type

  TRedisConfig = class
  private
    FPort: Integer;
    FHost: string;
  public
    property Host: string read FHost write FHost;
    property Port: Integer read FPort write FPort;
    constructor Create;
  end;

implementation

uses
  inifiles, System.SysUtils, Vcl.Forms;

{ TRedisConfig }

constructor TRedisConfig.Create;
var
  AIni: TIniFile;
begin
  AIni := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  try
    FHost := AIni.ReadString('Redis', 'Host', '127.0.0.1');
    FPort := AIni.ReadInteger('Redis', 'Port', 6379);
  finally
    AIni.Free;
  end;
end;

end.
