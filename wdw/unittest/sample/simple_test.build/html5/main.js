
//Change this to true for a stretchy canvas!
//
var RESIZEABLE_CANVAS=false;

//Start us up!
//
window.onload=function( e ){

	if( RESIZEABLE_CANVAS ){
		window.onresize=function( e ){
			var canvas=document.getElementById( "GameCanvas" );

			//This vs window.innerWidth, which apparently doesn't account for scrollbar?
			var width=document.body.clientWidth;
			
			//This vs document.body.clientHeight, which does weird things - document seems to 'grow'...perhaps canvas resize pushing page down?
			var height=window.innerHeight;			

			canvas.width=width;
			canvas.height=height;
		}
		window.onresize( null );
	}
	
	game_canvas=document.getElementById( "GameCanvas" );
	game_console=document.getElementById( "GameConsole" );
	
	
	try{
		bbInit();
		bbMain();
	}catch( ex ){
		if( ex ) alert( ex );
		return;
	}
	
	if( game_runner!=null ){
		game_runner();
	}
}

//Globals
var game_canvas;
var game_console;
var game_runner;

//${METADATA_BEGIN}
var META_DATA="";

//${METADATA_END}
function getMetaData( path,key ){	
	var i=META_DATA.indexOf( "["+path+"]" );
	if( i==-1 ) return "";
	i+=path.length+2;

	var e=META_DATA.indexOf( "\n",i );
	if( e==-1 ) e=META_DATA.length;

	i=META_DATA.indexOf( ";"+key+"=",i )
	if( i==-1 || i>=e ) return "";
	i+=key.length+2;

	e=META_DATA.indexOf( ";",i );
	if( e==-1 ) return "";

	return META_DATA.slice( i,e );
}

function loadString( path ){
	if( path=="" ) return "";
//${TEXTFILES_BEGIN}
		return "";

//${TEXTFILES_END}
}

function loadImage( path,onloadfun ){
	var ty=getMetaData( path,"type" );
	if( ty.indexOf( "image/" )!=0 ) return null;

	var image=new Image();
	
	image.meta_width=parseInt( getMetaData( path,"width" ) );
	image.meta_height=parseInt( getMetaData( path,"height" ) );
	image.onload=onloadfun;
	image.src="data/"+path;
	
	return image;
}

function loadAudio( path ){
	var audio=new Audio( "data/"+path );
	return audio;
}

//${TRANSCODE_BEGIN}

// Javascript Monkey runtime.
//
// Placed into the public domain 24/02/2011.
// No warranty implied; use at your own risk.

//***** JavaScript Runtime *****

var obj_id=0;
var err_info="";
var err_stack=[];

var D2R=0.017453292519943295;
var R2D=57.29577951308232;

function push_err(){
	err_stack.push( err_info );
}

function pop_err(){
	err_info=err_stack.pop();
}

function stackTrace(){
	var str="";
	push_err();
	err_stack.reverse();
	for( var i=0;i<err_stack.length;++i ){
		str+=err_stack[i]+"\n";
	}
	err_stack.reverse();
	pop_err();
	return str;
}

function print( str ){
	if( game_console ){
		game_console.value+=str+"\n";
	}
	if( window.console!=undefined ){
		window.console.log( str );
	}
}

function error( err ){
	throw err;
}

function dbg_object( obj ){
	if( obj ) return obj;
	error( "Null object access" );
}

function dbg_array( arr,index ){
	if( index>=0 && index<arr.length ) return arr;
	error( "Array index out of range" );
}

function new_bool_array( len ){
	var arr=Array( len );
	for( var i=0;i<len;++i ) arr[i]=false;
	return arr;
}

function new_number_array( len ){
	var arr=Array( len );
	for( var i=0;i<len;++i ) arr[i]=0;
	return arr;
}

function new_string_array( len ){
	var arr=Array( len );
	for( var i=0;i<len;++i ) arr[i]='';
	return arr;
}

function new_array_array( len ){
	var arr=Array( len );
	for( var i=0;i<len;++i ) arr[i]=[];
	return arr;
}

function new_object_array( len ){
	var arr=Array( len );
	for( var i=0;i<len;++i ) arr[i]=null;
	return arr;
}

function resize_bool_array( arr,len ){
	var i=arr.length;
	arr=arr.slice(0,len);
	if( len<=i ) return arr;
	arr.length=len;
	while( i<len ) arr[i++]=false;
	return arr;
}

function resize_number_array( arr,len ){
	var i=arr.length;
	arr=arr.slice(0,len);
	if( len<=i ) return arr;
	arr.length=len;
	while( i<len ) arr[i++]=0;
	return arr;
}

function resize_string_array( arr,len ){
	var i=arr.length;
	arr=arr.slice(0,len);
	if( len<=i ) return arr;
	arr.length=len;
	while( i<len ) arr[i++]="";
	return arr;
}

function resize_array_array( arr,len ){
	var i=arr.length;
	arr=arr.slice(0,len);
	if( len<=i ) return arr;
	arr.length=len;
	while( i<len ) arr[i++]=[];
	return arr;
}

function resize_object_array( arr,len ){
	var i=arr.length;
	arr=arr.slice(0,len);
	if( len<=i ) return arr;
	arr.length=len;
	while( i<len ) arr[i++]=null;
	return arr;
}

function string_compare( lhs,rhs ){
	var n=Math.min( lhs.length,rhs.length ),i,t;
	for( i=0;i<n;++i ){
		t=lhs.charCodeAt(i)-rhs.charCodeAt(i);
		if( t ) return t;
	}
	return lhs.length-rhs.length;
}

function string_replace( str,find,rep ){	//no unregex replace all?!?
	var i=0;
	for(;;){
		i=str.indexOf( find,i );
		if( i==-1 ) return str;
		str=str.substring( 0,i )+rep+str.substring( i+find.length );
		i+=rep.length;
	}
}

function string_trim( str ){
	var i=0,i2=str.length;
	while( i<i2 && str.charCodeAt(i)<=32 ) i+=1;
	while( i2>i && str.charCodeAt(i2-1)<=32 ) i2-=1;
	return str.slice( i,i2 );
}

function string_starts_with( str,substr ){
	return substr.length<=str.length && str.slice(0,substr.length)==substr;
}

function string_ends_with( str,substr ){
	return substr.length<=str.length && str.slice(str.length-substr.length,str.length)==substr;
}

function object_downcast( obj,clas ){
	if( obj instanceof clas ) return obj;
	return null;
}

function object_implements( obj,iface ){
	if( obj && obj.implments && obj.implments[iface] ) return obj;
	return null;
}

function extend_class( clas ){
	var tmp=function(){};
	tmp.prototype=clas.prototype;
	return new tmp;
}
function bb_testsuite_TestSuite(){
	Object.call(this);
	this.bb_tests=null;
}
function bb_testsuite_new(){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/testsuite.monkey<23>";
	this.bb_tests=bb_list_new.call(new bb_list_List);
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/testsuite.monkey<22>";
	var bbt_=this;
	pop_err();
	return bbt_;
}
bb_testsuite_TestSuite.prototype.bbm_RegisterTest=function(bbt_t){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/testsuite.monkey<30>";
	if(this.bb_tests.bbm_Contains(bbt_t)==false){
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/testsuite.monkey<31>";
		this.bb_tests.bbm_AddLast(bbt_t);
	}
	pop_err();
}
bb_testsuite_TestSuite.prototype.bbm_Run=function(){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/testsuite.monkey<40>";
	print("Starting Test Suite...");
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/testsuite.monkey<42>";
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/testsuite.monkey<42>";
	var bbt_=this.bb_tests.bbm_ObjectEnumerator();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/testsuite.monkey<42>";
	while(bbt_.bbm_HasNext()){
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/testsuite.monkey<42>";
		var bbt_t=bbt_.bbm_NextObject();
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/testsuite.monkey<43>";
		bbt_t.bbm_Run();
	}
	pop_err();
}
function bb_test_Test(){
	Object.call(this);
	this.bb_testName="";
	this.bb_units=bb_list_new.call(new bb_list_List);
}
function bb_test_new(){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<18>";
	var bbt_=this;
	pop_err();
	return bbt_;
}
bb_test_Test.prototype.bbm_TestName=function(){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<68>";
	pop_err();
	return this.bb_testName;
}
bb_test_Test.prototype.bbm_TestName2=function(bbt_n){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<74>";
	this.bb_testName=bbt_n;
	pop_err();
}
bb_test_Test.prototype.bbm_RegisterUnitTest=function(bbt_u){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<80>";
	this.bb_units.bbm_AddLast(bbt_u);
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<81>";
	bbt_u.bbm_RegisterOwner(this);
	pop_err();
}
bb_test_Test.prototype.bbm_SetUp=function(){
	push_err();
	pop_err();
}
bb_test_Test.prototype.bbm_TearDown=function(){
	push_err();
	pop_err();
}
bb_test_Test.prototype.bbm_Run=function(){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<49>";
	print("-Starting Test '"+this.bb_testName+"' containing "+String(this.bb_units.bbm_Count())+" unit tests.");
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<51>";
	var bbt_runnedTests=0;
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<52>";
	var bbt_testResults="";
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<53>";
	var bbt_currentStatus="";
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<55>";
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<55>";
	var bbt_=this.bb_units.bbm_ObjectEnumerator();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<55>";
	while(bbt_.bbm_HasNext()){
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<55>";
		var bbt_u=bbt_.bbm_NextObject();
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<56>";
		this.bbm_SetUp();
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<57>";
		bbt_u.bbm_Run();
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<58>";
		this.bbm_TearDown();
	}
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/test.monkey<47>";
	pop_err();
	return 0;
}
function bb_list_List(){
	Object.call(this);
	this.bb__head=bb_list_new2.call(new bb_list_Node);
}
function bb_list_new(){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<13>";
	var bbt_=this;
	pop_err();
	return bbt_;
}
bb_list_List.prototype.bbm_Equals=function(bbt_lhs,bbt_rhs){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<16>";
	var bbt_=bbt_lhs==bbt_rhs;
	pop_err();
	return bbt_;
}
bb_list_List.prototype.bbm_Contains=function(bbt_value){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<41>";
	var bbt_node=dbg_object(this.bb__head).bb__succ;
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<42>";
	while(bbt_node!=this.bb__head){
		err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<43>";
		if(this.bbm_Equals(dbg_object(bbt_node).bb__data,bbt_value)){
			err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<43>";
			pop_err();
			return true;
		}
		err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<44>";
		bbt_node=dbg_object(bbt_node).bb__succ;
	}
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<40>";
	pop_err();
	return false;
}
bb_list_List.prototype.bbm_AddLast=function(bbt_data){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<61>";
	var bbt_=bb_list_new3.call(new bb_list_Node,this.bb__head,dbg_object(this.bb__head).bb__pred,bbt_data);
	pop_err();
	return bbt_;
}
bb_list_List.prototype.bbm_ObjectEnumerator=function(){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<91>";
	var bbt_=bb_list_new4.call(new bb_list_Enumerator,this);
	pop_err();
	return bbt_;
}
bb_list_List.prototype.bbm_Count=function(){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<28>";
	var bbt_n=0;
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<28>";
	var bbt_node=dbg_object(this.bb__head).bb__succ;
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<29>";
	while(bbt_node!=this.bb__head){
		err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<30>";
		bbt_node=dbg_object(bbt_node).bb__succ;
		err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<31>";
		bbt_n+=1;
	}
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<33>";
	pop_err();
	return bbt_n;
}
function bb_simple_test_DummyTest(){
	bb_test_Test.call(this);
	this.bb_testObject=null;
}
bb_simple_test_DummyTest.prototype=extend_class(bb_test_Test);
function bb_simple_test_new(){
	push_err();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<35>";
	bb_test_new.call(this);
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<35>";
	var bbt_=this;
	pop_err();
	return bbt_;
}
bb_simple_test_DummyTest.prototype.bbm_SetUp=function(){
	push_err();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<50>";
	this.bb_testObject=bb_simple_test_new6.call(new bb_simple_test_Dummy);
	pop_err();
}
bb_simple_test_DummyTest.prototype.bbm_TearDown=function(){
	push_err();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<55>";
	this.bb_testObject=null;
	pop_err();
}
bb_simple_test_DummyTest.prototype.bbm_TestObject=function(){
	push_err();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<43>";
	pop_err();
	return this.bb_testObject;
}
function bb_list_Node(){
	Object.call(this);
	this.bb__succ=null;
	this.bb__pred=null;
	this.bb__data=null;
}
function bb_list_new2(){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<167>";
	this.bb__succ=this;
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<168>";
	this.bb__pred=this;
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<166>";
	var bbt_=this;
	pop_err();
	return bbt_;
}
function bb_list_new3(bbt_succ,bbt_pred,bbt_data){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<173>";
	this.bb__succ=bbt_succ;
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<174>";
	this.bb__pred=bbt_pred;
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<175>";
	dbg_object(this.bb__succ).bb__pred=this;
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<176>";
	dbg_object(this.bb__pred).bb__succ=this;
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<177>";
	this.bb__data=bbt_data;
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<172>";
	var bbt_=this;
	pop_err();
	return bbt_;
}
function bb_unit_Unit(){
	Object.call(this);
	this.bb_owner=null;
}
function bb_unit_new(){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/unit.monkey<38>";
	var bbt_=this;
	pop_err();
	return bbt_;
}
bb_unit_Unit.prototype.bbm_RegisterOwner=function(bbt_t){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/unit.monkey<69>";
	this.bb_owner=bbt_t;
	pop_err();
}
bb_unit_Unit.prototype.bbm_Run=function(){
	push_err();
	pop_err();
}
function bb_simple_test_DummyUnit(){
	bb_unit_Unit.call(this);
}
bb_simple_test_DummyUnit.prototype=extend_class(bb_unit_Unit);
function bb_simple_test_new2(){
	push_err();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<68>";
	bb_unit_new.call(this);
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<68>";
	var bbt_=this;
	pop_err();
	return bbt_;
}
bb_simple_test_DummyUnit.prototype.bbm_DoTest=function(bbt_d){
	push_err();
	pop_err();
}
bb_simple_test_DummyUnit.prototype.bbm_Run=function(){
	push_err();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<72>";
	this.bbm_DoTest(object_downcast((this.bb_owner),bb_simple_test_DummyTest).bbm_TestObject());
	pop_err();
}
function bb_simple_test_T_Constructor(){
	bb_simple_test_DummyUnit.call(this);
}
bb_simple_test_T_Constructor.prototype=extend_class(bb_simple_test_DummyUnit);
function bb_simple_test_new3(){
	push_err();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<77>";
	bb_simple_test_new2.call(this);
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<77>";
	var bbt_=this;
	pop_err();
	return bbt_;
}
bb_simple_test_T_Constructor.prototype.bbm_DoTest=function(bbt_d){
	push_err();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<79>";
	bb_assert_AssertNotNull((bbt_d),"Object must not be Null.");
	pop_err();
}
function bb_simple_test_T_Add(){
	bb_simple_test_DummyUnit.call(this);
}
bb_simple_test_T_Add.prototype=extend_class(bb_simple_test_DummyUnit);
function bb_simple_test_new4(){
	push_err();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<84>";
	bb_simple_test_new2.call(this);
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<84>";
	var bbt_=this;
	pop_err();
	return bbt_;
}
bb_simple_test_T_Add.prototype.bbm_DoTest=function(bbt_d){
	push_err();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<86>";
	bb_assert_AssertEquals(bbt_d.bbm_Add(5,6),11,"Result must be 11.");
	pop_err();
}
function bb_simple_test_T_AddFail(){
	bb_simple_test_DummyUnit.call(this);
}
bb_simple_test_T_AddFail.prototype=extend_class(bb_simple_test_DummyUnit);
function bb_simple_test_new5(){
	push_err();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<91>";
	bb_simple_test_new2.call(this);
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<91>";
	var bbt_=this;
	pop_err();
	return bbt_;
}
bb_simple_test_T_AddFail.prototype.bbm_DoTest=function(bbt_d){
	push_err();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<93>";
	bb_assert_AssertEquals(bbt_d.bbm_Add(5,6),12,"Result must be 11.");
	pop_err();
}
function bb_list_Enumerator(){
	Object.call(this);
	this.bb__list=null;
	this.bb__curr=null;
}
function bb_list_new4(bbt_list){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<200>";
	this.bb__list=bbt_list;
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<201>";
	this.bb__curr=dbg_object(dbg_object(bbt_list).bb__head).bb__succ;
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<199>";
	var bbt_=this;
	pop_err();
	return bbt_;
}
function bb_list_new5(){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<197>";
	var bbt_=this;
	pop_err();
	return bbt_;
}
bb_list_Enumerator.prototype.bbm_HasNext=function(){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<205>";
	var bbt_=this.bb__curr!=dbg_object(this.bb__list).bb__head;
	pop_err();
	return bbt_;
}
bb_list_Enumerator.prototype.bbm_NextObject=function(){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<209>";
	var bbt_data=dbg_object(this.bb__curr).bb__data;
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<210>";
	this.bb__curr=dbg_object(this.bb__curr).bb__succ;
	err_info="D:/Monkey/MonkeyPro44/modules/monkey/list.monkey<211>";
	pop_err();
	return bbt_data;
}
function bbMain(){
	push_err();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<9>";
	var bbt_s=bb_testsuite_new.call(new bb_testsuite_TestSuite);
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<12>";
	var bbt_t=bb_simple_test_new.call(new bb_simple_test_DummyTest);
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<13>";
	bbt_t.bbm_TestName2("Dummy Test");
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<14>";
	bbt_s.bbm_RegisterTest(bbt_t);
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<17>";
	bbt_t.bbm_RegisterUnitTest(bb_simple_test_new3.call(new bb_simple_test_T_Constructor));
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<18>";
	bbt_t.bbm_RegisterUnitTest(bb_simple_test_new4.call(new bb_simple_test_T_Add));
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<19>";
	bbt_t.bbm_RegisterUnitTest(bb_simple_test_new5.call(new bb_simple_test_T_AddFail));
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<22>";
	bbt_s.bbm_Run();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<6>";
	pop_err();
	return 0;
}
function bb_simple_test_Dummy(){
	Object.call(this);
}
function bb_simple_test_new6(){
	push_err();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<27>";
	var bbt_=this;
	pop_err();
	return bbt_;
}
bb_simple_test_Dummy.prototype.bbm_Add=function(bbt_i1,bbt_i2){
	push_err();
	err_info="D:/Monkey/MySolutions/mutated-monkey/wdw/unittest/sample/simple_test.monkey<29>";
	var bbt_=bbt_i1+bbt_i2;
	pop_err();
	return bbt_;
}
function bb_assert_AssertError(bbt_msg){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<13>";
	print(bbt_msg);
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<14>";
	error(bbt_msg);
	pop_err();
}
function bb_assert_AssertNotNull(bbt_o,bbt_message){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<120>";
	if(bbt_o==null){
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<120>";
		bb_assert_AssertError("Object AssertNotNull: "+bbt_message);
	}
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<123>";
	if(bbt_o==null){
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<123>";
		pop_err();
		return false;
	}
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<124>";
	pop_err();
	return true;
}
function bb_assert_AssertEquals(bbt_value,bbt_expected,bbt_message){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<43>";
	if(bbt_value!=bbt_expected){
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<43>";
		bb_assert_AssertError("Int AssertEquals: "+bbt_message);
	}
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<46>";
	if(bbt_value!=bbt_expected){
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<46>";
		pop_err();
		return false;
	}
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<47>";
	pop_err();
	return true;
}
function bb_assert_AssertEquals2(bbt_value,bbt_expected,bbt_message){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<54>";
	if(bbt_value!=bbt_expected){
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<54>";
		bb_assert_AssertError("Float AssertEquals: "+bbt_message);
	}
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<57>";
	if(bbt_value!=bbt_expected){
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<57>";
		pop_err();
		return false;
	}
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<58>";
	pop_err();
	return true;
}
function bb_assert_AssertEquals3(bbt_value,bbt_expected,bbt_message){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<65>";
	if(bbt_value!=bbt_expected){
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<65>";
		bb_assert_AssertError("Object AssertEquals: "+bbt_message);
	}
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<68>";
	if(bbt_value!=bbt_expected){
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<68>";
		pop_err();
		return false;
	}
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<69>";
	pop_err();
	return true;
}
function bb_assert_AssertEquals4(bbt_value,bbt_expected,bbt_message){
	push_err();
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<76>";
	if(bbt_value!=bbt_expected){
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<76>";
		bb_assert_AssertError("String AssertEquals: "+bbt_message);
	}
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<79>";
	if(bbt_value!=bbt_expected){
		err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<79>";
		pop_err();
		return false;
	}
	err_info="D:/Monkey/MonkeyPro44/modules/wdw/unittest/src/assert.monkey<80>";
	pop_err();
	return true;
}
function bbInit(){
}
//${TRANSCODE_END}
