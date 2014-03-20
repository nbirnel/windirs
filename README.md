windirs
---------
A ruby gem to convert between Unix, Windows, and Cygwin paths.
NOTHING HAS BEEN IMPLEMENTED

Installation
---------
`gem install windirs`

or, if you want the latest and the greatest, 
or if you want the man page installed:

    git clone https://github.com/windirs
    cd windirs
    rake install

(use `sudo` as necessary)

Runtime Requirements
---------
ruby 

Build Requirements
---------
rake

Developer Requirements
---------
groff

Inspiration and History
---------


License
---------
© 2014 Noah Birnel
MIT license

[![Build Status](https://travis-ci.org/nbirnel/windirs.png?branch=master)](https://travis-ci.org/nbirnel/windirs)
[![Code Climate](https://codeclimate.com/github/nbirnel/windirs.png)](https://codeclimate.com/github/nbirnel/windirs)

Man page
---------
<html>
<head>
<meta name="generator" content="groff -Thtml, see www.gnu.org">
<meta http-equiv="Content-Type" content="text/html; charset=US-ASCII">
<meta name="Content-Style" content="text/css">
<title>windirs</title>

</head>
<body>

<h1 align="center">windirs</h1>

<a href="#NAME">NAME</a><br>
<a href="#SYNOPSIS">SYNOPSIS</a><br>
<a href="#DESCRIPTION">DESCRIPTION</a><br>
<a href="#OPTIONS">OPTIONS</a><br>
<a href="#EXAMPLES">EXAMPLES</a><br>
<a href="#SEE ALSO">SEE ALSO</a><br>
<a href="#BUGS">BUGS</a><br>
<a href="#LICENSE">LICENSE</a><br>

<hr>


<h2>NAME
<a name="NAME"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">windirs &minus;
translate Windows, Cygwin, and Unix paths</p>

<h2>SYNOPSIS
<a name="SYNOPSIS"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em"><b>windirs
[OPTIONS] [PATH]</b></p>

<h2>DESCRIPTION
<a name="DESCRIPTION"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em"><b>windirs</b>
translates Windows, Cygwin, and Unix paths to and fro.</p>

<h2>OPTIONS
<a name="OPTIONS"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em"><b>--help</b>
Print a brief usage message.</p>

<p style="margin-left:11%; margin-top: 1em"><b>--unix</b>
translate to unix. This is the default. <b>--cygwin</b>
translate to cygwin. <b>--windows</b> translate to
windows.</p>

<h2>EXAMPLES
<a name="EXAMPLES"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em"><b>windirs
--cygwin &rsquo;C:\Users\noah\Desktop&rsquo; <br>
/cygdrive/c/Users/noah/Desktop</b></p>

<h2>SEE ALSO
<a name="SEE ALSO"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em"><b>ruby(1) <br>
cygpath(1)</b></p>

<h2>BUGS
<a name="BUGS"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">It is
superfluous to <b>cygpath(1).</b> Probably others.</p>

<h2>LICENSE
<a name="LICENSE"></a>
</h2>


<p style="margin-left:11%; margin-top: 1em">Copyright 2014
Noah Birnel</p>

<p style="margin-left:11%; margin-top: 1em">MIT License</p>
<hr>
</body>
</html>
