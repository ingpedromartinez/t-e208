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




Procedure OrdenarLibros(a:string);
          var
             arch:tASecuencial;
             A1:tASecuencial;
             A2:tASecuencial;
             AF:tASecuencial;
             reg:tRlibro;
             numR,tsec,part:integer;
             aX:boolean;

          begin
          assign(A1,'aux1.dat');
          assign(A1,'aux2.dat');
          assign(AF,'aux3.dat');
          rewrite(A1);
          rewrite(A2);
          rewrite(AF);



          {Obtener num de registros}
          Assign(arch,a);
          reset(arch);
          numR:=0;
          while not EOF(arch) do
                begin
                     read(arch,reg);
                     numR:=numR+1;
                     write(AF,reg);
                end;
          part:=1;
          while part<numR do
                begin
                     tsec :=part*2;
                     {Acomodar las particiones de tamaño part}
                     a2=false;
                     rewrite(A1);
                     rewrite(A2);
                     while i<numR do
                           begin

                           end;
                     {Ordenar secuencias de tamano tsec en A1,A2}


                end;

          end;

Procedure ConsultaUnLibro(a:string; cve: integer; existe:boolean; rlib: tRLibro);
          var
             arch: tAsecuencial;

          begin
          existe:=false;
          assign(arch,a);
          reset(arch);
          while (not EOF(arch)) and (not existe) do
                begin
                     read(arch,rlib);
                     if  rlib.clave = clave then existe:= true;
                end;
          close(arch);
          end;

Procedure ConsultaTotalDeLibros(a:string);
          var
             total:integer;
             arch:tAsecuencial;
             r:tRlibro;

          begin
          assign(arch,a);
          reset(arch);
          writeln('...............................................................');
          writeln('cve'#9'titulo'#9'autor'#9'edicion'#9'genero'#9'isbn'#9'precio');
          while not EOF(arch) do
                begin
                     read(arch,r);
                     writeln(r.clave#9r.titulo#9r.autor#9r.edicion#9r.genero#9r.isbn#9r.precio);
                     total:=total+1;
                end;
          writeln('...............................................................');
          writeln('El total de libros es: '+inttostr(total));
          end;

Procedure BajaDeLibro(a:string;cve:integer);
          var
             r:tRlibro;
             arch:tASecuencial;
             aux:tASecuencial;

          begin
          assign(arch,a);
          assign(aux,'librosaux.dat');
          reset(arch);
          rewrite(aux);
          while not EOF(arch) do
                begin
                     read(arch,r);
                     if r.clave <> cve then write(arch,r);
                end;
          close(arch);
          close(aux);

          deletefile(a);
          rename(aux,a);
          end;

Procedure ModificaLibro(a:string;cve:int);

          var
             r:tRlibro;
             arch:tASecuencial;
             aux:tASecuencial;

          begin
          assign(arch,a);
          assign(aux,'aux.dat');

          reset(arch);
          rewrite(aux);

          while not EOF(arch) do
                begin
                     read(arch,r);
                     if r.clave<>cve then write(arch,r);
                end;
          close(arch);
          close(AUX);

          deletefile(a);
          rename(aux,a);

          end;

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


