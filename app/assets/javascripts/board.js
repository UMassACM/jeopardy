$(document).ready(function(){
	//check if game is in progress, init variables/local store
	//	then display settings
	initGame();
});

function initGame()
{
	$("td").each(function(){
		//$(this).attr("onclick", 
		//$(this).css(
	});
	
	//var foo = localStorage["bar"];
	if(!gameInProgress())
	{
		localStorage["round"] = "0";
	}
}

function gameInProgress()
{
	return false; //temp
}

function selectQuestion(category, question)
{
	var r,c,q;
	r = localStorage["round"];
	localStorage["round"+r+"category"+category+"question"+question] = "true";
	var selector = $("#round"+r+" > tbody > .question"+question+" > .category"+category);
	selector.css("background", "gray");
	console.log(selector);
	
	var url = "/board/question.json";
	var params = "?id=" + GAME_ID + "&round=" + localStorage["round"] + "&category=" + category + "&amount=" + question;
	var json = jQuery.parseJSON(ajax(url+params));
	console.log(ajax(url+params));
	displayQuestion(json);
}

function testAjax()
{
	//jQuery.ajax();
//	/board/question.json?amount=0&category=0&id=71&round=0
	//var resp = jQuery.getJSON("/board/question.json?amount=0&category=0&id=71&round=0");
	var url = "/board/question.json?amount=0&category=0&id=71&round=0";
	var resp = jQuery.get("/board/question.json?amount=0&category=0&id=71&round=0");
	
	console.log(ajax(url));
	var json = jQuery.parseJSON(ajax(url));
	console.log(json.prompt);
	console.log(json.response);
	
	displayQuestion(json);
}

function displayQuestion(json)
{
	var ques = $("#question");
	$("#prompt").html(json.prompt);
	$("#response").html(json.response);
	$("#round0").hide();
	$("#round1").hide();
	$("#question").show();
}

function ajax(url)
{
	var request;
	if(window.XMLHttpRequest){
		request = new XMLHttpRequest()
	}
	else {
		request = new ActiveXObject("Microsoft.XMLHTTP");
	}
	request.onreadystatechange = function(){
		if(request.readyState==4 && request.status==200)
		{
			return request.responseText;
		}
	}
	request.open("GET", url, false);
	request.send();
	return request.responseText;
}

function showAnswer()
{
	$("#response").show();
}
function showBoard()
{
	$("#question").hide();
	$("#response").hide();
	//check round
	//if(localStorage["round"] == "0");
	$("#round0").show();
}
