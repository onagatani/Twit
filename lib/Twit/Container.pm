package Twit::Container;
use Kamui::Container -base;

register db => sub {
    my $self = shift;
    $self->load_class('Twit::Model::DB');
    return Twit::Model::DB->master;
};

register timezone => sub {
    my $self = shift;
    $self->load_class('DateTime::TimeZone');
    DateTime::TimeZone->new(name => 'Asia/Tokyo');
};

1;
__END__
