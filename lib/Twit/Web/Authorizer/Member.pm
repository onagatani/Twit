package Twit::Web::Authorizer::Member;
use Kamui;
use base 'Kamui::Web::Authorizer';
use Data::Dumper;

sub authorize {
    my($class, $c) = @_;

    my $member = $c->member;

    unless($member){
        $c->session->set('next_url' => $c->req->uri->path_query);
        return $c->redirect('/');
    }
    return;
}

1;
__END__
