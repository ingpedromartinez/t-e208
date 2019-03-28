program TE208;

uses SysUtils;

Type
  tRLibro = Record
             clave   : integer;
             titulo  : string[50];
             autor   : String[50];
             edicion : Integer;
             genero  : String[30];
             isbn    : String[13];
             precio  : real;
          end;

  tRLibroPtr = ^tRLibro;

  tASecuencial = File of tRLibro;

var
   sel:integer;
   nomAE:string;
   nomAS,autor:string;
   ref:tRLibroPtr;

Procedure CrearArchivo(a: String);

	var
	nuevoArch: tASecuencial;

	Begin
	Assign(nuevoArch,a);
	Rewrite(nuevoArch);
        Close(nuevoArch);
	End;

Procedure LeerLibro(rLib:tRLibroPtr);
	Begin
		writeln('Escribe la clave de libro');
                readln(rLib^.clave);
		write('Escribe el titulo de libro');
		readln(rLib^.titulo);
		writeln('Escribe autor del libro');
		readln(rLib^.autor);
		writeln('Escribe la Edicion del libro');
		readln(rLib^.edicion);
		writeln('Digita el genero del libro');
		readln(rLib^.genero);
		writeln('Digita el ISBN');
		readln(rLib^.isbn);
		writeln('Cual es el precio del libro?');
		readln(rLib^.precio);
	End;




Procedure AltaDeLibro(a: String; rLib:tRLibroPtr);
	var
	T:Integer;
	archivo:tASecuencial;
        reg:tRLibro;

	Begin
	Assign(archivo,a);
	reset(archivo);
	While not EOF(archivo) do
              begin
                read(archivo,reg);
                end;
        write(archivo,rLib^);
        close(archivo);
	End;


Procedure ReportePorAutor (a:string;autor:string; aSal:string);
	var
	aEntrada:tASecuencial;
	Reporte:Text;
        reg: tRLibro;
        i:integer;

        begin
        i:=1;
        Assign(aEntrada,a);
        Assign(Reporte,aSal);
        rewrite(Reporte);

	writeln(Reporte,'             Reporte de libros por autor              ');
       	writeln(Reporte,autor);
 	writeln(Reporte,'----------------------------------------------------------------------------------');
 	writeln(Reporte,'No. Clave        Título          Edción   Género        isbn         precio (M.N.)');
 	writeln(Reporte,'----------------------------------------------------------------------------------');

        while (not EOF(Reporte)) do
              begin
                   read(aEntrada,reg);
                   if reg.autor=autor then writeln(Reporte,inttostr(i)+'   '+inttostr(reg.clave)+'    '+reg.titulo+'   '+inttostr(reg.edicion)+'      '+reg.genero+'     '+reg.isbn+'     '+floattostr(reg.precio));
                   i:=i+1;
              end;

         writeln(Reporte,'----------------------------------------------------------------------------------');
         close(Reporte);
         end;


Function BuscaLibro(a:String;cve:Integer): Boolean;
         var
         encontrado:BOOLEAN;
         i: Integer;
	 arch:tASecuencial;
         reg:tRLibro;

         Begin
         encontrado:=FALSE;
         i:= 0;
	 Assign(arch,a);
         reset(arch);
         while (not EOF(arch)) and (not encontrado) do
               begin
                    Read(arch,reg);
                    If(reg.clave=cve) then encontrado := TRUE;
               end;
         close(arch);
         BuscaLibro:= encontrado;

         End;


begin

  writeln('Menu: ');
  writeln('1. Crear Archivo');
  writeln('2. Alta de libro');
  writeln('3. Reporte por autor');

  while true do
        begin
             writeln('Ingrese una opción');
             readln(sel);
  case sel of
    1:
      begin
           writeln('Ingrese el nombre del archivo');
           CrearArchivo(nomAE);
           writeln('Archivo Creado exitosamente');
      end;
    2:
      begin
           new(ref);
           LeerLibro(ref);
           AltaDeLibro(nomAE,ref);
      end;

    3:
      begin
           writeln('Ingrese el nombre del autor :');
           readln(autor);
           writeln('Ingrese el nombre del archivo de salida: ');
           readln(nomAS);
           ReportePorAutor(nomAE,autor,nomAS);
      end;
      0: break;

      end;
  end;
end.


