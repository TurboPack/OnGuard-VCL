program ExSpName;
{$mode objfpc}{$H+}

uses
  Interfaces,
  Forms,
  ExSpNamu in 'ExSpNamu.pas' {Form1}, tponguard;



begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
