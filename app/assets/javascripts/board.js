$(document).ready(function(){
	//check if game is in progress, init variables/local store
	//	then display settings
	initGame();
});

var presenterWindow;
$(document).keypress(function(e)
{
	console.log(e.which);
	if(e.which == 96) //'`'
	{
		var w = window.open("/board/presenter");
		//presenterWindow = w;
		//$(w.document).html("test");
		//w.document.write("Testing");
		//w.document.write("<div id='response'></div>");
		//w.document.close();
		//w.document.getElementById("answer").innerHTML = "Hello World";
		var x = w.document.getElementById("answer").innerHTML;
		alert(x);
	}
	if(e.which == 114) //'r'
	{
		resetGameProgress();
	}
	if(e.which == 102) //'f'
	{
		window.location.pathname = "/board/final_jeopardy?id="+GAME_ID;
	}
	
});

function initGame()
{
	//initLocalStorage();
	//resetGameProgress();
	
	//restore in-progress game
	for(var i=0; i<6; i++)
	{
		for(var j=0; j<5; j++)
		{
			if(localStorage["game"+GAME_ID+"category"+i+"question"+j+"seen"] == "true")
			{
				var r = 0;
				$("#round"+r+" > tbody > .question"+j+" > .category"+i).children("a").css("visibility", "hidden");
			}
		}
	}
	
	if(!questionsRemaining() && window.location.pathname==="/board/index")
	{
		//redirect to final jeopardy
		//window.location.pathname = "/board/final_jeopardy?id="+GAME_ID;
	}
}

function initLocalStorage()
{
	for(var i=0; i<6; i++)
	{
		for(var j=0; j<5; j++)
		{
			localStorage["game"+GAME_ID+"category"+i+"question"+j+"seen"] = undefined;
		}
	}
	
	resetGameProgress();
}
function resetGameProgress()
{
	alert("resetting");
	for(var i=0; i<6; i++)
	{
		for(var j=0; j<5; j++)
		{
			localStorage["game"+GAME_ID+"category"+i+"question"+j+"seen"] = undefined;
		}
	}
}

function questionsRemaining()
{
	//return false;
	
	var seen_all = false;
	for(var i=0; i<6; i++)
	{
		for(var j=0; j<5; j++)
		{
			if(localStorage["game"+GAME_ID+"category"+i+"question"+j+"seen"] == undefined)
			{
				//alert("true");
				return true;
			}
		}
	}
	//return !seen_all;
	return false;
}

function selectQuestion(category, question)
{
	var r,c,q; //round,category,question
	r = localStorage["round"] | 0;
	localStorage["round"+r+"category"+category+"question"+question] = "true";
	var questionSelector = $("#round"+r+" > tbody > .question"+question+" > .category"+category);
	//TODO: save to localstorage
	localStorage["game"+GAME_ID+"category"+category+"question"+question+"seen"] = "true";
	
	var url = "/board/question.json";
	var params = "?id=" + GAME_ID + "&round=" + localStorage["round"] + "&category=" + category + "&amount=" + question;
	var json = jQuery.parseJSON(ajax(url+params));
	console.log(ajax(url+params));
	displayQuestion(json, questionSelector);
	questionSelector.children("a").css("visibility", "hidden"); //cannot select the same question again the same game
	if(presenterWindow) alert("presenter window");
	return false;
}

function displayQuestion(json, selector)
{
	//var selector = $("#round0 > tbody > .question3 > .category3");
	//var ques = $("#question");
	
	// Fill in the question template
	$("#prompt").html(json.prompt);
	$("#response").html(json.response);
	
	// Set the position/size of the template to match the question
	var w, h, x, y;
	w=selector.width();
	h=selector.height();
	x=selector.position().left;
	y=selector.position().top;
	var tmp = $("#question");	// get the question template
	tmp.width(w);
	tmp.height(h);
	tmp.css("left", x);
	tmp.css("top", y);
	
	//$("#round0").hide();
	//$("#round1").hide();
	$("#question").show();
	
	$("#question").animate(
	{
		top: 0,
		left: 0,
		width: '100%',
		height: '100%'
	}, 400);
	
	//If the presenter window is open, display the answer there
	if(presenterWindow)
	{
		var div = presenterWindow.document.getElementById("response");
		div.innerHTML = json.response;
	}
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
	
	//if(!questionsRemaining()) window.location.pathname = "/board/final_jeopardy?id="+GAME_ID;
}
