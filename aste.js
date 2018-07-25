var express=require('express');
var bodyParser=require('body-parser');
var cors=require('cors');
var path=require('path');
var mysql=require('mysql');
var fs=require('fs');


var app=express();

app.use(bodyParser());
app.use(cors());



var con=mysql.createConnection({
	host:"localhost",
	user:"root",
	password:"sagrika2016",
	database:"student"
	
});


con.connect(function(err){
	if(err) throw err;
	console.log("Connected");
});



app.get('/disp',function(req,res){
	var sql="select * from marks inner join entries where marks.id=entries.id order by marks.id";
	con.query(sql,function(err,result,fields){
		if(err) throw err;
		res.render('../value/disp.ejs',{data:result});
});
	
});

app.get('/event-add',function(req,res){
	
		res.render('../value/event/form.ejs',{dest:'/add',data:[{id:'',marks1:'',marks2:'',marks3:''}]});
		
	
});

app.post('/add',function(req,res){
	var sql="insert into marks values (" + con.escape(req.body.id) + "," + con.escape(req.body.marks1) +"," + con.escape(req.body.marks2) + "," + con.escape(req.body.marks3) + ")";
	con.query(sql,function(err,result){
		if(err) throw err;	
		console.log("ho gaya mann");
		res.redirect('/disp');
			
});

});



app.get('/event-delete/:id',function(req,res){
	console.log(req.params.id);
	var sql="delete from marks where id=" + con.escape(req.params.id) + "";
	con.query(sql,function(err,result){
		if(err) throw err;	
		console.log("ho gaya mann");
		res.redirect('/disp');
			
	});
	
		
		
	
});

app.get('/event-edit/:id',function(req,res){
	console.log(req.params.id);
	var sql="select * from marks where id=" + con.escape(req.params.id) + "";
	con.query(sql,function(err,result,fields){
		if(err) throw err;
		//console.log(result[0].id);
		res.render('../value/event/form.ejs',{dest:'/edit',data:result});
});
	
		
		
	
});

app.post('/edit',function(req,res){
	console.log(req.body);
	var sql="update marks set marks1=" + con.escape(req.body.marks1) + ",marks2=" + con.escape(req.body.marks2) +",marks3=" + con.escape(req.body.marks3) + " where id =" + con.escape(req.body.id) +" ";
	con.query(sql,function(err,result){
		if(err) throw err;	
		//res.redirect('/disp');
			
});
var per=(parseInt(req.body.marks1)+parseInt(req.body.marks2)+parseInt(req.body.marks3))/3;
console.log(per);
var sql="update entries set percentage=" + con.escape(per) + " where id=" + con.escape(req.body.id) + "";
con.query(sql,function(err,result){
		if(err) throw err;	
		res.redirect('/disp');
			
});


});





app.listen(1337,function(){
	console.log('chal raha hain');
});