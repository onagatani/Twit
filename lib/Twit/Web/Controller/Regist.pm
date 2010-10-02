package Twit::Web::Controller::Regist;
use Kamui::Web::Controller -base;
use Twit::Container;
use Digest::SHA qw(sha1_hex);

sub do_index {
    my ($class, $c, $args) = @_;
    
    my %param = map {
        $_ => $c->req->param($_) || undef;
    } qw/name passwd email/;
    
    if ($c->req->is_post_request) {

        my $validator = $c->validator->valid('member')->regist;

        if(container('db')->count('member' , 'id', {name => $param{name}}) ){
            $validator->set_error('name' => 'DUPLICATION');
        }

        if ($validator->has_error) {

            $c->stash->{validator} = $validator;
            $c->fillin_fdat(\%param);           
        }
        else {
            $c->session->set('regist', \%param); 
            $c->redirect('/regist/confirm');
        }
    }
}

sub do_confirm {
    my ($class, $c, $args) = @_;

    my $param = $c->session->get('regist');
    $c->redirect('/regist/') unless $param; 

    $c->stash->{param} = $param;
}

sub do_finish {
    my ($class, $c, $args) = @_;

    my $param = $c->session->get('regist');
    $c->session->remove('regist'); 

    $c->redirect('/regist/') unless $param; 

    my $digest = sha1_hex($param->{passwd});
    $param->{passwd} = $digest;

    container('db')->create('member', $param);
}

1;
__END__
