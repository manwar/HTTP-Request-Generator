#!perl -w
use strict;
use HTTP::Generator qw(generate_requests);
use Data::Dumper;

use Test::More tests => 3;

my @requests = generate_requests(
    method => 'POST',
    url    => '/feedback',
    post_params => {
        comment => ['Some comment', 'Another comment, A++'],
    },
    headers => [
    { "Content-Type" => 'text/plain; encoding=UTF-8', },
    ],
    wrap => \&HTTP::Generator::as_dancer,
);
is 0+@requests, 2, 'We generate parametrized POST requests';
isa_ok $requests[0], 'Dancer::Request', 'Returned data';
is $requests[0]->params('body')->{'comment'}, 'Some comment';