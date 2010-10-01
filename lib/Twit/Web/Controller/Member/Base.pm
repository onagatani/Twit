package Twit::Web::Controller::Member::Base;
use Kamui::Web::Controller -base;
use Twit::Container;

__PACKAGE__->authorizer('+Twit::Web::Authorizer::Member');

__PACKAGE__->add_trigger(
    'before_dispatch' => sub {
        my ($class, $c) = @_;
        $c->stash->{member} = $c->member;
    }
);

1;
__END__
