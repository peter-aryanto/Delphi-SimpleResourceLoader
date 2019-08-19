unit MainFormUnit;

interface

uses
//  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, System.Classes, Vcl.StdCtrls, Vcl.ComCtrls;
//  , Vcl.Dialogs;

type
  TMainForm = class(TForm)
    CancelButton: TButton;
    OutputRichEdit: TRichEdit;
    procedure FormShow(Sender: TObject);
    procedure CancelButtonClick(Sender: TObject);
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}
{$R .\Resource\Zip\FirstAndSecondFiles.RES}

uses
  System.SysUtils,
  Vcl.Dialogs, System.UITypes,
  ResourceLoaderBase,
  ZipResourceLoader;

procedure TMainForm.FormShow(Sender: TObject);
var
  LZipResource: IResourceLoader;
begin
  LZipResource := TZipResourceLoader.Create('FirstAndSecondFilesZipResource');
  try
    OutputRichEdit.Lines.Add(
      StringOf(
        TZipResourceLoader(LZipResource).ExtractFileToBytes('FirstAndSecondFiles/FirstFile.txt')));

    OutputRichEdit.Lines.Add(
      StringOf(
        TZipResourceLoader(LZipResource).ExtractFileToBytes('FirstAndSecondFiles/SecondFile.txt')));

  except on E: Exception do
    MessageDlg(E.Message, mtError, [mbOK], 0);
  end;
end;

procedure TMainForm.CancelButtonClick(Sender: TObject);
begin
  Close;
end;

end.
