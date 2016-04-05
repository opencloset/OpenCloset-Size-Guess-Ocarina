package OpenCloset::Size::Guess::OpenCPU::RandomForest;
# ABSTRACT: OpenCloset::Size::OpenCPU::RandomForest driver for the Ocarina

use utf8;

use Moo;
use Types::Standard qw( Str Int );

our $VERSION = '0.005';

with 'OpenCloset::Size::Guess::Role::Base';

use HTTP::Tiny;
use JSON;
use Try::Tiny;
use List::MoreUtils qw/ all mesh /;

#
# to support HTTPS
#

use IO::Socket::SSL;
use Mozilla::CA;
use Net::SSLeay;

#<<< skip perltidy
has url         => ( is => 'ro', isa => Str, default => 'https://opencpu.theopencloset.net/ocpu/tmp/ocarina/R/size/json' );
has bust        => ( is => 'ro', isa => Int );
has waist       => ( is => 'ro', isa => Int );
has topbelly    => ( is => 'ro', isa => Int );
has thigh       => ( is => 'ro', isa => Int, default => 0 );
has hip         => ( is => 'ro', isa => Int, default => 0 );
has arm         => ( is => 'ro', isa => Int );
has leg         => ( is => 'ro', isa => Int );
#>>>

sub guess {
    my $self = shift;

    my %ret = (
        height   => $self->height,
        weight   => $self->weight,
        gender   => $self->gender,
        arm      => undef,
        bust     => undef,
        foot     => undef,
        hip      => undef,
        knee     => undef,
        leg      => undef,
        thigh    => undef,
        topbelly => undef,
        waist    => undef,
        belly    => undef,
        success  => 0,
        reason   => q{},
    );

    my %params = (
        g        => sprintf( q{'%s'}, $self->gender ),
        height   => $self->height,
        weight   => $self->weight,
        bust     => $self->bust,
        waist    => $self->waist,
        topbelly => $self->topbelly,
        thigh    => $self->thigh,
        hip      => $self->hip,
        arm      => $self->arm,
        leg      => $self->leg,
    );

    my $http = HTTP::Tiny->new();
    my $guess = $http->post_form( $self->url, \%params );
    unless ( $guess->{success} ) {
        $ret{reason} = "$guess->{status}: $guess->{content}";
        return \%ret;
    }

    my $data = try { JSON::decode_json( $guess->{content} ) };
    unless ($data) {
        $ret{reason} = "failed to decode json string: $guess->{content}";
        return \%ret;
    }

    while ( my ( $k, $v ) = each %{$data} ) {
        my @keys = keys %{$v};
        my @values = map { $_->[0] } values %{$v};

        %ret = ( %ret, mesh @keys, @values );
    }

    return { %ret, success => 1 };
}

1;

# COPYRIGHT

__END__

=for Pod::Coverage BUILDARGS

=head1 SYNOPSIS
    use OpenCloset::Size::Guess;

    my $guesser = OpenCloset::Size::Guess->new(
        'OpenCPU::RandomForest',
        gender     => 'male',
        height     => 183,
        weight     => 82,
        _bust      => 102,
        _waist     => 88,
        _topbelly  => 85,
        _thigh     => 61,
        _arm       => 64,
        _leg       => 105,
    );

    my $result = $guesser->guess;

    print "bust     : $result->{bust}\n";
    print "topbelly : $result->{topbelly}\n";
    print "arm      : $result->{arm}\n";
    print "waist    : $result->{waist}\n";
    print "thigh    : $result->{thigh}\n";


=head1 DESCRIPTION

This module is a L<OpenCloset::Size::Guess> driver for the Ocarina(OpenCPU based R Rest interface) service.


=attr height

=attr weight

=attr gender

=attr url

=attr bust

=attr waist

=attr topbelly

=attr thigh

=attr hip

=attr arm

=attr leg

=method guess

=head1 SEE ALSO

=for :list
* L<Search issue|https://github.com/opencloset/opencloset/issues/627>
* L<Refactoring R - Ocarina|https://github.com/yongbin/refactoring-r>
* L<OpenCloset::Size::Guess>
* L<SMS::Send>
* L<Parcel::Track>
