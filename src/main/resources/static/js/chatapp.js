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
    $("#received-message").append("<tr>");
    $("#received-message").append("<td>"+ message.uid +"</td>");
    $("#received-message").append("<td>"+ message.context +"</td>");
    $("#received-message").append("</tr>")
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

