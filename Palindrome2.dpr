program Palindrome2;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  uLib in 'Libs\uLib.pas';

var
  Fecha  : TDateTime;
  Metodo : string;
begin
  Metodo := ParamStr(2);
  If Metodo = '' then Metodo := '0';

  Fecha := Now;
  Writeln( CalcularDesdeArchivo(ParamStr(1), Metodo) );
  Writeln( FormatDateTime('hh:nn:ss:zzzz',  Now - Fecha));

end.
 