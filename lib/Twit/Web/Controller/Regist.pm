package Twit::Web::Controller::Regist;
use Kamui::Web::Controller -base;
use Twit::Container;

sub do_index {
    my ($class, $c, $args) = @_;
    $c->fillin_fdat($c->session->get('regist'));
}

sub do_confirm {
    my ($class, $c, $args) = @_;

    my %param = map { $_ => $c->req->param($_) }
        qw/name passwd email/;

    $c->session->set('regist', \%param); 
    $c->stash->{regist} = \%param;
}

sub do_finish {
    my ($class, $c, $args) = @_;
    my $param = $c->session->get('regist');
    $c->session->remove('regist'); 

    #XXX validate
    container('db')->create('member', $param);
}

1;
__END__
