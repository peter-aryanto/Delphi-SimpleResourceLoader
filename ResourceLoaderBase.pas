unit ResourceLoaderBase;

interface

uses
  System.Classes;

type
  IResourceLoader = interface
    ['{F19CD9DC-1977-4A3A-97BC-6E81FBCB8AAA}']
    function LoadResourceToStream(const AResourceName: string;
      const AResourceType: string
    ): TResourceStream;
  end;

  TResourceLoaderBase = class (TInterfacedObject, IResourceLoader)
  protected
    FResourceStream: TResourceStream;
    procedure ValidateResourceLoadedToStream; virtual; final;
  public
    destructor Destroy; override;
    function LoadResourceToStream(const AResourceName: string;
      const AResourceType: string
    ): TResourceStream; virtual;
  end;

implementation

uses
  System.SysUtils;

destructor TResourceLoaderBase.Destroy;
begin
  if Assigned(FResourceStream) then
    FResourceStream.Free;

  inherited;
end;

function TResourceLoaderBase.LoadResourceToStream(const AResourceName: string;
  const AResourceType: string
): TResourceStream;
begin
  if Assigned(FResourceStream) then
    FreeAndNil(FResourceSTream);

  FResourceStream := TResourceStream.Create(HInstance, AResourceName, PChar(AResourceType));
  Result := FResourceStream;
end;

procedure TResourceLoaderBase.ValidateResourceLoadedToStream;
begin
  if not Assigned(FResourceStream) then
    raise Exception.Create('Please load resource to stream.');
end;

end.
