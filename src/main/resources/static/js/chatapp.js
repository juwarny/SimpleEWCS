var stompClient = null;

const SERVER_SOCKET_API = "/wcs-real-chatting";
const DESTINATION_PREFIXS = "/chatapp";
const BROKER = "/realtime";
const MAPPING_NAME = "/chat";
const SEND_TO = "/realtime/message";
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
			uid: $("meta[name='uid']").attr("content"),
			context: $("#send-message").val(),
			chrno: $("meta[name='chrno']").attr("content"),
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
		clear($("#send-message"));
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

