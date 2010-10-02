package Twit::Web::Validator::Member;
use Kamui::Web::Validator -base;

# engine is FormValidator::Lite
sub regist {
    my $self = shift;

    $self->{engine}->load_constraints('Email');
    $self->{engine}->check(
        name   => [qw/NOT_NULL/, [qw/LENGTH 4 20/]],
        passwd => [qw/NOT_NULL ASCII/, [qw/LENGTH 4 12/]],
        email  => [qw/EMAIL_LOOSE/, [qw/LENGTH 5 256/]],
    );
}

1;
