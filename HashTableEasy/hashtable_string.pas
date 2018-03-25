program hash_table_string;

uses crt;

const 
	MAX_SIZE = 30; 
	BUCKET_MAX_SIZE = 4;
    p = 0; // change the point value!
type 
	key_t = string;
	bucket_t = array[1..BUCKET_MAX_SIZE] of key_t;
	hashtable_t = array[1..MAX_SIZE] of bucket_t; 
	list_t = array[1..MAX_SIZE*BUCKET_MAX_SIZE] of key_t;
var  
	hashtable: hashtable_t;
	bsizes: array[1..MAX_SIZE] of integer;
	size: integer; 

function Hash(key: key_t): integer;
begin
    Hash := 1;
end;

function Find(key: key_t): boolean;
begin
	Find := false;
end;

function Add(key: key_t): boolean;
begin
	Add := false;
end;

function Delete(key: key_t): boolean;
begin
	Delete := false;
end;

function GetSize(): integer;
begin
	GetSize := -1;
end;

procedure MakePPrint();
begin
end;


procedure Clear();
begin
end;

function test(): boolean;
var TEST_NAME: string; KEEP_RUNNING: boolean;

	procedure cprint(text: string; c: integer);
	begin
		textcolor(c);
		writeln(text);
		normvideo
	end;
	
	function ASSERT_EQ(got, expected: integer) : boolean;
	begin
		ASSERT_EQ := got = expected;
		if not (ASSERT_EQ) then begin
			cprint(TEST_NAME + ' failed with assertion error:', red);
			writeln('got: ', got);
			writeln('expected: ', expected);
			KEEP_RUNNING := false
		end
	end;

	function ASSERT_TRUE(got: boolean): boolean;
	begin
		ASSERT_TRUE := got;
		if not(ASSERT_TRUE) then begin
			cprint(TEST_NAME + ' failed with assertion error:', red);
			writeln('got: false');
			writeln('expected: true');
			KEEP_RUNNING := false
		end
	end;
	
	function ASSERT_FALSE(got: boolean): boolean;
	begin
		ASSERT_FALSE := not(got);
		if not(ASSERT_FALSE) then begin
			cprint(TEST_NAME + ' failed with assertion error:', red);
			writeln('got: true');
			writeln('expected: false');
			KEEP_RUNNING := false
		end
	end;
	
	procedure test_run();
	begin
        KEEP_RUNNING := true;
        // add your test procedures here
	end;
		
begin
	test_run();
	if (KEEP_RUNNING) then cprint('Job succed.', green)
					  else cprint('Testing failed.', red);
	test := KEEP_RUNNING
end;

BEGIN
	test()
END.

