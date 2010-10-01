package Twit::Web::Context;
use Kamui;
use base 'Kamui::Web::Context';
use Twit::Container;
use Data::Dumper;

sub member {
    my ($self, $member) = @_;

    if ($member){
        my $row = $member->get_columns;
        $self->session->set(login_member => $row);
        return $member;
    }
    my $row = $self->session->get('login_member') or return;

    $member = container('db')->data2itr('member', [$row])->first;
    return $member;
}

1;
__END__
