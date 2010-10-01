use Twit::Web::Handler;
use Twit::Container;
use Plack::Builder;

my $app = Twit::Web::Handler->new;
$app->setup;

my $home = container('home');
builder {
   enable "Plack::Middleware::Scope::Session";
   enable "Plack::Middleware::Static",
           path => qr{^/(images|js|css)/},
           root => $home->file('assets/htdocs')->stringify;

   $app->handler;
};
