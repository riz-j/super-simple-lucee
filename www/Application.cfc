component
	output = false
	hint = "I define the application settings and event handlers."
	{

	// Define the application settings.
	this.name = "ServerSentEvents";
	this.applicationTimeout = createTimeSpan( 1, 0, 0, 0 );
	this.sessionTimeout = false;
	this.setClientCookies = false;

	// ---
	// LIFE-CYCLE EVENTS.
	// ---

	/**
	* I run once to initialize the application state.
	*/
	public void function onApplicationStart() {

		// The LinkedBlockingQueue is really just a fancy Array that has a .poll() method
		// that will block the current request and wait for an item (for a given timeout)
		// to become available. This will be handy in our EventSource target.
		application.messageQueue = createObject( "java", "java.util.concurrent.LinkedBlockingQueue" )
			.init()
		;

	}

}