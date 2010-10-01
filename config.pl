use Kamui;
use Twit::Container;
use Path::Class;

my $home = container('home');
my $host = 'twit.onagatani.com';

return +{
    view => {
        tt => +{
            path => $home->file('assets/tmpl')->stringify,
        },
    },
    plugins => +{
        session => +{
            state => +{
                class  => 'Kamui::Plugin::Session::State::Cookie',
                option => +{
                    cookie_name    => 'twit_sid',
                    cookie_domain  => $host, 
                    cookie_path    => '/',
                },
            },
            store => +{
                class  => 'Kamui::Plugin::Session::Store::Memcached',
                option => +{
                    servers    => [qw/localhost:11211/],
                    expire_for => 60 * 60, 
                },
            },
        },
    },
    datasource => +{
        dsn      => '',
        username => '',
        password => '',
    },
    twitter_api => +{
        api_key          => '',
        callback_url     => '',
        consumer_key     => '',
        consumer_secret  => '',
        request_token    => '',
        access_token_url => '',
        authorize_url    => '',
    },
    timezone => 'Asia/Tokyo',
};

