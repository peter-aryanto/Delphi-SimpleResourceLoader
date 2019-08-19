program ResourceLoader;

{
  ResourceLoaderInterface defines inputs and outputs.
}

uses
  Vcl.Forms,
  MainFormUnit in 'MainFormUnit.pas' {MainForm};
//  ResourceLoaderBase in 'ResourceLoaderBase.pas',
//  ZipResourceLoader in 'ZipResourceLoader.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;

  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
