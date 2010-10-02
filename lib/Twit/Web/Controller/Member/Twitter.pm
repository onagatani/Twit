package Twit::Web::Controller::Member::Twitter;
use Kamui::Web::Controller -base;
use Twit::Container;
use Net::Twitter::Lite;

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
        member_id => $c->member->id
    });
    $c->stash->{list} = $list;
}

sub do_tweet {
    my ($class, $c, $args) = @_;

    $c->stash->{user_id} = $c->req->param('user_id') or $c->redirect('/member/twitter/');

    my $token = container('db')->single('twitter', {
        member_id => $c->member->id,
        user_id   => $c->req->param('user_id'),
    });
    $c->redirect('/member/twitter/') unless $token;

    my $twitter = _new_twitter($token);

    $c->stash->{update} = $c->req->param('update');
    $c->stash->{timeline} = $twitter->user_timeline;
}

sub do_update {
    my ($class, $c, $args) = @_;

    my $text    = $c->req->param('text');
    my $user_id = $c->req->param('user_id');

    $args->{user_id} = $user_id;

    if ($c->req->is_post_request) {

        my $validator = $c->validator->valid('twitter')->tweet;

        if ($validator->has_error) {
            $c->stash->{validator} = $validator;
        }
        else {
            my $token = container('db')->single('twitter', {
                member_id => $c->member->id,
                user_id   => $user_id,
            });

            if(my $twitter = _new_twitter($token)){
                $twitter->update({ status => $text }); 
                $args->{update} = 1;
            }
        }
    }
    $c->redirect('/member/twitter/tweet', $args);
}

sub do_oauth {
    my ($class, $c, $args) = @_;

    my $twitter = _new_twitter();

    my $callback_url = container('conf')->{twitter_api}->{callback_url};

    my $url = $twitter->get_authorization_url(callback => $callback_url);

    $c->redirect($url);
}

sub do_callback {
    my ($class, $c, $args) = @_;

    my $twitter = _new_twitter(); 
    
    my ($access_token, $access_token_secret, $user_id, $screen_name) = 
    $twitter->request_access_token(
        token        => $c->req->param('oauth_token'),
        verifier     => $c->req->param('oauth_verifier'),
        token_secret => '',
    );

    my $token_param = +{
        access_token        => $access_token,
        access_token_secret => $access_token_secret,
        screen_name         => $screen_name,
    };

    my $member_param = +{
        member_id => $c->member->id,
        user_id   => $user_id,
    };

    $twitter = container('db')->single('twitter', $member_param);
    if($twitter){
        $twitter->update($token_param);
    }
    else {
        container('db')->create('twitter',{
            %$member_param,
            %$token_param,
        });
    }
    $c->redirect('/member/twitter/');
}

sub _new_twitter {
    my $token = shift;
    my %consumer = map { $_ => container('conf')->{twitter_api}->{$_} }
        qw/consumer_key consumer_secret/;
    my $twitter = Net::Twitter::Lite->new(%consumer);

    if($token){
        $twitter->access_token($token->access_token);
        $twitter->access_token_secret($token->access_token_secret);
    }

    return $twitter;
}

1;
__END__
