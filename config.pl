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
                class => 'Kamui::Plugin::Session::State::Cookie',
                option => +{
                    cookie_name => 'twit_sid',
                    cookie_domain => $host,
                    cookie_path => '/',
                },
            },
            store => +{
                class => 'Kamui::Plugin::Session::Store::Memcached',
                option => +{
                    servers => [qw/localhost:11211/],
                    expire_for => 60 * 60,
                },
            },
        },
    },
    datasource => +{
        dsn => '',
        username => '',
        password => '',
    },
    twitter_api => +{
        api_key => '',
        callback_url => '',
        consumer_key => '',
        consumer_secret => '',
        request_token => '',
        access_token_url => '',
        authorize_url => '',
    },
    validator_message => +{
        param => +{
            passwd  => 'パスワード',
            name    => '名前',
            text    => '本文',
            email   => 'Email',
            user_id => 'Twitter UserID',
        },
        function => +{
            not_null    => '[_1]が空です',
            'length'    => '[_1]の入力値がオーバーしています',
            email_loose => '[_1]がEmailとして正しくありません',
            ascii       => '[_1]に半角英数字以外が入力されています',
            duplication => '[_1]が既に登録されています',
        },
        message => +{
        },
    },
    timezone => 'Asia/Tokyo',
};
