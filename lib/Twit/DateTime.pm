package Twit::DateTime;
use strict;
use base qw/DateTime/;
use DateTime::Format::Strptime;
use DateTime::TimeZone;
use UNIVERSAL::require;
use Carp qw/croak/;
use Encode;
use Twit::Container;

sub now {
    my ($class, $date) = @_;
    my $now = $class->SUPER::now(time_zone => container('timezone')); 
    return $now;
}

sub strptime {
    my($class, $date, $pt) = @_;
    my $format = DateTime::Format::Strptime->new(
        pattern   => $pt,
        time_zone => container('timezone'),
    );
    my $dt = $format->parse_datetime($date);

    if($dt){
        return bless $dt, $class;
    } else {
        return;
    }
}

sub to_format {
    my ($self, $format) = @_;
    my $module = "DateTime::Format::$format";
    $module->require or croak($@);
    
    return  $module->format_datetime($self);
}

sub from_format {
    my ($class, $format, $date) = @_;
    my $module = "DateTime::Format::$format";
    $module->require or croak($@);
    
    my $dt = $module->parse_datetime($date);
    return bless $dt, $class;
}

1;
__END__
