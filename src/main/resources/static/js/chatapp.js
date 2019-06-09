var stompClient = null;


var uid = $("meta[name='uid']").attr("content");
var chrno = $("meta[name='chrno']").attr("content");
var root = $("meta[name='root']").attr("content");

const SERVER_SOCKET_API = root+"wcs-real-chatting";
const DESTINATION_PREFIXS = "/chatapp";
const BROKER = "/realtime";
const MAPPING_NAME = "/chat";
const SEND_TO = "/realtime/"+chrno;
const ENTER_KEY = 13;



function setConnected(connected) {
    $("#connect").prop("disabled", connected);
    $("#disconnect").prop("disabled", !connected);
    if (connected) {
        $("#conversation").show();
    }
    else {
        $("#conversation").hide();
    }
    $("received-message").html("");
}

function connect() {
    var socket = new SockJS(SERVER_SOCKET_API);
    stompClient = Stomp.over(socket);
    stompClient.connect({}, function (frame) {
        setConnected(true);
        console.log('Connected: ' + frame);
        stompClient.subscribe(SEND_TO, function (message) {
            showMessage(JSON.parse(message.body));
        });
    });
}

function disconnect() {
    if (stompClient !== null) {
        stompClient.disconnect();
    }
    setConnected(false);
    console.log("Disconnected");
}

function sendMessage() {
	var message = {
			uid: uid,
			context: $("#send-message").val(),
			chrno: chrno,
			chtno: null
	}
    stompClient.send(DESTINATION_PREFIXS + MAPPING_NAME, {}, JSON.stringify(message));
}

function showMessage(message) {
	var str = "";
	if(uid==message.uid){
		str += "<div class='row justify-content-end'>"
			+ "<div class='col-sm-4'>"
			+ "<p class='text-right'>"+message.uid+"</p>"
			+ "<div class='card rounded-pill'>"
			+ "<div class='card-body py-3 px-3 bg-primary rounded-pill'>"
			+ "<p class='card-text text-white'>"+message.context +"</p>"
			+ "</div>" + "</div>" + "</div>" + "</div>";
	}else{
		
		str += "<div class='row justify-content-start'>"
			+ "<div class='col-sm-4'>"
			+ "<p>"+message.uid+"</p>"
			+ "<div class='card rounded-pill'>"
			+ "<div class='card-body py-3 px-3 rounded-pill'>"
			+ "<p class='card-text'>"+message.context +"</p>"
			+ "</div>" + "</div>" + "</div>" + "</div>";
	}
	$("#received-message").append(str);
}

function chatKeyDownHandler(e){
	if(e.which === ENTER_KEY && $.trim($("#send-message").val()) !== ""){
		sendMessage();
		$("#send-message").val("");
	}
}

$(function () {
    $("form").on('submit', function (e) {
        e.preventDefault();
    });
    $( "#connect" ).click(function() { connect(); });
    $( "#disconnect" ).click(function() { disconnect(); });
    $( "#send" ).click(function() { sendMessage(); });
    $("#send-message").keydown(chatKeyDownHandler);

});

