#!/usr/bin/env perl

use lib "../lib/";
use Data::Dumper;
use Net::Rexster::Client;
use YAML;

#====================================
# This is for basic functional tests
# This requires to GraphDB + Rexster
#====================================

my $c = new Net::Rexster::Client(graph => "test");
#y $c = new Net::Rexster::Client(graph => "neo4jsample");

# delete
#for my $i (6..11) {
#    $c->delete_vertex("6:$i");
#}

print "=================================\n";
print "Creating vertex..\n";
$id1 = $c->create_vertex->{_id};
$id2 = $c->create_vertex->{_id};
print $id1 . " is created\n";
print "\nAdding Property\n";
$c->create_vertex_property($id1, { '生年月日' => '１２月２６日' });
$c->create_vertex_property($id2, { 'dateOfBirth' => 'Dec 26' });
print Dump $c->get_vertex($id1);
print Dump $c->get_vertex($id2);
$c->create_edge($id1, "friend", $id2);
print Dump $c->get_all_edges;
print "\nDeleting vertex " .  $id1 . "\n";
print Dump $c->delete_vertex($id1);
print Dump $c->delete_vertex($id2);
print Dump $c->get_all_vertices;
print Dump $c->get_all_edges;
print "\n=================================\n";
exit;

print Dumper $c->create_vertex_property('#6:3', { '生年月日' => '１２月２６日' });
print Dump $c->lookup_vertex('生年月日', '１２月２６日');
exit;

#print Dumper $c->get_graphs;
#print Dumper $c->get_graph;
#print Dumper $c->create_vertex;
print Dumper $c->get_all_vertices;
#print Dumper $c->create_vertex_property('1', { name => 'Shohei' });
#$c->create_edge('1', "friend", '2');
#print Dumper $c->create_edge_property('0', {'city' => 'Tokyo' } );
print Dumper $c->get_all_edges;
exit;

##$c->create_vertex_property('6:2', {'age' => 30, 'sex' => 'male'});
#print Dumper $c->get_all_vertices;
##print Dumper $c->lookup_vertex('age',30);
##print Dumper $c->get_all_edges;
###$c->delete_edge('6:2');
print Dumper $c->outV('6:2');
#$c->delete_vertex('6:2');
print Dumper $c->inV('6:2');
print Dumper $c->bothV('6:2');
print Dumper $c->outVcount('6:1');
print Dumper $c->inVcount('6:2');
print Dumper $c->bothVcount('6:2');
print Dumper $c->outIds('6:1');
print Dumper $c->inIds('6:2');
print Dumper $c->bothIds('6:2');
print Dumper $c->lookup_edges('city', 'Tokyo');
print Dumper $c->outE('6:0');
print Dumper $c->inE('6:1');
print Dumper $c->bothE('6:1');
#print Dumeper $c->create_index('Osaka');
## print Dumper $c->lookup_index('city', 'Tokyo');
#print Dumper $c->index_count
#print Dumper $c->create_vertex_index('test');
#print Dumper $c->create_edge_index('test2');

#print Dumper $c->replace_edge_property('7:0', { 'city' => 'Kobe' });
#print Dumper $c->create_edge('6:1', "abc", '6:2');
#print Dumper $c->create_edge_property('7:0', { 'city' => 'Yokohama' });
#print Dumper $c->get_edge('7:0');
#print Dumper $c->delete_edge('7:0');
print Dumper $c->get_all_vertices;
#print Dumper $c->delete_vertex_property('6:2', [ 'age', 'sex' ] );
#print Dumper $c->_array_params_to_string(['age', 'sex']);
#print Dumper $c->_params_to_string({'age' => 20 });
#print Dumper $c->delete_index_with_key
#print Dumper $c->delete_edge_property('7:0', ['city']);
#print Dumper $c->create_vertex;
#print Dumper $c->delete_vertex('6:3');
#print Dumper $c->get_vertex('6:3');
#print Dumper $c->get_vertex('6:3');
#print Dumper $c->replace_vertex_property('6:3', {name => 'Kameda'});
#print Dumper $c->get_vertex('6:3');

## no reply... why?
#print Dumper $c->get_vertex_indices();
#print Dumper $c->get_edge_indices();

#print Dumper $c->create_index("WHAT");
#$VAR1 = {
#          'name' => 'WHAT',
#          'class' => 'vertex'
#        };
print Dumper $c->get_indices();
#$VAR1 = [
#          {
#            'name' => 'WHAT',
#            'class' => 'vertex'
#          },
#          {
#            'name' => 'city',
#            'class' => 'vertex'
#          },
#          {
#            'name' => 'Osaka',
#            'class' => 'vertex'
#          }
#        ];
#print Dumper $c->delete_index('city');
# delete_index can delete 'Osaka' in the above. 
#print Dumper $c->put_vertex_to_index('6:3', 'WHAT', 'e', 'f');
print Dumper $c->lookup_index('WHAT','a','b');
print Dumper $c->lookup_index('WHAT','c','d');
#print Dumper $c->delete_vertex_from_index('6:3', 'WHAT', 'e', 'f');
print Dumper $c->index_keys();
#print Dumper $c->get_vertex_indices();
print Dumper $c->get_edge_indices();
#print Dumper $c->get_indices();
#print Dumper $c->create_vertex_index('');
