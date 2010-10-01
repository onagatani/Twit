package Twit::Model::DB;
use DBIx::Skinny;
use Twit::Container;

sub master {
    my $class = shift;
    my $dsn = container('conf')->{datasource};
    my $model = $class->new($dsn);
    $model->do('SET NAMES utf8');
    return $model;
}

1;
__END__
