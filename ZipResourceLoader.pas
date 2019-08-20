unit ZipResourceLoader;

interface

uses
  ResourceLoaderBase,
  System.Zip,
  System.Classes,
  System.SysUtils;

type
  IZipResourceLoader = interface
    ['{F19CD9DC-1977-4A3A-97BC-6E81FBCB8AAA}']
    function LoadResource(const AResourceName: string): TResourceStream;
  end;

  TZipResourceLoader = class(TResourceLoaderBase, IZipResourceLoader)
  private
    FZipFile: TZipFile;
  public
    function LoadResource(const AResourceName: string): TResourceStream; reintroduce;
    destructor Destroy; override;
    // AFile is file path and path name using "/" as path delimiter.
    function ExtractFileToBytes(const AFile: string): TBytes;
  end;

implementation

function TZipResourceLoader.LoadResource(const AResourceName: string): TResourceStream;
begin
  if Assigned(FZipFile) then
    FreeAndNil(FZipFile);

  inherited LoadResource(AResourceName, 'Zip');
  FZipFile := TZipFile.Create;
  try
    FZipFile.Open(ResourceStream, zmRead);
  except
    FZipFile.Free;
    raise;
  end;

  Result := ResourceStream;
end;

destructor TZipResourceLoader.Destroy;
begin
  if Assigned(FZipFile) then
    FZipFile.Free;

  inherited;
end;

// AFile is file path and path name using "/" as path delimiter.
function TZipResourceLoader.ExtractFileToBytes(const AFile: string): TBytes;
var
  LBytes: TBytes;
begin
  if not Assigned(FZipFile) then
    raise Exception.Create('Please load resource.');

  try
    FZipFile.Read(AFile, LBytes);
  except
    on E: Exception do
    begin
      E.Message := E.Message + #13#10 + 'File to extract: ' + AFile;
      raise;
    end;
  end;

  Result := LBytes;
end;

end.
