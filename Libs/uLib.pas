unit uLib;

interface
uses SysUtils, Math;

function IsPalindrome(Cadena : string): Boolean;
function CuentaPalindromes(NumeroInicial, NumeroFinal : Integer) : LongInt;
function CalcularDesdeArchivo(RutaArchivo : string; Metodo : string = '0') : LongInt;
function CuentaPalindromesConSteps(Inicio , Fin : String): Integer;



implementation

function IsPalindrome(Cadena : string): Boolean;
begin
  Result := True;
  //Si el numero es menor de 2 posiciones es palindromo
  if Length(Cadena) < 2 then exit;
  
  //Si el primer y ultimo valor de la cadena son diferentes el numero no es palindromo
  //de lo contrario elimino estos dos valores y recursivamente recorro la cadena de numeros
  if Cadena[1] <> Cadena[ Length(Cadena) ] then
    Result :=False
  else
    Result :=Result and IsPalindrome( Copy( Cadena,2, Length(Cadena) -2)  );
end;

function CuentaPalindromes(NumeroInicial, NumeroFinal: Integer) : LongInt;
var
  numero,
  Contador : LongInt;
begin
  Contador := 0;
  //Loop entre el numero inicial y final para la determinación de los numeros palindromos
  for numero := NumeroInicial to NumeroFinal do
  begin
    //Función recursiva que determina si el numero es palindromo
    if IsPalindrome(IntToStr(numero)) then
      Inc(Contador);
  end;
  Result := Contador;
end;

function CalcularDesdeArchivo(RutaArchivo : string; Metodo : string = '0') : LongInt;
var
  Archivo : TextFile;
  Linea   : String;
  Suma    : Integer;
  NumeroInicio,
  NumeroFin : string;
begin
  Suma := 0;
  try
    //Inicializo el archivo
    AssignFile(Archivo, RutaArchivo);
    Reset(Archivo);

    // recorro el archivo hasta llegar al final del mismo
    while not Eof(Archivo) do
    begin
      //leo una linea del archivo
      Readln(Archivo, Linea);
      //obtengo los dos valores, el inicial y final
      NumeroInicio := Copy(Linea,1, pos(' ', Linea) - 1);
      NumeroFin := Copy(Linea, pos(' ', Linea) + 1, Length(Linea));

      //Determino que metodo usar
      //Llamo la funcion que me devuelve la cantidad de palindromos dentro del rango
      if Metodo = '1' then
        Suma := Suma + CuentaPalindromes( StrToInt(NumeroInicio) , StrToInt(NumeroFin) );

      if Metodo = '0' then
        Suma := Suma + CuentaPalindromesConSteps( NumeroInicio , NumeroFin );

    end;
  finally
    //Cierro el archivo
    CloseFile(Archivo);
    //Retorno el total de palindromos encontrados
    Result := Suma;
  end;
end;

function CadenaInvertida(Cadena : String) : string;
var
  strCadenaInvertida : string;
  x : Integer;
begin
  strCadenaInvertida := '';
  for x:= Length(Cadena) downto 1 do
    strCadenaInvertida := strCadenaInvertida +  Cadena[x];
  Result := strCadenaInvertida;
end;


function CreaPalindrome(Cadena : String) : string;
var
  MidChar   : string;
  MidLength : Integer;
  tmp : string;
begin
  MidChar := '';
  MidLength := Length(Cadena) Div 2;
  if (Length(Cadena) mod 2 > 0)  then
    MidChar := Copy(Cadena, MidLength + 1, 1);

  tmp := Copy(Cadena, 1, MidLength);

  Result := tmp + MidChar + CadenaInvertida( tmp );
end;


function CuentaPalindromesConSteps(Inicio , Fin : String): Integer;
var
  Contador    : Integer;
  MidLength,
  LengthLeft,
  Diff   : SmallInt;
  Step,
  Tope,
  SecuenciaInicial,
  intFin      : LongInt;
begin
  Diff := 0;
  if CreaPalindrome(Inicio) < Inicio then Diff := Diff - 1;
  if CreaPalindrome(Fin) < Fin then Diff := Diff + 1;


  Contador      := 0;
  Step := 0;
  intFin := StrToInt( Fin );

  while Step <> intFin do
  begin

    MidLength     := Trunc( Length(Inicio) /  2);

    if Length(Inicio) Mod 2 <> 0 then
      Inc(MidLength);

    LengthLeft    := Length(Inicio) -  MidLength;

    SecuenciaInicial  := StrToInt( Copy(Inicio, 1, MidLength) );

    Step              := Trunc( Power(10, Length(Inicio)) ) ;

    if Step > intFin then Step := intFin;

    Tope              := Trunc( Step / Power(10, LengthLeft) );

    Contador          := Contador + ( Tope - SecuenciaInicial );

    Inicio  := IntToStr(Step);
  end;

  Result := Contador + Diff;


end;




end.


