use Test::More tests => 8;

use Data::Dumper;
use Net::Rexster::Request;
use Test::Fake::HTTPD;
use JSON;

my $httpd = run_http_server {
    my $request = shift;
    return [
        200,
        [ 'Content-Type' => 'application/json' ],
        [ '{"name" : "Mike"}' ]
        ];
   };

my $req = new Net::Rexster::Request;
my $res = $req->get($httpd->endpoint);
isa_ok($res, "Net::Rexster::Response");
is("Mike", $res->content->{'name'}, "http GET request returns as expected");

$res = $req->post($httpd->endpoint);
isa_ok($res, "Net::Rexster::Response");
is("Mike", $res->content->{'name'}, "http POST request returns as expected");

$res = $req->put($httpd->endpoint);
isa_ok($res, "Net::Rexster::Response");
is("Mike", $res->content->{'name'}, "http PUT request returns as expected");

$res = $req->delete($httpd->endpoint);
isa_ok($res, "Net::Rexster::Response");
is("Mike", $res->content->{'name'}, "http DELETE request returns as expected");
