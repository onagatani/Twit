package Twit::Web::Dispatcher;
use Kamui::Web::Dispatcher;

on '/' => run {
    return 'Root', 'index', FALSE, +{};
};

on '/(login)' => run {
    return 'Root', $1, FALSE, +{};
};

on '/regist/' => run {
    return 'Regist', 'index', FALSE, +{};
};

on '/regist/(confirm|finish|fail)' => run {
    return 'Regist', $1, FALSE, +{};
};

on '/member/' => run {
    return 'Member::Root', 'index', FALSE, +{};
};

on '/member/twitter/' => run {
    return 'Member::Twitter', 'index', FALSE, +{};
};

on '/member/twitter/(tweet|update|oauth|callback)' => run {
    return 'Member::Twitter', $1, FALSE, +{};
};

1;
__END__
