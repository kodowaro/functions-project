program hash_table;

uses crt;

const 
	MAX_SIZE = 10; 
	BUCKET_MAX_SIZE = 10;

type 
	key_t = integer;
	bucket_t = array[1..BUCKET_MAX_SIZE] of key_t;
	hashtable_t = array[1..MAX_SIZE] of bucket_t; 
	list_t = array[1..MAX_SIZE*BUCKET_MAX_SIZE] of key_t;
var  
	hashtable: hashtable_t;
	bsizes: array[1..MAX_SIZE] of integer;
	size: integer; 
	logger : text;

function Hash(key: key_t): integer;
begin
	hash := 1;
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

procedure MakePPrintLog(log_name: string);
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
	
	function ASSERT_EQ(got, expected : string) : boolean;
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
	
	procedure empty();
	begin
		TEST_NAME := 'empty';
		Clear();
		ASSERT_EQ( GetSize(), 0 );
		if (KEEP_RUNNING) then writeln(TEST_NAME, ': OK')
	end;
	
	procedure simple();
	begin
		TEST_NAME := 'simple';
		Clear();
		ASSERT_EQ( GetSize(), 0 );
		ASSERT_TRUE( Add(1) );
		ASSERT_EQ( GetSize(), 1 );
		ASSERT_TRUE( Find(1) );
		ASSERT_FALSE( Find(2) );
		ASSERT_FALSE( Add(1) );
		ASSERT_EQ( GetSize(), 1 );
		ASSERT_TRUE( Delete(1) );
		ASSERT_FALSE( Delete(2) );
		ASSERT_FALSE( Find(1) );
		ASSERT_EQ( GetSize(), 0 );
		if (KEEP_RUNNING) then writeln(TEST_NAME, ': OK')
	end;
	
	procedure add_correctness();
	var i: integer;
	begin
		TEST_NAME := 'add_correctness';
		Clear();
		ASSERT_EQ( GetSize(), 0 );
		for i:=1 to maxint do
			if i <= MAX_SIZE * BUCKET_MAX_SIZE 
				then ASSERT_TRUE( Add(i) )
				else ASSERT_FALSE( Add(i) );
		ASSERT_EQ( GetSize(), MAX_SIZE * BUCKET_MAX_SIZE );
		if (KEEP_RUNNING) then writeln(TEST_NAME, ': OK')
	end;
	
	procedure delete_correctness();
	var i: integer;
	begin
		TEST_NAME := 'delete_correctness';
		Clear();
		ASSERT_EQ( GetSize(), 0 );
		for i:=1 to MAX_SIZE * BUCKET_MAX_SIZE do
			ASSERT_TRUE( Add(i) );
		ASSERT_EQ( GetSize(), MAX_SIZE * BUCKET_MAX_SIZE );
		for i:=1 to maxint do
			if i <= MAX_SIZE * BUCKET_MAX_SIZE 
				then ASSERT_TRUE( Delete(i) )
				else ASSERT_FALSE( Delete(i) );
		if (KEEP_RUNNING) then writeln(TEST_NAME, ': OK')
	end;
	
	procedure find_correctness();
	var i: integer;
	begin
		TEST_NAME := 'find_correctness';
		Clear();
		ASSERT_EQ( GetSize(), 0 );
		for i:=1 to MAX_SIZE * BUCKET_MAX_SIZE do
			ASSERT_TRUE( Add(i) );
		ASSERT_EQ( GetSize(), MAX_SIZE * BUCKET_MAX_SIZE );
		for i:=1 to MAX_SIZE * BUCKET_MAX_SIZE  do
			if i mod 2 = 0 then ASSERT_TRUE( Delete(i) );
		for i:=1 to MAX_SIZE * BUCKET_MAX_SIZE do
			if i mod 2 = 0 then ASSERT_FALSE( Find(i) )
						   else ASSERT_TRUE( Find(i) );
		if (KEEP_RUNNING) then writeln(TEST_NAME, ': OK')
	end;
	
	procedure check_log_state(expected_log_name: string);
	var logger_expected, logger : text; line_expected, line: string;
	begin
		assign(logger_expected, 'logs/' + expected_log_name);
		assign(logger, 'state_logger.txt');
		reset(logger_expected);
		reset(logger);
		while not eof(logger_expected) and (KEEP_RUNNING) do begin
			readln(logger_expected, line_expected);
			readln(logger, line);
			ASSERT_EQ(line, line_expected)
		end
	end;
	
	procedure logger_append_correctness();
	var i: integer;
	begin
		Clear();
		MakePPrintLog('empty');
		Add(5);
		MakePPrintLog('single five');
		for i:=1 to 10 do Add(i);
		MakePPrintLog('some additions');
	end;
	
	procedure test_run();
	begin
		KEEP_RUNNING := true;
		if (KEEP_RUNNING) then empty();
		if (KEEP_RUNNING) then simple();
		if (KEEP_RUNNING) then add_correctness();
		if (KEEP_RUNNING) then delete_correctness();
		if (KEEP_RUNNING) then find_correctness();
	end;
	
	procedure logger_test_run();
	begin
		if (KEEP_RUNNING) then cprint('logger tests iteration', Cyan);
		if (KEEP_RUNNING) then empty();
		if (KEEP_RUNNING) then MakePPrintLog('empty table');
		if (KEEP_RUNNING) then check_log_state('empty_log.txt');
		
		if (KEEP_RUNNING) then simple();
		if (KEEP_RUNNING) then MakePPrintLog('empty simple');
		if (KEEP_RUNNING) then check_log_state('simple_log.txt');
		
		if (KEEP_RUNNING) then add_correctness();
		if (KEEP_RUNNING) then MakePPrintLog('Add');
		if (KEEP_RUNNING) then check_log_state('add_log.txt');
		
		if (KEEP_RUNNING) then delete_correctness();
		if (KEEP_RUNNING) then MakePPrintLog('Delete');
		if (KEEP_RUNNING) then check_log_state('delete_log.txt');
		
		if (KEEP_RUNNING) then find_correctness();
		if (KEEP_RUNNING) then MakePPrintLog('Find');
		if (KEEP_RUNNING) then check_log_state('find_log.txt');
		
		if (KEEP_RUNNING) then logger_append_correctness();
		if (KEEP_RUNNING) then check_log_state('logger_append_log.txt');
	end;
		
begin
	test_run();
	logger_test_run();
	if (KEEP_RUNNING) then cprint('Job succed.', green)
					  else cprint('Testing failed.', red);
	test := KEEP_RUNNING
end;

BEGIN
	test()
END.

