#!/usr/local/bin/perl5.8.9 -w -I /usr/local/share/perl/5.8.8

use strict;
use warnings;

use CGI;
use CGI qw/escape unescape/;
use CGI::Carp qw(fatalsToBrowser warningsToBrowser);
use Data::Dumper;
use JavaScript::Packer;

#####
 
my $page = "/var/www/vhosts/thatsthat.co.uk/cgi-bin/distributor/CURRENT-js/unpacked-mootools-core131.js"; ### packs ok
#my $page = "/var/www/vhosts/thatsthat.co.uk/cgi-bin/distributor/CURRENT-js/packed-mootools-core131.js"; ### dumps core

#####

my $debug = "";

open(HFILE,"<$page") or html_out("error: open $page failed: $! ");
flock (HFILE,2);
my @lines = <HFILE>;
close(HFILE);

my $js = join "", @lines;
my $packer = JavaScript::Packer->init();
$packer->minify(\$js,{compress => 'best'});

html_out("$page = $js");

exit;


sub html_out{
my ($io) = @_;
print "Content-type: text/html\n\n";
print <<_HTML_;
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en">
<head>
<meta http-equiv="Content-Type" content="application/xhtml+xml; charset=utf-8" />
<title>Debug</title>
</head>
	<body>			
		<div>
			$io
		</div>
	</body>
</html>
_HTML_

}