unit ResourceLoaderBase;

interface

uses
  System.Classes;

type
  IResourceLoader = interface
    ['{F19CD9DC-1977-4A3A-97BC-6E81FBCB8AAA}']
    function LoadResource(const AResourceName: string;
      const AResourceType: string
    ): TResourceStream;
  end;

  TResourceLoaderBase = class abstract(TInterfacedObject, IResourceLoader)
  private
    FResourceStream: TResourceStream;
  protected
    property ResourceStream: TResourceStream read FResourceStream;
  public
    destructor Destroy; override;
    function LoadResource(const AResourceName: string;
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

function TResourceLoaderBase.LoadResource(const AResourceName: string;
  const AResourceType: string
): TResourceStream;
begin
  if Assigned(FResourceStream) then
    FreeAndNil(FResourceSTream);

  FResourceStream := TResourceStream.Create(HInstance, AResourceName, PChar(AResourceType));
  Result := FResourceStream;
end;

end.
