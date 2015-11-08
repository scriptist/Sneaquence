<!doctype html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width">
	<title>Sneaquence</title>
	<link href='https://fonts.googleapis.com/css?family=Roboto:400,700' rel='stylesheet' type='text/css'>
	<link rel="stylesheet" href="/css/main.css">
	<link rel="stylesheet" href="/css/sneaquence.css">
	{% if ENV_DEVELOPMENT %}
		<script src="http://localhost:35729/livereload.js"></script>
	{% endif %}
</head>
<body>
	{% block content %}{% endblock %}
	<script src="/js/sneaquence.js" async></script>
</body>
</html>
