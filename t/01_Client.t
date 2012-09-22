use Test::More tests => 38; 
use Test::MockObject;
use Test::MockObject::Extends;
use Net::Rexster::Client;
use Net::Rexster::Request;

# Mock for Net::Rexster::Response  
my $mock = Test::MockObject->new();
$mock->set_always("get_results", "ok");
$mock->set_always("get_totalSize", 1);
$mock->set_always("get_graphs", 'test');

# Mock Net::Rexster::Request 
my $req = Net::Rexster::Request;
$req = Test::MockObject::Extends->new( $req );
$req->mock('get', sub { return $mock } );
$req->mock('post', sub { return $mock } );
$req->mock('put', sub { return $mock } );
$req->mock('delete', sub { return $mock } );

my $c = new Net::Rexster::Client(graph => "test", request => $req);

# GET 
is($c->get_graphs,"test", "get_graphs for /graphs");
isa_ok($c->get_graph,"Test::MockObject", "get_graph for /graphs/<graph>");
is("ok", $c->get_all_vertices, "get_all_vertices for /graphs/<graph>/vertices");
is("ok", $c->lookup_vertex("age","30"), "lookup_vertex for /graphs/<graph>/vertices?key=<key>&value=<value>");
is("ok", $c->get_vertex('#6:1'), "get_vertex for /graphs/<graph>/vertices/<id>");
is("ok", $c->outV(4), "outV for /graphs/<graph>/vertices/<id>/out");
is("ok", $c->inV(4), "inV for /graphs/<graph>/vertices/<id>/in");
is("ok", $c->bothV(4), "inV for /graphs/<graph>/vertices/<id>/both");
is(1, $c->outVcount(3), "outVcount for /graphs/<graph>/vertices/<id>/outCount");
is(1, $c->inVcount(3), "inVcount for /graphs/<graph>/vertices/<id>/inCount");
is(1, $c->bothVcount(3), "bothVcount for /graphs/<graph>/vertices/<id>/bothCount");
is("ok", $c->outIds(4), "outIds for /graphs/<graph>/vertices/<id>/outIds");
is("ok", $c->inIds(4), "inIds for /graphs/<graph>/vertices/<id>/inIds");
is("ok", $c->bothIds(4), "bothIds for /graphs/<graph>/vertices/<id>/bothIds");
is("ok", $c->get_all_edges, "get_all_edges for /graphs/<graph>/edges");
is("ok", $c->lookup_edges("name", "abc"), "lookup_edges for /graphs/<graph>/edges?key=<key>&value=<value>");
is("ok", $c->get_edge(1), "get_edge for /graphs/<graph>/edges/<id>");
is("ok", $c->outE(1), "outE for /graphs/<graph>/vertices/<id>/outE");
is("ok", $c->inE(1), "inE for /graphs/<graph>/vertices/<id>/inE");
is("ok", $c->bothE(1), "bothE for /graphs/<graph>/vertices/<id>/bothE");
is("ok", $c->get_indices, "get_indices for /graphs/<graph>/indices");
is("ok", $c->lookup_index("index", "name", "abc"), "lookup_index for /graphs/<graph>/indices/index?key=<key>&value=<value>");
is(1, $c->index_count("name", "abc"), "lookup_index for /graphs/<graph>/indices/count?key=<key>&value=<value>");

# POST
is("ok", $c->create_vertex(1), "create_vertex for /graphs/<graph>/vertices/<id>");
is("ok", $c->create_vertex_property(1, { "a" =>"b", "c" => "d"}), "create_vertex_property for /graphs/<graph>/vertices/<id>?<key>=<value>&<key'>=<value'>");
is("ok", $c->create_edge(1, "friend", 2, { "a" =>"b", "c" => "d"}), "create_edge for /graphs/<graph>/edges?_outV=<id>&_label=friend&_inV=2&<key>=<key'>");
is("ok", $c->create_edge_property(1, { "a" =>"b", "c" => "d"}), "update_edge_property for /graphs/<graph>/edges/<id>?<key>=<value>&<key'>=<value'>");
is("ok", $c->create_index("name"), "create_index for /graphs/<graph>/indices/index?class=vertex"); 

# PUT
is("ok", $c->replace_vertex_property(1, { "a" => "b" }), "replace_vertex_propery");
is("ok", $c->replace_edge_property(1, { "c" => "d" }), "replace_edge_propery");
#is("ok", $c->put_vertex_to_index(1, { "c" => "d" }), "replace_vertex_propery");

# DELETE
isa_ok($c->delete_vertex(1),"Test::MockObject", "delete_vertex");
isa_ok($c->delete_vertex_property(1, ["a", "b", "c" ]),"Test::MockObject", "delete_vertex_property");
isa_ok($c->delete_edge(1),"Test::MockObject", "delte_edge");
isa_ok($c->delete_edge_property(1, ["a", "b", "c" ]),"Test::MockObject", "delete_edge_property");
isa_ok($c->delete_index("abc"),"Test::MockObject", "delete_index");
isa_ok($c->delete_vertex_from_index(1,"abc", "ccc", "ddd"),"Test::MockObject", "delete_vertex_from_index");

is($c->_array_params_to_string(["a", "b", "c" ]), 'a&b&c', "_array_params_to_string");
is($c->_params_to_string({"a" => "b", "c" => "d"}), 'a=b&c=d', "_params_to_string");


diag( "Testing Net::Rexster $Net::Rexster::Client::VERSION" );
