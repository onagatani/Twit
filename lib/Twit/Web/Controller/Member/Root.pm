package Twit::Web::Controller::Member::Root;
use Kamui::Web::Controller -base;
use Twit::Container;

__PACKAGE__->authorizer('+Twit::Web::Authorizer::Member');

__PACKAGE__->add_trigger(
    'before_dispatch' => sub {
        my ($class, $c) = @_;
        $c->stash->{member} = $c->member;
    }
);

sub do_index {
    my ($class, $c, $args) = @_;
    my $list = container('db')->search('twitter', {
        member_id => $c->member->id,
    });
    $c->stash->{list} = $list;
}

1;
__END__
