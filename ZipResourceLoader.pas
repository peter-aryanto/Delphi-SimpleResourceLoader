unit ZipResourceLoader;

interface

uses
  ResourceLoaderBase,
  System.Classes,
  System.SysUtils;

type
  TZipResourceLoader = class(TResourceLoaderBase)
  private
    FResourceName: string;
    FExtractedStream: TStream;
  public
    constructor Create(const AResourceName: string);
    destructor Destroy; override;
    // AFile is file path and path name using "/" as path delimiter.
    function ExtractFileToBytes(const AFile: string): TBytes;
  end;

implementation

uses
  System.Zip;
//  System.SysUtils;

constructor TZipResourceLoader.Create(const AResourceName: string);
begin
  FResourceName := AResourceName;
end;

destructor TZipResourceLoader.Destroy;
begin
  if Assigned(FExtractedStream) then
    FExtractedStream.Free;

  inherited;
end;

// AFile is file path and path name using "/" as path delimiter.
function TZipResourceLoader.ExtractFileToBytes(const AFile: string): TBytes;
var
  LZipFile: TZipFile;
begin
  LoadResourceToStream(FResourceName, 'Zip');
  ValidateResourceLoadedToStream;

  LZipFile := TZipFile.Create;
  try
    LZipFile.Open(FResourceStream, zmRead);

    try
      LZipFile.Read(AFile, Result);
    except
      on E: Exception do
      begin
        E.Message := E.Message + #13#10 + 'File to extract: ' + AFile;
        raise;
      end;
    end;

  finally
    LZipFile.Free;
  end;
end;

end.
