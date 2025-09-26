<cfscript>
	param name="form.message" type="string" default="";
	// If a message is available, push it onto the queue for our EventSource / server-sent
	// event stream.
	if ( form.message.len() ) {
		application.messageQueue.put({
			id: createUniqueId(),
			text: form.message.trim(),
			createdBy: "Ben Nadel"
		});
	}
</cfscript>
<cfoutput>

	<!doctype html>
	<html lang="en">
	<head>
		<meta charset="utf-8" />
		<link rel="stylesheet" type="text/css" href="./styles.css"></link>
	</head>
	<body>

		<h1>
			Send a Message to the Queue
		</h1>

		<form method="post">
			<input
				type="text"
				name="message"
				placeholder="Message..."
				size="50"
			/>
			<button type="submit">
				Send to Queue
			</button>
		</form>

		<script type="text/javascript">
			// For some reason, the "autofocus" attribute wasn't working consistently
			// inside the frameset.
			document.querySelector( "input" ).focus();
		</script>

	</body>
	</html>

</cfoutput>