package Twit::Model::DB::Schema;
use DBIx::Skinny::Schema;
use Twit::Container;
use Twit::DateTime;

sub pre_insert_hook {
    my ( $class, $args ) = @_;
    my $dt = Twit::DateTime->now->to_format('MySQL');
    $args->{created_at} = $dt;
    $args->{updated_at} = $dt;
}

sub pre_update_hook {
    my ( $class, $args ) = @_;
    my $dt = Twit::DateTime->now->to_format('MySQL');
    $args->{updated_at} = $dt;
}

install_table member => schema {
    pk 'id';
    columns qw/id name passwd email created_at updated_at/;
    trigger pre_insert => \&pre_insert_hook;
    trigger pre_update => \&pre_update_hook;
};

install_table twitter => schema {
    pk 'id';
    columns qw/id member_id user_id screen_name access_token access_token_secret status created_at updated_at/;
    trigger pre_insert => \&pre_insert_hook;
    trigger pre_update => \&pre_update_hook;
};

install_utf8_columns qw/name text/;

install_inflate_rule '^.+_(?:at|datetime)$' => callback {
    inflate {
        return Twit::DateTime->from_format('MySQL', shift);
    };
};

1;
__END__
