package Twit::Web::Validator::Twitter;
use Kamui::Web::Validator -base;

# engine is FormValidator::Lite
sub tweet {
    my $self = shift;

    $self->{engine}->check(
        text   => [qw/NOT_NULL/, [qw/LENGTH 1 140/]],
        user_id => [qw/NOT_NULL/],
    );
}

1;
