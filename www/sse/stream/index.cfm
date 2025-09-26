<cfscript>
    setting requestTimeout = 120; // 2 minutes
	// Reset the output buffer and report the necessary content-type for EventSource.
	content
		type = "text/event-stream; charset=utf-8"
	;
	// By default, this Lucee CFML page a request timeout of 30-seconds. As such, let's
	// stop polling the queue before the request times-out.
	stopPollingAt = ( getTickCount() + ( 2 * 60 * 1000 ) );
	newline = chr( 10 );
	TimeUnit = createObject( "java", "java.util.concurrent.TimeUnit" );
	while ( getTickCount() < stopPollingAt ) {
		// The LinkedBlockingQueue will block-and-wait for a new message. In this case,
		// I'm just blocking for up to 1-second since we're inside a while-loop that will
		// quickly re-enter the polling.
		message = application.messageQueue.poll( 1, TimeUnit.Seconds );
		if ( isNull( message ) ) {
			continue;
		}
		// By default, the EventSource uses "message" events. However, we're going to
		// provide a custom name for our event, "cfmlMessage". This will be the type of
		// event-listener that our client-side code will bind-to.
		echo( "event: cfmlMessage" & newline )
		echo( "id: #message.id#" & newline );
		echo( "data: " & serializeJson( message ) & newline );
		// Send an additional newline to denote the end-of-message.
		echo( newline );
		flush;
	}
</cfscript>