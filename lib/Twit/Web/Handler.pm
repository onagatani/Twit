package Twit::Web::Handler;
use Kamui::Web::Handler;

use_container 'Twit::Container';
use_context 'Twit::Web::Context';
use_dispatcher 'Twit::Web::Dispatcher';
use_plugins [qw/Encode Session FormValidatorLite/];
use_view 'Kamui::View::TT';

1;
