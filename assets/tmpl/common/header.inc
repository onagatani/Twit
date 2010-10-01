<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3c.org/TR/html4/loose.dtd">
<html lang="ja">
<head>
<title>ADMIN</title>
<meta http-equiv="content-type" content="text/html;charset=utf8">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<link href="/css/main.css" rel="stylesheet" type="text/css" />

</head>
<body>
<!--container-->
<div id="container">
<!--header-->
<div id="header">
<h1>ADMIN [% title %]</h1>
<div align="right">[% IF member %][% member.name %]でログインしています LAST_LOGIN:[% member.updated_at %][% END %]</div>
</div>

<div id="menu">
<h3>TwitterAccount</h3> 
<ul>
<li><a class="menu" href="/member/twitter/">一覧</a></li>
<li><a class="menu" href="/member/twitter/oauth">新規</a></li>
</ul>
</div>

<!--contents-->
<div id="contents">

