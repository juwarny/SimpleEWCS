package com.wcs.websocket;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class ChattingMessage {

    private String uid;
    private Long chrno;
    private Long chtno;
	private String context;
	  
}
