program qsort_binsearch;

uses crt;

const LEN = 30; BIG_LEN = 10000;
type array_t = array[1..LEN] of integer;
     big_array_t = array[1..BIG_LEN] of integer;

procedure QSort(var a: array_t; N: integer);
begin
end;

procedure QSort(var a: big_array_t; N: integer);
begin
	// just copy your QSort code here
end;

function BinSearch(var a: array_t; N, value: integer): integer;
begin
	BinSearch := 0
end;

function BinSearch(var a: big_array_t; N, value: integer): integer;
begin
	// just copy your BinSearch code here
	BinSearch := 0
end;

function test(): boolean;
begin
	test := false
end;

BEGIN
END.
