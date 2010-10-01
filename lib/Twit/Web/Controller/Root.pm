package Twit::Web::Controller::Root;
use Kamui::Web::Controller -base;
use Twit::Container;
use Data::Dumper;

__PACKAGE__->add_trigger(
    'before_dispatch' => sub {
        my ($class, $c) = @_;
        return $c->redirect('/member/') if $c->member;
    }
);

sub do_index {
    my ($class, $c, $args) = @_;
    $c->stash->{fail} = $c->req->param('fail'); 
}

sub do_login {
    my ($class, $c, $args) = @_;

    my %param = map {$_ => $c->req->param($_)}
        qw/name passwd/;

    my $user = container('db')->single('member', \%param);

    if($user){
        my $member = $c->member($user) or warn 'login fail';

        my $next_url = $c->session->get('next_url') || '/member/';

        return $c->redirect($next_url);
    }
    else {
        return $c->redirect('/', {fail => 1});
    }
}

1;
__END__
