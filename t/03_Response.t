use Test::More tests => 9;

use Net::Rexster::Response;

my $content = {
         'queryTime' => '0.674048',
         'upTime' => '0.674048',
         'version'   => '2.1.0',
         'totalSize' => 2,
         'name'      => "test",
         'keys'      => 'key1',
         'graphs'    => "test",
         'results'   => [
                         {
                           'lang' => 'java',
                           '_id' => '3',
                           '_type' => 'vertex',
                           'name' => 'lop'
                         },
                         {
                           '_id' => '2',
                           '_type' => 'vertex',
                           'name' => 'vadas',
                           'age' => 27
                         },
                       ],
};

my $res = new Net::Rexster::Response(content => $content);

is ($res->get_name(), 'test', "get_name()");
is ($res->get_version(), '2.1.0', "get_version()");
is ($res->get_graphs(), 'test', "get_graphs()");
is ($res->get_queryTime(), '0.674048', "get_queryTime()");
is ($res->get_upTime(), '0.674048', "get_upTime()");
is (scalar @{$res->get_results()}, '2', "get_results()");
is ($res->get_totalSize(), '2', "get_totalSize()");
is ($res->get_keys() , 'key1', 'get_keys()');

is (scalar keys $res->get_conents(), 8, "get_contents()");  

